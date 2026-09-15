-- JOB-2-01 只读探针 C: 找出 seed 失败根因 (CHECK 约束)
begin;
select 'chk·payment_orders' as 项, conname, pg_get_constraintdef(oid) as 定义
  from pg_constraint where conrelid='public.payment_orders'::regclass and contype='c';
select 'chk·review_verdicts' as 项, conname, pg_get_constraintdef(oid) as 定义
  from pg_constraint where conrelid='public.review_verdicts'::regclass and contype='c';
select 'payment_orders 现有 status 分布' as 项, status, count(*)::text as n
  from payment_orders group by status order by status;
select 'students 行数' as 项, count(*)::text as 值 from students;
commit;
