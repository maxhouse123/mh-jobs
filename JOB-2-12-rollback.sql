-- 【JOB-2-12 回滚】(业主手动跑; 含 DROP, db-run.sh 会拦, 不经它)
begin;
drop function if exists public.log_school_access(text, uuid, jsonb);
drop table if exists public.school_access_log;
commit;
