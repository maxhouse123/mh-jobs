-- 【JOB-2-09 回滚】(业主手动跑; 含 DROP, db-run.sh 会拦, 不经它)
begin;
drop function if exists public.admin_suspend_school(uuid, text);
drop function if exists public.admin_resume_school(uuid);
drop function if exists public.admin_update_school(uuid, jsonb, text);
alter table public.schools drop column if exists suspend_reason;
alter table public.schools drop column if exists suspended_by;
alter table public.schools drop column if exists suspended_at;
commit;
