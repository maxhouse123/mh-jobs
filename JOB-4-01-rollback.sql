-- 【JOB-4-01 回滚】(业主手动跑)
begin;
drop policy if exists admin_read_ai_precheck_shadow on public.ai_precheck_shadow;
drop policy if exists admin_read_ai_precheck_draft on public.ai_precheck_draft;
commit;
