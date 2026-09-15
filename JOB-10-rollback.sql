-- 【JOB-10 回滚】撤销 task_candidates 管理员只读策略(只删这一条)
select 'BEFORE 回滚' as 项, count(*)::text from pg_policies where schemaname='public' and tablename='task_candidates';
drop policy if exists admin_read_task_candidates on public.task_candidates;
select 'AFTER 回滚(应少1)' as 项, count(*)::text from pg_policies where schemaname='public' and tablename='task_candidates';
