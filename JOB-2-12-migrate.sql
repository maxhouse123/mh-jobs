-- 目的地: 【JOB-2-12 迁移·已备好但未执行】留痕 A(裁决9: 对学校可见)
-- ⚠⚠ 停工原因(P2 图纸↔现实冲突): 库里已存在 school_access_log 表, 但它是【另一张不相干的表】——
--   EF/水印取件审计日志(列: id bigint, school_uid, sc_code, doc_id, file_kind, outcome; 666 行真实数据; RLS 开·0策略)。
--   JOB-14 设计的行为日志表若用 school_access_log 会与之撞名且 schema 完全不同(设计要 school_id 列, 现有表没有),
--   create if not exists 会跳过建表致索引失败(已实测 rc=3)。红线禁改/删现有 666 行的表。
-- 处置: 本迁移改用不撞名的 school_action_log(其余照 JOB-14 设计), 但【未执行】, 等业主确认表名后再跑。
--   业主若坚持 school_access_log, 需先决定如何处理现有 EF 日志表(改名/共存)——那属破坏性操作, 必须业主拍板。
-- 本文件仅备好, CC 未经 db-run 执行(见 report.md)。
begin;

select 'BEFORE · school_action_log 表(应0)' as 项, count(*)::text as 值
  from information_schema.tables where table_schema='public' and table_name='school_action_log';

create table if not exists public.school_action_log (
  id         uuid primary key default gen_random_uuid(),
  school_id  uuid not null references public.schools(id),
  actor_uid  uuid not null,
  action     text not null,
  student_id uuid references public.students(id),
  detail     jsonb,
  created_at timestamptz not null default now()
);
create index if not exists idx_sactl_school  on public.school_action_log (school_id, created_at desc);
create index if not exists idx_sactl_student on public.school_action_log (student_id);

revoke all on public.school_action_log from public, anon, authenticated;
alter table public.school_action_log enable row level security;
grant select on public.school_action_log to authenticated;

drop policy if exists admin_read_school_action_log on public.school_action_log;
create policy admin_read_school_action_log on public.school_action_log
  for select using ( public.is_admin(auth.uid()) );

drop policy if exists school_read_own_action_log on public.school_action_log;
create policy school_read_own_action_log on public.school_action_log
  for select using ( school_id in (select school_id from public.school_members where user_id = auth.uid()) );

create or replace function public.log_school_access(p_action text, p_student_id uuid, p_detail jsonb)
returns void language plpgsql security definer set search_path to 'public' as $fn$
declare _sid uuid;
begin
  select school_id into _sid from public.school_members where user_id = auth.uid() limit 1;
  if _sid is null then raise exception 'log_school_access: not a school member'; end if;
  insert into public.school_action_log(school_id, actor_uid, action, student_id, detail)
  values (_sid, auth.uid(), p_action, p_student_id, p_detail);
end; $fn$;

revoke execute on function public.log_school_access(text, uuid, jsonb) from public, anon, authenticated;
grant  execute on function public.log_school_access(text, uuid, jsonb) to authenticated;

select 'AFTER · school_action_log 表(应1)' as 项, count(*)::text as 值
  from information_schema.tables where table_schema='public' and table_name='school_action_log';

commit;
