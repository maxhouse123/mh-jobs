# JOB-G0-02 回执 · 演示学生 A（Lina）全链路

日期 2026-10-05 ｜ 账号 guide_stuA（Lina Demo，境外）

## 一句话
Lina 从真站一路走完：填志愿、填资料、传六份材料、提交拿到申请编号 **MH-88QV7G**；六份材料全部「已通过」；收到一份录取、接受、学校发通知书、用优惠码 **¥0 解锁**、通知书和 JW202 两份文件都能打开。**只有「第二份 offer」没发成**——不是出错，是系统规则不允许同一所学校给同一个学生发两份 offer（详见下方「卡住的一条」）。这条需要您拍板。

## 判据结果（真站以 Lina 登录断言 + 截图）
- ① My Application 显示申请编号 **MH-88QV7G**（MH- 开头）：**过**
- ② 材料区六份都「Approved」：**过**（passport/education/transcript/photo/cv/english 全部 approve）
- ③ Admissions 两份 offer：
  - #1「Admission Confirmed」+ 通知书与 JW202 可打开：**过**（两文件线上实测 HTTP 200，分别 84977 和 75459 字节）
  - #2「待付 ¥1,500 + days left」：**没做成（卡住，见下）**
- ④ What's next 卡出现：**过**
- ⑤「Share my offer」分享按钮可点：**过**（按钮在）

截图：`jobs/JOB-G0/shots/g0-02-stuA-dashboard.png`（学生工作台）、`g0-02-apply-stuA.png`（申请页）。

## 卡住的一条：第二份 offer（需您拍板）
任务书要「schX 建两个任务、各发一份 offer」，让 Lina 同时有两份 offer（#1 已确认、#2 待付 ¥1,500）。
但真库有一条硬规则 `uq_offer_live_per_school_student`：**一所学校对同一个学生，只能有一份「未被拒」的 offer**。
这其实是平台「双盲、多校竞录」的正常设计——一个学生会收到**来自不同学校**的多份 offer，而不是同一所学校发两份。所以要让 Lina 有两份 offer，**第二份必须来自「第二所学校」**。
而本轮规矩 §0.1 明确「学校动作只用测试学校 schX」。于是产生冲突：规则要我只用 schX，判据却要两所学校。
我**没有擅自动用第二所学校**（那会违反 §0.1）。两个办法，请您选一个：
- **A（推荐）**：授权我用「另一所测试学校」（是 is_test 演示校，绝不碰真实学校）发第二份 offer。我已把流程脚本备好，一句话即可补上，Lina 就会出现两份 offer。
- **B**：接受「演示里 Lina 只有一份 offer」，第二份在 G-1 录制时用另一个演示学生或另一所校演示。
（顺带：¥1,500 是优惠码的阶梯价——学生**第二次**解锁 offer 才收 ¥1,500；第一次是 ¥0。Lina 第一份已用掉 ¥0 那档，所以她的第二份天然就是 ¥1,500 档，办法 A 实现后会自动正确显示。）

## 用的哪条路（按 §0.2）
- **学生侧全程真站真页面**（Playwright）：登录、第 2 步志愿、第 3 步资料、上传六份材料、第 4 步提交。写成可复用流程 `flows/student-apply.mjs`。
- **材料审核「通过」**：审核端口没有专门的「通过」函数（真审核页是直接写一张表），所以我用 **reviewer1 身份直写 `review_verdicts` 表**（status=approved），这正是审核端页面的同款做法。
- **学校侧 + 学生接受/付款**：用「带身份调同一个后台函数」（§0.2 第二条路，`bash jobs/db-run.sh` 事务里按各账号身份调），依次：建两任务→管理员审批放行→把 Lina 加进两任务候选池→发 1 份 offer→Lina 接受→学校传通知书→Lina 用 MAXHOUSE 付 ¥0→解锁→学校传 JW202（置完成）。
- **通知书/JW202 的 PDF 实体**：用 **schX（测试校 schx@gmail）真会话**上传到 `offer-letters` 桶（真鉴权真 RLS，不碰任何密钥）。
- 写入的表/桶：review_verdicts（审核）、admission_tasks（建任务）、task_candidates（候选）、offer_decisions（offer）、coupon_redemptions（¥0 付款）、offer-letters 桶（两 PDF）。

## 顺带记两件事
- **一次账号虚惊**：accounts.json 里有**两个** schX 键——`accounts.schX`（schx@gmail，正是武汉大学**测试**校）和顶层 `schX`（sc1@gmail，名下是一所**没打测试标记的真校**）。我一开始误用了顶层那个去传文件，被数据库 RLS 当场挡下（**没有写成任何东西**），随即改用正确的 `accounts.schX`。**全程没有改动那所真校的任何数据**。建议把顶层 `schX`（sc1）从测试账号表里清掉或改名，免得再踩。
- schX 的「建档系统」本来没设置，而发 offer 的前置要求它非空，我把它设成 **none（=不要求建档）**，这样 Lina 不会多出一张「补充信息表」卡。G0-05 收尾会把它还原为未设置。
- Lina 因为我反复调试，名下有重复的材料（每个槽 2 份，最新那份都已通过，显示正确）。G0-05「回收重建」会从干净状态重跑，变成每槽 1 份。

## 产物
- `flows/student-apply.mjs`、`flows/school-upload.mjs`、`make-docs.mjs`（合成材料+通知书）、`g0-02-run.mjs`（编排，可复用/可重建）、`g0-02-backstage.sql`、`g0-02-emailverify.sql`、probe-02*.sql、`created-ids.json` 追加 G0-02。
- 主仓库：本包脚本已 git add + commit（未 push）。
