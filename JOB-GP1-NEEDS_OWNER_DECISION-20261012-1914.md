# NEEDS_OWNER_DECISION · 缺陷2：合作伙伴端工作台「录取漏斗」统计算错（产品代码问题，需业主裁决）

日期：2026-10-12 19:14（返工第 26 趟收尾）
触发依据：RULING-20261012b-review1 §一第 3 条（产品本身算错 → 不伪造、不改产品码，先做完不依赖它的部分，最后写本请示单停下）+ RULING-20261012c-rework 第 5 条。
前置：缺陷1（工作台负数金额 ¥-9,000）已在第 20 趟从演示数据层修好（D-20-1/D-20-2），与本缺陷不同，已销账。本请示单只讲**缺陷2**。

---

## 一、业主一句话版（不懂代码也能看）

合作机构端的「学生工作台」顶部有一条**录取漏斗**（几个人提交 → 几个人拿到通知书 → 几个人付款 → 几个人入学），还有一句「收到 N 份 offer · 人均 X.X 份」。

**现在这条漏斗对真实的云端推荐学生永远显示：9 人提交 → 0 人拿通知书 → 0 人付款 → 0 人入学、0 份 offer。**
但同一个页面下方的学生卡里明明写着：有 2 份 offer、3 个已付款、1 个已入学。**漏斗和卡面自相矛盾。**

这**不是我们演示数据造得不对**（演示数据已按真实流程摆好，下方卡面都对）。这是**产品本身的两处代码在用错数据源**，所以**任何真实中介**登录后，只要他的学生是走云端流程来的，都会看到这条「全是 0」的空漏斗。

我**没有在视频里把数字 P 成好看的**（那是造假），也**没有改产品代码**（铁律：不动五个端口的代码）。所以凡是画面里带这条工作台漏斗的章节，视频都**暂时录不了定版**，要等您拍板怎么修产品。

**请您决定：**
- (A) 认可这是产品 bug，安排产品侧按下面「建议改法」改好后，我再把带工作台的章节重录定版；或
- (B) 本次视频就先接受这条空漏斗照实录（真实中介现在也是这样看到的），我把它写进片子的「留给业主的产品问题」，不等修复直接出片；或
- (C) 其它处置（请写明）。

在您回复前，视频线按规矩停在这里等待。

---

## 二、技术版（哪个文件、哪段逻辑算错）

录制用版本：partner-portal v184（产线现役版，视频全程以它为准）。行号为该文件中的位置。

### 2.1 漏斗 / offer 计数（`_getPartnerStats`）
- 文件：`partner-portal/partner-v184.html`
- 函数：`_getPartnerStats(...)` 约 **L6061**。
- 对云端学生（`stu._cloud` 为真）的分支约 **L6074–L6079**：
  - `gotLetter` / `enrolled` **只按 `stu.status || stu.stage` 映射**（stage∈{admitted,enrolled}→gotLetter；stage=enrolled→enrolled）；
  - `paid` 与 `totalOffers` **对云端生直接硬编码 0**（L6075 原注释自述：云端无支付数据，paid=0）。
- 而云端学生装载处约 **L7296**：`status: r.stage || 'pending'` —— 即 status/stage 都取自数据库 `students.stage` 列。

### 2.2 hero「TOTAL PAYMENTS PROCESSED」与卡「Invested on this student」
- 同文件：hero `totalPaid` 约 **L6093–L6094**、卡 `invested` 约 **L6763–L6767**，均 = `_p130_STATS[sid].paid_total`。
- `paid_total` 来自 RPC `get_agent_boost_stats`（迁移 `0185`，约 L134）：`sum(po.amount - coalesce(po.discount,0)) where status='paid' and payer_uid=auth.uid()`——只认 `payment_orders` 表。
- 真实 ¥0 优惠码付款链 `coupon_agent_pay_offer`（迁移 `0069`）→ 调 `agent_pay_offer_letter`（迁移 `0054`，只 `update offer_decisions set letter_paid_at=now()`）+ 建 1 条 `coupon_redemption`，**从不建 `payment_order`**。所以真实付款后 `paid_total` 仍是 0 / 空（缺陷1 的负数是旧演示数据造的假 payment_order，已删）。

### 2.3 根因一句话
**漏斗读的是一列已经废弃、永不写入的 `students.stage`；真实进度其实存在 `offer_decisions` 表里，由数据库函数 `student_global_stage()`（迁移 `0154/0155`）现算。** 产品前端没改用这个函数/这张表，还对云端把 `paid`、`totalOffers` 写死成 0。

---

## 三、只读实证（2026-10-12 19:14 活库，`bash jobs/db-run.sh jobs/JOB-GP1/rec/_probe-rework-stats.sql`）

9 个演示推荐生（真实流程摆好的数据）：

