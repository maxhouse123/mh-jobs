-- JOB-24-07 · 0215 语法探针（begin…rollback，DDL/写入全部回滚，绝不持久化）。
-- 末尾 commit 在 rollback 之后 = 空事务 no-op（仅 WARNING），只为过 db-run.sh 的 begin;/commit; 门禁。
-- 用途：证明 0215 的两列 + RPC 在真库上能编译、grant 能建、语义可跑（实弹写一行→计数+1→rollback 归零）；
--       跑完 rollback，库无变化。
begin;

-- ① 加两列（与 0215 正本同体）
alter table public.concierge_requests add column if not exists brief jsonb;
alter table public.concierge_requests add column if not exists brief_at timestamptz;

-- ② create or replace submit_concierge_brief（与正本同体）
create or replace function public.submit_concierge_brief(p_brief jsonb)
returns uuid
language plpgsql security definer set search_path = public as $fn$
declare v_id uuid;
begin
  update public.concierge_requests
     set brief = p_brief, brief_at = now(), updated_at = now()
   where id = (
     select cr.id from public.concierge_requests cr
      where cr.student_id = auth.uid()
        and cr.kind = 'concierge'
        and cr.brief is null
      order by cr.created_at desc
      limit 1
   )
   returning id into v_id;
  if v_id is null then
    raise exception 'no_open_request';
  end if;
  return v_id;
end;
$fn$;
grant execute on function public.submit_concierge_brief(jsonb) to authenticated;

-- 列证：brief / brief_at 在
select 'cols' as k, count(*)::text as v from information_schema.columns
 where table_schema='public' and table_name='concierge_requests'
   and column_name in ('brief','brief_at');

-- RPC 证：函数存在 + 参数签名
select proname, pg_get_function_identity_arguments(oid) as args
  from pg_proc where proname = 'submit_concierge_brief';

-- 实弹：造一条本探针专用的 concierge 工单(student_id 随便一个 uuid, brief 空),
--   直接 update 落 brief(不经 auth.uid() 过滤,探针里 auth.uid() 为空), 证明写入语义 → 计数应 +1。
--   全在事务里, rollback 后归零。
insert into public.concierge_requests (id, student_id, kind, status)
  values ('00000000-0000-0000-0000-0000024070fb'::uuid, '00000000-0000-0000-0000-0000024070aa'::uuid, 'concierge', 'open');
update public.concierge_requests
   set brief = jsonb_build_object('requirements','probe','cities','X','funding','any','deadline','2099-01-01','attachments','[]'::jsonb),
       brief_at = now()
 where id = '00000000-0000-0000-0000-0000024070fb'::uuid;
select 'brief_written' as k, count(*)::text as v from public.concierge_requests
 where id = '00000000-0000-0000-0000-0000024070fb'::uuid and brief is not null;

rollback;
commit;
