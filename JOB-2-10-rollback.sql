-- 【JOB-2-10 回滚】(业主手动跑; 含 DROP, db-run.sh 会拦, 不经它)
-- ⚠ tier 值域回填(A/B/C/空→四档)不可逆: 原始 A/B/C 区分已丢失, 本回滚不还原 tier 值, 仅撤新建对象。
begin;
drop function if exists public.admin_set_school_tier(uuid, text, text);
drop function if exists public.admin_decide_school_quota(uuid, bool, text);
alter table public.schools drop constraint if exists schools_tier_check;
drop table if exists public.school_quota_requests;
drop table if exists public.tier_quota;
commit;
