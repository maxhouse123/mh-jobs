-- 【JOB-3-05 回滚】(业主手动跑; drop policy 允许经 db-run, 但回滚一般手动)
begin;
drop policy if exists admin_read_media_shares on public.media_shares;
drop policy if exists admin_read_location_change_requests on public.location_change_requests;
commit;
