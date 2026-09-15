-- 目的地: 由 CC 经 jobs/db-run.sh 执行 【JOB-2-09 迁移】停用学校 + 改学校档案
-- 裁决4(停用只挡新动作, 已发 offer 照常): schools 加 suspended_at/suspended_by/suspend_reason 三列;
--   ⚠ schools_status_check 只允许 onboarding/active(不含 suspended), 改约束需 DROP(红线+db-run 禁),
--   故「停用」用 suspended_at 标记表达(非改 status), 停用=置 suspended_at, 恢复=清空。前端据此显「已停用」。
-- 三个 SECURITY DEFINER 函数(is_admin 门 + 写 admin_events)。纯新增, 无删除。可重复执行。
begin;

select 'BEFORE · schools 列数' as 项, count(*)::text as 值
  from information_schema.columns where table_schema='public' and table_name='schools';
select 'BEFORE · 本卡三函数数(应0)' as 项, count(*)::text as 值
  from pg_proc where proname in ('admin_suspend_school','admin_resume_school','admin_update_school');

alter table public.schools add column if not exists suspended_at timestamptz;
alter table public.schools add column if not exists suspended_by uuid;
alter table public.schools add column if not exists suspend_reason text;

create or replace function public.admin_suspend_school(p_school_id uuid, p_reason text)
returns jsonb language plpgsql security definer set search_path to 'public' as $fn$
declare _s public.schools;
begin
  if not public.is_admin(auth.uid()) then raise exception 'admin_suspend_school: admin only'; end if;
  select * into _s from public.schools where id = p_school_id;
  if not found then raise exception 'admin_suspend_school: school not found'; end if;
  update public.schools
     set suspended_at = now(), suspended_by = auth.uid(), suspend_reason = p_reason, updated_at = now()
   where id = p_school_id;
  insert into public.admin_events (event_type, actor_uid, school_id, detail)
  values ('school_suspended', auth.uid(), p_school_id, jsonb_build_object('reason', p_reason));
  return jsonb_build_object('ok', true, 'suspended', true);
end; $fn$;

create or replace function public.admin_resume_school(p_school_id uuid)
returns jsonb language plpgsql security definer set search_path to 'public' as $fn$
begin
  if not public.is_admin(auth.uid()) then raise exception 'admin_resume_school: admin only'; end if;
  update public.schools
     set suspended_at = null, suspended_by = null, suspend_reason = null, updated_at = now()
   where id = p_school_id;
  if not found then raise exception 'admin_resume_school: school not found'; end if;
  insert into public.admin_events (event_type, actor_uid, school_id, detail)
  values ('school_resumed', auth.uid(), p_school_id, '{}'::jsonb);
  return jsonb_build_object('ok', true, 'suspended', false);
end; $fn$;

create or replace function public.admin_update_school(p_school_id uuid, p_patch jsonb, p_reason text)
returns jsonb language plpgsql security definer set search_path to 'public' as $fn$
declare _s public.schools; _old jsonb;
begin
  if not public.is_admin(auth.uid()) then raise exception 'admin_update_school: admin only'; end if;
  select * into _s from public.schools where id = p_school_id;
  if not found then raise exception 'admin_update_school: school not found'; end if;
  _old := jsonb_build_object('name_zh',_s.name_zh,'name_en',_s.name_en,'city',_s.city,
    'contact_name',_s.contact_name,'contact_email',_s.contact_email,'contact_phone',_s.contact_phone,
    'website',_s.website,'mobile',_s.mobile,'wechat',_s.wechat);
  update public.schools set
    name_zh       = case when p_patch ? 'name_zh'       then p_patch->>'name_zh'       else name_zh end,
    name_en       = case when p_patch ? 'name_en'       then p_patch->>'name_en'       else name_en end,
    city          = case when p_patch ? 'city'          then p_patch->>'city'          else city end,
    contact_name  = case when p_patch ? 'contact_name'  then p_patch->>'contact_name'  else contact_name end,
    contact_email = case when p_patch ? 'contact_email' then p_patch->>'contact_email' else contact_email end,
    contact_phone = case when p_patch ? 'contact_phone' then p_patch->>'contact_phone' else contact_phone end,
    website       = case when p_patch ? 'website'       then p_patch->>'website'       else website end,
    mobile        = case when p_patch ? 'mobile'        then p_patch->>'mobile'        else mobile end,
    wechat        = case when p_patch ? 'wechat'        then p_patch->>'wechat'        else wechat end,
    updated_at    = now()
  where id = p_school_id;
  insert into public.admin_events (event_type, actor_uid, school_id, detail)
  values ('school_updated', auth.uid(), p_school_id, jsonb_build_object('old', _old, 'patch', p_patch, 'reason', p_reason));
  return jsonb_build_object('ok', true);
end; $fn$;

revoke execute on function public.admin_suspend_school(uuid, text) from public, anon, authenticated;
grant  execute on function public.admin_suspend_school(uuid, text) to authenticated;
revoke execute on function public.admin_resume_school(uuid) from public, anon, authenticated;
grant  execute on function public.admin_resume_school(uuid) to authenticated;
revoke execute on function public.admin_update_school(uuid, jsonb, text) from public, anon, authenticated;
grant  execute on function public.admin_update_school(uuid, jsonb, text) to authenticated;

select 'AFTER · schools 列数' as 项, count(*)::text as 值
  from information_schema.columns where table_schema='public' and table_name='schools';
select 'AFTER · 本卡三函数数(应3)' as 项, count(*)::text as 值
  from pg_proc where proname in ('admin_suspend_school','admin_resume_school','admin_update_school');

commit;
