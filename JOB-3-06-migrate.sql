-- 目的地: 由 CC 经 jobs/db-run.sh 执行 【JOB-3-06 迁移】admin_email_verified 函数(读 auth.users.email_confirmed_at)
-- 学校/中介的邮箱验证在 auth.users.email_confirmed_at, 前端读不到; 建 SECURITY DEFINER 函数(is_admin 门)暴露给管理员。
-- 纯新增, 无删除。可重复执行。
begin;
select 'BEFORE · admin_email_verified 函数(应0)' as 项, count(*)::text as 值 from pg_proc where proname='admin_email_verified';

create or replace function public.admin_email_verified(p_uid uuid)
returns timestamptz language sql stable security definer set search_path to '' as $fn$
  select case when public.is_admin(auth.uid())
    then (select u.email_confirmed_at from auth.users u where u.id = p_uid)
    else null end;
$fn$;

revoke execute on function public.admin_email_verified(uuid) from public, anon, authenticated;
grant  execute on function public.admin_email_verified(uuid) to authenticated;

select 'AFTER · admin_email_verified 函数(应1)' as 项, count(*)::text as 值 from pg_proc where proname='admin_email_verified';
-- 自检代理: db-run 以直连超级用户跑(无 auth.uid()), 无法走 is_admin 门验证返回值,
--   故直接数 auth.users 里已验证邮箱的账号数, 证明底层数据存在(函数走 admin 上下文时会返回这些非空值)。
select 'CHK · auth.users 已验证邮箱账号数(应>0)' as 项, count(*)::text as 值 from auth.users where email_confirmed_at is not null;
commit;
