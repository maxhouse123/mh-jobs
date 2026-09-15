-- 目的地: 由 CC 经 jobs/db-run.sh 执行 【JOB-2-10 迁移】层级链 A(裁决5/6/7/8)
-- ① tier_quota 配置表(四档名额) ② schools.tier 值域统一(A→advanced/B→standard/C→trial/空→trial, 影响12行)+四档 check
-- ③ school_quota_requests 表(学校提额, 独立于中介 quota_requests) ④ admin_set_school_tier ⑤ admin_decide_school_quota
-- 全部 revoke public/anon/authenticated 再 grant; 新表 RLS 门 is_admin(admin ALL)+学校读写自己的。
-- ⚠ 裁决6 明授权的 tier 回填 UPDATE(改写既有 tier 列), db-run 允许 UPDATE; 跑前跑后分布写入回执。可重复执行。
begin;

-- ===== 段1: tier_quota 配置表 =====
select 'BEFORE · tier 分布' as 项, coalesce(tier,'(null)') as tier, count(*)::text as n from public.schools group by tier order by tier;

create table if not exists public.tier_quota (
  tier text primary key,
  quota int not null,
  label_zh text,
  label_en text
);
insert into public.tier_quota (tier, quota, label_zh, label_en) values
  ('trial', 5, '试用', 'Trial'),
  ('standard', 20, '标准', 'Standard'),
  ('advanced', 100, '高级', 'Advanced'),
  ('enterprise', 500, '旗舰', 'Enterprise')
on conflict (tier) do update set quota=excluded.quota, label_zh=excluded.label_zh, label_en=excluded.label_en;

alter table public.tier_quota enable row level security;
revoke all on public.tier_quota from public, anon, authenticated;
grant select on public.tier_quota to authenticated;
drop policy if exists tier_quota_read on public.tier_quota;
create policy tier_quota_read on public.tier_quota for select using ( auth.uid() is not null );
drop policy if exists tier_quota_admin_all on public.tier_quota;
create policy tier_quota_admin_all on public.tier_quota for all using ( public.is_admin(auth.uid()) ) with check ( public.is_admin(auth.uid()) );

-- ===== 段2: schools.tier 值域统一 + 四档 check =====
update public.schools set tier = case
  when tier is null then 'trial'
  when tier = 'A' then 'advanced'
  when tier = 'B' then 'standard'
  when tier = 'C' then 'trial'
  else tier end;
select 'AFTER · tier 分布(应只剩四档, 空值0)' as 项, coalesce(tier,'(null)') as tier, count(*)::text as n from public.schools group by tier order by tier;

do $do$ begin
  if not exists (select 1 from pg_constraint where conrelid='public.schools'::regclass and conname='schools_tier_check') then
    alter table public.schools add constraint schools_tier_check
      check ( tier is null or tier in ('trial','standard','advanced','enterprise') );
  end if;
end $do$;

-- ===== 段3: school_quota_requests(照 quota_requests 列, school_id 取代 partner_id) =====
create table if not exists public.school_quota_requests (
  id uuid primary key default gen_random_uuid(),
  school_id uuid not null,
  current_quota integer,
  current_used integer,
  requested_quota integer,
  reason text,
  status text not null default 'pending',
  decided_by uuid,
  decided_at timestamptz,
  decide_note text,
  created_at timestamptz not null default now()
);
alter table public.school_quota_requests enable row level security;
revoke all on public.school_quota_requests from public, anon, authenticated;
grant select, insert, update on public.school_quota_requests to authenticated;
drop policy if exists sqr_admin_all on public.school_quota_requests;
create policy sqr_admin_all on public.school_quota_requests for all
  using ( public.is_admin(auth.uid()) ) with check ( public.is_admin(auth.uid()) );
drop policy if exists sqr_school_select on public.school_quota_requests;
create policy sqr_school_select on public.school_quota_requests for select
  using ( school_id in (select school_id from public.school_members where user_id = auth.uid()) );
drop policy if exists sqr_school_insert on public.school_quota_requests;
create policy sqr_school_insert on public.school_quota_requests for insert
  with check ( school_id in (select school_id from public.school_members where user_id = auth.uid()) );

-- ===== 段4/5: 两个 admin 函数 =====
create or replace function public.admin_set_school_tier(p_school_id uuid, p_tier text, p_reason text)
returns jsonb language plpgsql security definer set search_path to 'public' as $fn$
declare _old text;
begin
  if not public.is_admin(auth.uid()) then raise exception 'admin_set_school_tier: admin only'; end if;
  if p_tier not in ('trial','standard','advanced','enterprise') then raise exception 'admin_set_school_tier: invalid tier %', p_tier; end if;
  select tier into _old from public.schools where id = p_school_id;
  if not found then raise exception 'admin_set_school_tier: school not found'; end if;
  update public.schools set tier = p_tier, updated_at = now() where id = p_school_id;
  insert into public.admin_events (event_type, actor_uid, school_id, detail)
  values ('school_tier_set', auth.uid(), p_school_id, jsonb_build_object('old', _old, 'new', p_tier, 'reason', p_reason));
  return jsonb_build_object('ok', true, 'tier', p_tier);
end; $fn$;

create or replace function public.admin_decide_school_quota(p_id uuid, p_approve bool, p_note text)
returns jsonb language plpgsql security definer set search_path to 'public' as $fn$
declare _r public.school_quota_requests;
begin
  if not public.is_admin(auth.uid()) then raise exception 'admin_decide_school_quota: admin only'; end if;
  select * into _r from public.school_quota_requests where id = p_id;
  if not found then raise exception 'admin_decide_school_quota: request not found'; end if;
  update public.school_quota_requests
     set status = case when p_approve then 'approved' else 'rejected' end,
         decided_by = auth.uid(), decided_at = now(), decide_note = p_note
   where id = p_id;
  insert into public.admin_events (event_type, actor_uid, school_id, detail)
  values ('school_quota_decided', auth.uid(), _r.school_id,
          jsonb_build_object('request_id', p_id, 'approve', p_approve, 'requested_quota', _r.requested_quota, 'note', p_note));
  return jsonb_build_object('ok', true, 'status', case when p_approve then 'approved' else 'rejected' end);
end; $fn$;

revoke execute on function public.admin_set_school_tier(uuid, text, text) from public, anon, authenticated;
grant  execute on function public.admin_set_school_tier(uuid, text, text) to authenticated;
revoke execute on function public.admin_decide_school_quota(uuid, bool, text) from public, anon, authenticated;
grant  execute on function public.admin_decide_school_quota(uuid, bool, text) to authenticated;

-- ===== 段6: 自检 =====
select 'CHK · tier_quota 行数(应4)' as 项, count(*)::text as 值 from public.tier_quota;
select 'CHK · school_quota_requests 存在(应1)' as 项, count(*)::text as 值 from information_schema.tables where table_schema='public' and table_name='school_quota_requests';
select 'CHK · 本卡两函数数(应2)' as 项, count(*)::text as 值 from pg_proc where proname in ('admin_set_school_tier','admin_decide_school_quota');
select 'CHK · schools_tier_check(应1)' as 项, count(*)::text as 值 from pg_constraint where conrelid='public.schools'::regclass and conname='schools_tier_check';

commit;
