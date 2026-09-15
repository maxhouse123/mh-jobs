-- 目的地: 由 CC 经 jobs/db-run.sh 执行 【JOB-2-08 迁移】替换通知书 + 撤销派单(软撤销)
-- 裁决3(撤销派单→回可派池): reviewer_assignments 无状态列且红线/执行器禁 DELETE,
--   故采「软撤销」——加 revoked_at/revoked_by/revoke_reason 三列, 撤销=置 revoked_at(UPDATE 非 DELETE);
--   前端三处读 reviewer_assignments 的查询过滤 revoked_at is null → 该件回可派池。
-- 两个 SECURITY DEFINER 函数(is_admin 门 + 写 admin_events), + offer-letters 桶 admin insert 策略(原无)。
-- 纯新增(ADD COLUMN / CREATE FUNCTION / CREATE POLICY), 无删除。可重复执行。
-- 注: reviewer_assignments.doc_id 与 documents.doc_id 均 text, 故 admin_revoke_dispatch 参数用 text。
begin;

-- ① 跑前计数
select 'BEFORE · reviewer_assignments 列数' as 项, count(*)::text as 值
  from information_schema.columns where table_schema='public' and table_name='reviewer_assignments';
select 'BEFORE · 本卡两函数数(应0)' as 项, count(*)::text as 值
  from pg_proc where proname in ('admin_replace_offer_letter','admin_revoke_dispatch');

-- ② 软撤销三列
alter table public.reviewer_assignments add column if not exists revoked_at timestamptz;
alter table public.reviewer_assignments add column if not exists revoked_by uuid;
alter table public.reviewer_assignments add column if not exists revoke_reason text;

-- ③ 替换通知书(旧路径进审计, 旧文件留桶)
create or replace function public.admin_replace_offer_letter(p_offer_id uuid, p_new_path text, p_reason text)
returns jsonb language plpgsql security definer set search_path to 'public' as $fn$
declare _o public.offer_decisions;
begin
  if not public.is_admin(auth.uid()) then raise exception 'admin_replace_offer_letter: admin only'; end if;
  select * into _o from public.offer_decisions where id = p_offer_id;
  if not found then raise exception 'admin_replace_offer_letter: offer not found'; end if;
  insert into public.admin_events (event_type, actor_uid, student_id, detail)
  values ('letter_replaced', auth.uid(), _o.student_id,
          jsonb_build_object('offer_id', _o.id, 'old_path', _o.letter_file_path, 'new_path', p_new_path, 'reason', p_reason));
  update public.offer_decisions
     set letter_file_path = p_new_path, letter_uploaded_at = now(), last_updated_by = 'admin', last_updated_at = now()
   where id = p_offer_id;
  return jsonb_build_object('ok', true, 'offer_id', _o.id, 'old_path', _o.letter_file_path);
end; $fn$;

-- ④ 撤销派单(软撤销: 置 revoked_at, 回可派池; 不删派单记录)
create or replace function public.admin_revoke_dispatch(p_doc_id text, p_reason text)
returns jsonb language plpgsql security definer set search_path to 'public' as $fn$
declare _n int; _sid uuid;
begin
  if not public.is_admin(auth.uid()) then raise exception 'admin_revoke_dispatch: admin only'; end if;
  select student_id into _sid from public.documents where doc_id = p_doc_id;
  update public.reviewer_assignments
     set revoked_at = now(), revoked_by = auth.uid(), revoke_reason = p_reason
   where doc_id = p_doc_id and revoked_at is null;
  get diagnostics _n = row_count;
  insert into public.admin_events (event_type, actor_uid, student_id, detail)
  values ('dispatch_revoked', auth.uid(), _sid,
          jsonb_build_object('doc_id', p_doc_id, 'reason', p_reason, 'affected', _n));
  return jsonb_build_object('ok', true, 'affected', _n);
end; $fn$;

-- ⑤ offer-letters 桶 admin insert 策略(原仅 school insert; 替换通知书需 admin 能上传)
drop policy if exists offer_letters_admin_write on storage.objects;
create policy offer_letters_admin_write on storage.objects
  for insert to authenticated
  with check ( bucket_id = 'offer-letters' and public.is_admin(auth.uid()) );

-- ⑥ 权限
revoke execute on function public.admin_replace_offer_letter(uuid, text, text) from public, anon, authenticated;
grant  execute on function public.admin_replace_offer_letter(uuid, text, text) to authenticated;
revoke execute on function public.admin_revoke_dispatch(text, text) from public, anon, authenticated;
grant  execute on function public.admin_revoke_dispatch(text, text) to authenticated;

-- ⑦ 跑后计数(列 +3, 函数 +2)
select 'AFTER · reviewer_assignments 列数' as 项, count(*)::text as 值
  from information_schema.columns where table_schema='public' and table_name='reviewer_assignments';
select 'AFTER · 本卡两函数数(应2)' as 项, count(*)::text as 值
  from pg_proc where proname in ('admin_replace_offer_letter','admin_revoke_dispatch');
select 'AFTER · offer_letters_admin_write 策略(应1)' as 项, count(*)::text as 值
  from pg_policies where schemaname='storage' and tablename='objects' and policyname='offer_letters_admin_write';

commit;
