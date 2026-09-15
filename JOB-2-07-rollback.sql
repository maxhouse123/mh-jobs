-- 目的地: Supabase SQL Editor 【JOB-2-07 回滚】(业主手动跑; 含 DROP, db-run.sh 会拦, 不经它)
-- 撤销本卡新增的两函数 + 四列。注意 DROP COLUMN 会丢已写入的软删标记/解锁标记。
begin;
drop function if exists public.admin_delete_document(text, text);
drop function if exists public.admin_reopen_doc_slot(uuid, text, text);
alter table public.documents drop column if exists slot_reopened_at;
alter table public.documents drop column if exists delete_reason;
alter table public.documents drop column if exists deleted_by;
alter table public.documents drop column if exists deleted_at;
commit;
