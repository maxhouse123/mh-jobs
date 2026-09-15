-- ================================================================
-- JOB-0.5 测试数据 cleanup —— 撤销 seed.sql 造的 5 条测试数据
-- 全部按「【测试】」标记 / 「PO-TEST-」单号精确回收，不碰任何真数据。
-- ================================================================
begin;

-- ① 撤二审驳回理由（清回 null；admin_verdict 回 null）
update public.review_verdicts
   set admin_verdict = null, admin_reason = null, admin_ruled_at = null
 where admin_reason like '【测试】%';

-- ② 撤学生更换原因
update public.documents
   set replace_reason = null
 where replace_reason like '【测试】%';

-- ③ 撤已标记入学（enrolled_at 清空；去掉 offer_reason 里的测试尾注）
update public.offer_decisions
   set enrolled_at = null,
       offer_reason = nullif(replace(offer_reason, ' 【测试】已标记入学', ''), '')
 where offer_reason like '%【测试】已标记入学%';

-- ④⑤ 删两笔测试订单
delete from public.payment_orders where order_no in ('PO-TEST-AWAIT', 'PO-TEST-REJECT');

-- ---- 自检：应各为 0 ----
select '① 残留二审理由' as 项, count(*)::text as 行数 from public.review_verdicts where admin_reason like '【测试】%'
union all select '② 残留更换原因', count(*)::text from public.documents where replace_reason like '【测试】%'
union all select '③ 残留入学标记', count(*)::text from public.offer_decisions where offer_reason like '%【测试】已标记入学%'
union all select '④⑤ 残留测试订单', count(*)::text from public.payment_orders where order_no in ('PO-TEST-AWAIT','PO-TEST-REJECT');

commit;
