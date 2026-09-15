-- 目的地: 由 CC 经 jobs/db-run.sh 执行 【JOB-2-07 迁移】材料软删 + 解锁材料槽
-- 裁决2(软删): documents 加 deleted_at/deleted_by/delete_reason + slot_reopened_at 四列;
--   两个 SECURITY DEFINER 函数(is_admin 门 + 写 admin_events), revoke public/anon/authenticated 再 grant authenticated。
-- 纯新增(ADD COLUMN / CREATE FUNCTION), 无删除。可重复执行。
-- 注: documents.doc_id 实为 text(非 uuid), 故 admin_delete_document 参数用 text。锁槽状态库内无专列,
--     故新增 slot_reopened_at 作「已解锁」标记(不删旧件/不删裁决, 非破坏性)。
begin;

-- ① 跑前计数
select 'BEFORE · documents 列数' as 项, count(*)::text as 值
  from information_schema.columns where table_schema='public' and table_name='documents';
select 'BEFORE · 本卡两函数数(应0)' as 项, count(*)::text as 值
  from pg_proc where proname in ('admin_delete_document','admin_reopen_doc_slot');

-- ② 加四列(软删三列 + 解锁标记)
alter table public.documents add column if not exists deleted_at timestamptz;
alter table public.documents add column if not exists deleted_by uuid;
alter table public.documents add column if not exists delete_reason text;
alter table public.documents add column if not exists slot_reopened_at timestamptz;

-- ③ 软删函数
create or replace function public.admin_delete_document(p_doc_id text, p_reason text)
returns jsonb language plpgsql security definer set search_path to 'public' as $fn$
declare _d public.documents;
begin
  if not public.is_admin(auth.uid()) then raise exception 'admin_delete_document: admin only'; end if;
  select * into _d from public.documents where doc_id = p_doc_id;
  if not found then raise exception 'admin_delete_document: doc not found'; end if;
  if _d.deleted_at is not null then
    return jsonb_build_object('ok', true, 'idempotent', true, 'doc_id', _d.doc_id);
  end if;
  update public.documents
     set deleted_at = now(), deleted_by = auth.uid(), delete_reason = p_reason
   where doc_id = p_doc_id;
  insert into public.admin_events (event_type, actor_uid, student_id, detail)
  values ('doc_deleted', auth.uid(), _d.student_id,
          jsonb_build_object('doc_id', _d.doc_id, 'doc_type', _d.doc_type, 'file_name', _d.file_name, 'reason', p_reason));
  return jsonb_build_object('ok', true, 'doc_id', _d.doc_id);
end; $fn$;

-- ④ 解锁材料槽函数(非破坏性: 置 slot_reopened_at 标记, 不删旧件/裁决)
create or replace function public.admin_reopen_doc_slot(p_student_id uuid, p_doc_type text, p_reason text)
returns jsonb language plpgsql security definer set search_path to 'public' as $fn$
declare _n int;
begin
  if not public.is_admin(auth.uid()) then raise exception 'admin_reopen_doc_slot: admin only'; end if;
  update public.documents
     set slot_reopened_at = now()
   where student_id = p_student_id and doc_type = p_doc_type and deleted_at is null;
  get diagnostics _n = row_count;
  insert into public.admin_events (event_type, actor_uid, student_id, detail)
  values ('slot_reopened', auth.uid(), p_student_id,
          jsonb_build_object('doc_type', p_doc_type, 'reason', p_reason, 'affected', _n));
  return jsonb_build_object('ok', true, 'affected', _n);
end; $fn$;

-- ⑤ 权限: 先 revoke 全体再 grant authenticated(函数内 is_admin 门二次把关)
revoke execute on function public.admin_delete_document(text, text) from public, anon, authenticated;
grant  execute on function public.admin_delete_document(text, text) to authenticated;
revoke execute on function public.admin_reopen_doc_slot(uuid, text, text) from public, anon, authenticated;
grant  execute on function public.admin_reopen_doc_slot(uuid, text, text) to authenticated;

-- ⑥ 跑后计数(列 +4, 函数 +2)
select 'AFTER · documents 列数' as 项, count(*)::text as 值
  from information_schema.columns where table_schema='public' and table_name='documents';
select 'AFTER · 本卡两函数数(应2)' as 项, count(*)::text as 值
  from pg_proc where proname in ('admin_delete_document','admin_reopen_doc_slot');

commit;
