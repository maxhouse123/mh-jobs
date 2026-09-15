-- 【JOB-2-12 迁移·补】给现有 school_access_log(EF 取件日志·666行) 加管理员只读策略
-- 原因: 该表 RLS 开·0 策略(默认拒), 管理员前端读不到; 「行为日志页并起来读」需管理员能读它。
-- 只加 SELECT 策略(只读), 不改其数据/结构/其它策略。纯新增, 可重复执行。
begin;
select 'BEFORE · school_access_log admin 策略' as 项, count(*)::text as 值
  from pg_policies where schemaname='public' and tablename='school_access_log' and policyname='admin_read_school_access_log_legacy';
drop policy if exists admin_read_school_access_log_legacy on public.school_access_log;
create policy admin_read_school_access_log_legacy on public.school_access_log
  for select using ( public.is_admin(auth.uid()) );
select 'AFTER · school_access_log admin 策略(应1)' as 项, count(*)::text as 值
  from pg_policies where schemaname='public' and tablename='school_access_log' and policyname='admin_read_school_access_log_legacy';
commit;
