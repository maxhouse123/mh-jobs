-- 目的地: 由 CC 经 jobs/db-run.sh 执行 【JOB-4-02 迁移】application_drafts 加管理员只读策略
-- JOB-3-07 探明该表 RLS 开、零策略, 管理员读不到。只加 for select(is_admin), 纯新增。
begin;
select 'BEFORE · application_drafts 策略数' as 项, count(*)::text as 值 from pg_policies where schemaname='public' and tablename='application_drafts';
drop policy if exists admin_read_application_drafts on public.application_drafts;
create policy admin_read_application_drafts on public.application_drafts
  for select using ( public.is_admin(auth.uid()) );
select 'AFTER · application_drafts 策略数' as 项, count(*)::text as 值 from pg_policies where schemaname='public' and tablename='application_drafts';
select 'application_drafts 行数 / 按端' as 项, portal, count(*)::text as n from public.application_drafts group by portal order by n desc;
commit;
