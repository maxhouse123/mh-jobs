-- 目的地: Supabase → SQL Editor 【JOB-09 回滚】撤销 application_rounds 管理员只读策略
-- 说明: 只删本迁移新增的那一条策略, 不动表结构/数据/其它策略/RLS 开关。

select 'BEFORE 回滚 · 策略数' as 项, count(*)::text as 值
  from pg_policies where schemaname = 'public' and tablename = 'application_rounds';

drop policy if exists admin_read_application_rounds on public.application_rounds;

select 'AFTER 回滚 · 策略数(应比 BEFORE 少 1)' as 项, count(*)::text as 值
  from pg_policies where schemaname = 'public' and tablename = 'application_rounds';
