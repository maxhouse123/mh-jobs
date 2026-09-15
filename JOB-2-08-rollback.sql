-- 目的地: Supabase SQL Editor 【JOB-2-08 回滚】(业主手动跑; 含 DROP, db-run.sh 会拦, 不经它)
begin;
drop policy if exists offer_letters_admin_write on storage.objects;
drop function if exists public.admin_replace_offer_letter(uuid, text, text);
drop function if exists public.admin_revoke_dispatch(text, text);
alter table public.reviewer_assignments drop column if exists revoke_reason;
alter table public.reviewer_assignments drop column if exists revoked_by;
alter table public.reviewer_assignments drop column if exists revoked_at;
commit;
