-- 目的地: Supabase → SQL Editor 【JOB-12 迁移】referral_drafts 加管理员只读策略
-- 目的: 管理端要看中介填到一半的推荐草稿, 但 referral_drafts 只有中介自己的四条策略,
--       无管理员策略, 管理员直查读不到。本迁移只加一条 for select 策略(照 is_admin(auth.uid()))。
-- 可重复执行。

select 'BEFORE · referral_drafts 策略数' as 项, count(*)::text as 值
  from pg_policies where schemaname = 'public' and tablename = 'referral_drafts';

drop policy if exists admin_read_referral_drafts on public.referral_drafts;
create policy admin_read_referral_drafts
  on public.referral_drafts
  for select
  using ( public.is_admin(auth.uid()) );

select 'AFTER · referral_drafts 策略数' as 项, count(*)::text as 值
  from pg_policies where schemaname = 'public' and tablename = 'referral_drafts';

select policyname, cmd from pg_policies
 where schemaname='public' and tablename='referral_drafts' and policyname='admin_read_referral_drafts';
