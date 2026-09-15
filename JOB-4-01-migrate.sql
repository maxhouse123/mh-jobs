-- 目的地: 由 CC 经 jobs/db-run.sh 执行 【JOB-4-01 迁移】ai_precheck_shadow / ai_precheck_draft 加管理员只读策略
-- JOB-3-07 探明两表 RLS 开、零策略, 管理员读不到。只加 for select(is_admin), 纯新增。
begin;
select 'BEFORE · ai_precheck_shadow 策略数' as 项, count(*)::text as 值 from pg_policies where schemaname='public' and tablename='ai_precheck_shadow';
select 'BEFORE · ai_precheck_draft 策略数' as 项, count(*)::text as 值 from pg_policies where schemaname='public' and tablename='ai_precheck_draft';

drop policy if exists admin_read_ai_precheck_shadow on public.ai_precheck_shadow;
create policy admin_read_ai_precheck_shadow on public.ai_precheck_shadow
  for select using ( public.is_admin(auth.uid()) );

drop policy if exists admin_read_ai_precheck_draft on public.ai_precheck_draft;
create policy admin_read_ai_precheck_draft on public.ai_precheck_draft
  for select using ( public.is_admin(auth.uid()) );

select 'AFTER · ai_precheck_shadow 策略数' as 项, count(*)::text as 值 from pg_policies where schemaname='public' and tablename='ai_precheck_shadow';
select 'AFTER · ai_precheck_draft 策略数' as 项, count(*)::text as 值 from pg_policies where schemaname='public' and tablename='ai_precheck_draft';
select 'CHK · 两条新策略在' as 项, count(*)::text as 值 from pg_policies where schemaname='public' and policyname in ('admin_read_ai_precheck_shadow','admin_read_ai_precheck_draft');
select 'shadow 有 issues 的行数' as 项, count(*)::text as 值 from public.ai_precheck_shadow where issues is not null and issues::text not in ('null','[]','{}');
commit;
