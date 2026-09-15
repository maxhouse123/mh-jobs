-- 目的地: 由 CC 经 jobs/db-run.sh 执行 【JOB-3-05 迁移】给 media_shares / location_change_requests 加管理员只读策略
-- JOB-2-14 探明: media_shares 零策略、location_change_requests 只有学生自读, 管理员都读不到。只加 for select(is_admin), 纯新增。
begin;
select 'BEFORE · media_shares 策略数' as 项, count(*)::text as 值 from pg_policies where schemaname='public' and tablename='media_shares';
select 'BEFORE · location_change_requests 策略数' as 项, count(*)::text as 值 from pg_policies where schemaname='public' and tablename='location_change_requests';

drop policy if exists admin_read_media_shares on public.media_shares;
create policy admin_read_media_shares on public.media_shares
  for select using ( public.is_admin(auth.uid()) );

drop policy if exists admin_read_location_change_requests on public.location_change_requests;
create policy admin_read_location_change_requests on public.location_change_requests
  for select using ( public.is_admin(auth.uid()) );

select 'AFTER · media_shares 策略数' as 项, count(*)::text as 值 from pg_policies where schemaname='public' and tablename='media_shares';
select 'AFTER · location_change_requests 策略数' as 项, count(*)::text as 值 from pg_policies where schemaname='public' and tablename='location_change_requests';
select 'CHK · 两条新策略在' as 项, count(*)::text as 值 from pg_policies where schemaname='public' and policyname in ('admin_read_media_shares','admin_read_location_change_requests');
-- 顺带数一下有几条数据(供回执)
select 'media_shares 行数' as 项, count(*)::text as 值 from public.media_shares;
select 'location_change_requests 行数' as 项, count(*)::text as 值 from public.location_change_requests;
commit;
