-- 【JOB-4-02 回滚】(业主手动跑)
begin;
drop policy if exists admin_read_application_drafts on public.application_drafts;
commit;
