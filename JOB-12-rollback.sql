-- 【JOB-12 回滚】撤销 referral_drafts 管理员只读策略
select 'BEFORE 回滚' as 项, count(*)::text from pg_policies where schemaname='public' and tablename='referral_drafts';
drop policy if exists admin_read_referral_drafts on public.referral_drafts;
select 'AFTER 回滚(应少1)' as 项, count(*)::text from pg_policies where schemaname='public' and tablename='referral_drafts';
