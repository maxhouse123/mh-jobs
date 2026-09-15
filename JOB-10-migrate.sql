-- 目的地: Supabase → SQL Editor 【JOB-10 迁移】task_candidates 加管理员只读策略
-- 目的: 管理端「招生任务」页要看每个任务的候选池, 但 task_candidates 零 RLS 策略,
--       管理员直查读不到(学校侧走 get_task_candidates SECURITY DEFINER RPC, 不受影响)。
--       本迁移只加一条 for select 策略(照抄现役 is_admin(auth.uid()) 写法), 纯新增。
-- 可重复执行。

-- ① 跑之前先数该表现有策略数(记下):
select 'BEFORE · task_candidates 策略数' as 项, count(*)::text as 值
  from pg_policies where schemaname = 'public' and tablename = 'task_candidates';

-- ② 管理员只读策略(仅 for select)
drop policy if exists admin_read_task_candidates on public.task_candidates;
create policy admin_read_task_candidates
  on public.task_candidates
  for select
  using ( public.is_admin(auth.uid()) );

-- ③ 跑之后再数(与 BEFORE 差值应为 1):
select 'AFTER · task_candidates 策略数' as 项, count(*)::text as 值
  from pg_policies where schemaname = 'public' and tablename = 'task_candidates';

-- ④ 自检:
select policyname, cmd from pg_policies
 where schemaname = 'public' and tablename = 'task_candidates'
   and policyname = 'admin_read_task_candidates';
