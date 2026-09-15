-- ================================================================
-- JOB-0.5 测试数据 seed  ——  ⚠️ 必须停：只出 SQL，业主点头后才在 SQL Editor 跑
-- 目的: 补齐 5 条验收缺的数据（二审驳回带理由 / 学生更换原因 / 已标记入学 /
--       待核销订单 / 已驳回订单），让 JOB-05 / JOB-06 / JOB-09 的对应功能能真验收。
-- 全部用「【测试】」文本标记 / 「PO-TEST-」单号前缀，cleanup.sql 按标记精确回收，绝不误删真数据。
-- 每条只造 1 行。跑前请先看清每条 WHERE 选中的是哪一行（末尾有自检查询）。
-- 字段名以现役库为准，若与你库不符请告诉我，我改。
-- ================================================================
begin;

-- ① 二审驳回带理由（review_verdicts.admin_verdict='reject' + admin_reason）
--    选一条「审核员已退回」的裁决打上二审驳回理由；没有就退而取任意一条。
update public.review_verdicts
   set admin_verdict = 'reject',
       admin_reason  = '【测试】二审复核：材料与申请信息不符，请重新提交',
       admin_ruled_at = now()
 where doc_id = (
   select doc_id from public.review_verdicts
    order by (status = 'rejected') desc, reviewed_at desc nulls last
    limit 1
 );

-- ② 学生填的更换原因（documents.replace_reason）
--    给最近上传的一份材料补一个「学生更换原因」。
update public.documents
   set replace_reason = '【测试】首次上传照片拍糊，已重新上传清晰版'
 where doc_id = (
   select doc_id from public.documents
    order by uploaded_at desc nulls last
    limit 1
 );

-- ③ 已标记入学（offer_decisions.enrolled_at）
--    给一条「学生已接受」的 offer 打上入学时间；没有 accepted 就取最近一条。
update public.offer_decisions
   set enrolled_at = now(),
       offer_reason = coalesce(offer_reason, '') || ' 【测试】已标记入学'
 where id = (
   select id from public.offer_decisions
    order by (student_response = 'accepted') desc, sent_at desc nulls last
    limit 1
 );

-- ④ 待核销订单（payment_orders：新插一行 awaiting_review，单号 PO-TEST-AWAIT）
--    用一个真实学生 id 作外键；金额走「通知书解锁 ¥3,000」。
insert into public.payment_orders (order_no, student_id, lane, kind, amount, discount, method, status, payer_note, created_at)
select 'PO-TEST-AWAIT', s.id, 'self', 'offer_letter', 3000, 0, 'wechat', 'awaiting_review', '【测试】待核销订单', now()
  from public.students s
 order by s.created_at desc
 limit 1
 on conflict (order_no) do nothing;

-- ⑤ 已驳回订单（payment_orders：新插一行 rejected + reject_reason，单号 PO-TEST-REJECT）
insert into public.payment_orders (order_no, student_id, lane, kind, amount, discount, method, status, reject_reason, payer_note, created_at)
select 'PO-TEST-REJECT', s.id, 'self', 'concierge', 600, 0, 'alipay', 'rejected', '【测试】付款凭证模糊，请重传', '【测试】已驳回订单', now()
  from public.students s
 order by s.created_at desc
 limit 1
 on conflict (order_no) do nothing;

-- ---- 自检：应各看到 1 行 ----
select '① 二审驳回带理由' as 项, count(*)::text as 行数 from public.review_verdicts where admin_reason like '【测试】%'
union all select '② 学生更换原因', count(*)::text from public.documents where replace_reason like '【测试】%'
union all select '③ 已标记入学',   count(*)::text from public.offer_decisions where enrolled_at is not null and offer_reason like '%【测试】已标记入学%'
union all select '④ 待核销订单',   count(*)::text from public.payment_orders where order_no = 'PO-TEST-AWAIT'
union all select '⑤ 已驳回订单',   count(*)::text from public.payment_orders where order_no = 'PO-TEST-REJECT';

commit;
