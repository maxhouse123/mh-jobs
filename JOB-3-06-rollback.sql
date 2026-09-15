-- 【JOB-3-06 回滚】(业主手动跑; 含 DROP)
begin;
drop function if exists public.admin_email_verified(uuid);
commit;
