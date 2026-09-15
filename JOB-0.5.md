# JOB-0.5 · 造测试数据（必须停 —— 只出 SQL，未执行）

**结果：SQL 已写好（seed.sql + cleanup.sql），按规矩没有执行。等你点头才跑。**

## 做了什么（一句白话）
有 5 条验收因为库里没有这种数据，暂时验不了。我写了一段 SQL，能各造 **1 行**测试数据把这 5 种情况补上；再配一段撤销 SQL，能把造的删干净、不碰任何真数据。**都用「【测试】」文字或「PO-TEST-」单号做记号**，撤销就按记号精确回收。

## 5 条各动哪张表、影响几行、怎么撤销
| # | 缺的数据 | seed 动哪张表 | 影响行数 | 做法 | 怎么撤 |
|---|---|---|---|---|---|
| ① | 二审驳回带理由 | `review_verdicts` | 1 | 给一条已退回的裁决补 `admin_verdict='reject'`+`admin_reason='【测试】…'` | cleanup 把带【测试】的 admin_reason/admin_verdict 清回 null |
| ② | 学生填的更换原因 | `documents` | 1 | 给最近一份材料补 `replace_reason='【测试】…'` | cleanup 清回 null |
| ③ | 已标记入学 | `offer_decisions` | 1 | 给一条已接受的 offer 补 `enrolled_at=now()`（并在 offer_reason 尾加【测试】标记便于回收） | cleanup 清 enrolled_at + 去掉尾注 |
| ④ | 待核销订单 | `payment_orders` | 1（新插） | 插一行 `status='awaiting_review'`，单号 `PO-TEST-AWAIT`，¥3,000 通知书解锁 | cleanup 按单号删 |
| ⑤ | 已驳回订单 | `payment_orders` | 1（新插） | 插一行 `status='rejected'`+`reject_reason='【测试】…'`，单号 `PO-TEST-REJECT`，¥600 咨询 | cleanup 按单号删 |

- ①②③ 是**改现有行**（用 LIMIT 1 子查询各选一行，带【测试】标记，可精确撤）。
- ④⑤ 是**新插行**（不碰任何真订单；撤销直接按单号删两行）。
- seed 和 cleanup 都是单事务（begin/commit）、末尾都有自检查询（seed 应各 1 行、cleanup 应各 0 行）。

## 怎么用（等你点头后）
1. Supabase → SQL Editor → 贴 `jobs/JOB-0.5/seed.sql` 跑 → 看末尾自检各显 1。
2. 回去验收：JOB-05 抽屉看二审驳回理由/更换原因；JOB-06 抽屉/付款页看待核销+已驳回订单（能点核销/驳回）；JOB-09 学生阶段看「已入学」。
3. 验收完 → 贴 `jobs/JOB-0.5/cleanup.sql` 跑 → 自检各显 0，测试数据清干净。

## 偏离或疑点
1. **我没执行**（这包标了「必须停」）。也没有数据库连接权限，本就只能出 SQL。
2. **字段名以现役库为准**：SQL 里用的列名（`admin_verdict`/`admin_reason`/`replace_reason`/`enrolled_at`/`payment_orders` 各列）是我从前端读写路径推断的。如果你库里某列名不一样，跑的时候会报「column 不存在」——把报错发我，我改一版。
3. **④⑤ 插入用的必填列**：我按 `order_no/student_id/lane/kind/amount/discount/method/status/created_at` 填了。如果 `payment_orders` 还有别的 NOT NULL 列（比如 payer_uid），插入会报错——同样把报错发我补上。
4. 每条只造 1 行，够验收即可；要多造几行告诉我。
