-- 目的地: Supabase → SQL Editor 【JOB-09 迁移】application_rounds 加管理员只读策略
-- 目的: 管理端要显示学生「第几轮/每轮申请号/本轮状态」, 但 application_rounds 零 RLS 策略,
--       管理员直查读不到(学生侧走 SECURITY DEFINER RPC 绕过 RLS, 不受影响)。本迁移只加一条
--       for select 策略(照抄现役 is_admin(auth.uid()) 写法), 纯新增, 不改任何现有读写。
-- 可重复执行(drop if exists + create)。

-- ① 跑之前先数该表现有策略数(记下这个数):
select 'BEFORE · application_rounds 策略数' as 项, count(*)::text as 值
  from pg_policies where schemaname = 'public' and tablename = 'application_rounds';

-- ② 管理员全读策略(仅 for select; RLS 已启用, 本项目探针实证「零策略·管理员读不到」)
drop policy if exists admin_read_application_rounds on public.application_rounds;
create policy admin_read_application_rounds
  on public.application_rounds
  for select
  using ( public.is_admin(auth.uid()) );

-- ③ 跑之后再数(与 BEFORE 差值应为 1):
select 'AFTER · application_rounds 策略数' as 项, count(*)::text as 值
  from pg_policies where schemaname = 'public' and tablename = 'application_rounds';

-- ④ 自检: 应能看到刚建的策略一行
select policyname, cmd
  from pg_policies
 where schemaname = 'public' and tablename = 'application_rounds'
   and policyname = 'admin_read_application_rounds';