| 学生 | `students.stage` 列 | `student_global_stage()` 现算 | offers | 已传通知书 | 已付 | 已入学 |
|------|--------------------|------------------------------|--------|-----------|------|--------|
| pt-02 | **NULL** | in_review | 0 | 0 | 0 | 0 |
| pt-03 | **NULL** | in_review | 0 | 0 | 0 | 0 |
| pt-04 | **NULL** | in_review | 0 | 0 | 0 | 0 |
| pt-05 | **NULL** | offerable | 0 | 0 | 0 | 0 |
| pt-06 | **NULL** | pending_offer | **2** | 0 | 0 | 0 |
| pt-07 | **NULL** | accepted | 1 | **1** | 0 | 0 |
| pt-08 | **NULL** | accepted | 1 | 1 | **已付(coupon)** | 0 |
| pt-09 | **NULL** | enrolled | 1 | 1 | **已付(coupon)** | **1** |

- 全部 9 人 `students.stage` 列**皆 NULL** → 漏斗按它算，自然 0 letter / 0 paid / 0 enrolled。
- `payment_orders`：**0 行**（缺陷1 已修，无假单）→ hero「已付总额」= 0。
- `coupon_redemptions`：pt-08、pt-09 各 1 行（真实 ¥0 优惠码付款的正确表征）。
- 真实进度全在 `offer_decisions`：pt-06 两份 pending offer、pt-07 已接受+通知书已传(未付)、pt-08 已付、pt-09 已入学。
- 全库 `students.stage` 仅 6 行旧种子非空、其余 65+ 全 NULL；**全部 migration 与五端口 JS 对该列零写入**（grep 两次皆空）——确系废弃列。

**真实中介会看到**：漏斗「9 submitted → 0 letter → 0 paid → 0 enrolled · 0 total offers · avg 0.0」，而下方学生卡显示 2 offer / 3 已付 / 1 入学 —— 矛盾。

---

## 四、建议改法（供产品侧参考，CC 本轮不动产品码）

1. **漏斗/计数改用真实数据源**：`_getPartnerStats` 对云端学生不要再读 `students.stage`，改读数据库现算的 `student_global_stage()`（迁移 0154/0155 已有），或直接按该生的 `offer_decisions` 行聚合（offers=该生 offer 行数；gotLetter=存在 `letter_uploaded_at`；enrolled=存在 `enrolled_at`）。
2. **`paid` 不要对云端硬编码 0**：中介付款真实写在 `offer_decisions.letter_paid_at`（且 ¥0 优惠码付款有 `coupon_redemptions` 行），应据此判「已付」；`totalOffers` 同理按 offer 行数算，不写死 0。
3. **hero「TOTAL PAYMENTS PROCESSED」口径**：若要统计真实已收，应覆盖「真实付款单 `payment_orders`（曝光/增值等）+ ¥0 优惠码核销 `coupon_redemptions`」两条车道；只认 `payment_orders` 会漏掉优惠码付的通知书费（也正是本缺陷把真实付款显示成 0 的原因）。建议新建/扩展一个脱敏 RPC 汇总两条车道，而非仅 `get_agent_boost_stats`。
4. 以上均属**改产品端口代码/新增 RPC**，超出视频线权限（铁律：不改五端口 HTML/JS/迁移）。请产品侧评估后落地，CC 再据修好后的真实数据重录带工作台的章节。

---

## 五、被本缺陷阻塞、待裁决后才能定版的视频工作

（review1 各节里凡画面含工作台 hero / 卡 / 漏斗的）：

- **§三.1（2-2 名额）**、**§三.2（2-4 五阶段）**：第 2 章「我的推荐」背景含工作台统计。
- **§三.5（7-4 已入学）**：依赖漏斗能真实显示「已入学」。
- **§三.7（ch8 提额横幅）**：第 8 章工作台画面。
- **§三.8（节奏 3-1 / 3-8 / 5-1）**：这几镜停在工作台等导航/加载。
- **§五 OP-3 / OP-4 / OP-5 开场快剪**：素材分别是 3-8（app_no）/ 7-0（¥0 付款）/ 7-1（校名揭晓），均在工作台/漏斗画面。
- **ch1 / 2 / 3 / 5 / 7 / 8 / 10 工作台章定版重出**，以及 **ch5 5-1（工作台 hero）与 5-4（审核中态）两态定版重录**。
- **§六 十一项重审**中依赖上述章定版的部分。

## 六、本缺陷裁决前**已经做完、不受它阻塞**的返工（已交付）

- §一：缺陷1 负数金额已从数据层根除（D-20-2），verify 17/17。
- §四：录制残留草稿已清（D-20-3）。
- §二：第 6 章去「点解锁→校名揭晓」四语横竖重出（trip21/22）。
- §三.3：5-2 EN 字幕改述真实画面（trip24）。
- §三.4：5-4「回到审核中」真态机制（靠产品自身 supersede 逻辑、零改码，trip25）。
- §三.6：ch9 增值服务名四语重出（trip23）。
- §五 OP-2：开场快剪（ch6 两份盲 offer 素材，四语横竖，trip26）。

GP-1 **未收官**，等业主对本缺陷(A/B/C)回复后继续。
