# JOB-GP1-01 回执 —— 演示数据（**完成 · 闸3 全过 16/16**）

日期 2026-10-11｜Mac mini 无人值守（接 GP1-00 之后同一轮续跑）｜本趟把 GP1-01 一口气做完：Demo Agency 名下十名被荐生铺满各状态 + 注册演示号 + 一键复位/重建，自检 16 条断言全过、rebuild 两遍关键计数一致。

## 一句话（给业主）
演示用的「十个学生 + 一个新注册的机构」全部造好了，挂在 **Demo Agency** 名下，都是测试数据（不是真人）。十个学生分别卡在**草稿 / 审核中 / 材料被退回 / 委托邀请自传中 / 可发录取 / 两份录取待解锁 / 已接受待通知书 / 已付款待JW202 / 已入学 / 已提交看增值服务**这十种状态上——正好对应分镜十章要拍的画面。名额设成 **10 个、已用 9 个**（草稿不占），还放了一条「申请加到 30」的提额申请等着第8章演示。九个在库学生每人配了一张 AI 虚拟脸（按国籍和性别挑的）。工作台截图已存证，五种状态徽章都在。整套能一键清空、一键重建，连跑两遍结果一模一样。

---

## 闸3 对账（16 断言全 PASS，0 FAIL）
`bash jobs/db-run.sh jobs/JOB-GP1/states/verify.sql` 输出（摘）：

| # | 断言 | 结果 |
|---|---|---|
| 1 | students=9（pt-02..10 含 pt-04） | PASS |
| 2 | 全部 guide-pt 学生 is_test | PASS |
| 3 | 名额=10 且 已用=9 | PASS |
| 4 | pt-01 草稿（referral_drafts）在 | PASS |
| 5 | pt-06 两份盲 offer（pending、unlocked_at 空） | PASS |
| 6 | pt-07 已解锁+已接受、待通知书 | PASS |
| 7 | pt-07 ¥0 付款单（MAXHOUSE 码）在 | PASS |
| 8 | pt-08 通知书已传、JW202 待、建档 submitted | PASS |
| 9 | pt-09 已入学、JW202 已传、建档 approved | PASS |
| 10 | pt-03 成绩单退回（英文理由） | PASS |
| 11 | pt-04 委托邀请=claimed + 3 份材料 | PASS |
| 12 | 伙伴通知 ≥4 | PASS |
| 13 | 提额申请 pending 请求 30 | PASS |
| 14 | 九生各有 gp1 AI 脸照片 | PASS |
| 15 | reg 机构 pending/is_test + 2 份资质 | PASS |
| 16 | 列表五档徽章各 ≥1（审核中/可发录取/在途/已接受/已入学） | PASS |

- **十名被荐生 + reg 全 is_test**：✅（pt-01 草稿 + pt-02..10 九名学生 + reg 机构）。
- **五档徽章截图**：✅ `~/mh-jobs/shots/GP1/en/ch2-badges-list-en.png`（guide_partner 登录本地 portal v184 + 真库走代理只读；画面已打码：gmail→firstname.demo@example.com、邀请码→INVITE-••••；脚本复核 remaining_gmail=0/remaining_code=0）。
- **pt-06 两份 offer 盲态**：✅ Demo University 奖学金(ADM-100005) + Demo University 2 自费(ADM-100036)，均 pending、unlocked_at 空。
- **pt-07 ¥0 付款单**：✅（amount=0, coupon MAXHOUSE, status paid；lane=agent/kind=offer_letter）。
- **名额 9/10**：✅。**通知 ≥4**：✅（19 条，offer 发出触发 + 手工材料退回）。
- **rebuild 自检 ≥10 断言全过**：✅（16 条）。**castlist 已推**：✅（见下）。
- **跑两遍 OK**：✅ rebuild 连跑两次，关键计数一致（referral 10/8→用9、pt04 1/1/3、faces 9、VERIFY_FAILS=0、REBUILD_OK）。

## 十名被荐生状态（详见 castlist）
pt-01 巴基斯坦女 **草稿** / pt-02 尼日利亚男 **审核中** / pt-03 孟加拉男 **材料退回(成绩单·英文理由)** / pt-04 哈萨克斯坦女 **委托邀请·已注册·3/6** / pt-05 喀麦隆男 **可发录取** / pt-06 巴基斯坦男 **两份盲offer** / pt-07 乌兹别克斯坦女 **已解锁¥0·已接受·待通知书** / pt-08 加纳女 **已付款·待JW202·建档已录入** / pt-09 俄罗斯男 **已入学** / pt-10 塞内加尔女 **已提交(增值入口)**。

## 怎么造的（技术账）
- **库写入一律走 db-run.sh（postgres 超级用户）**。发现 service_role 对 students 等表无 GRANT（迁移0001 病根），故 node 只做两件事：① 建两个 auth.users（pt-04 学生 / reg 机构，partners.id→auth.users 有 FK，学生 students.id=auth uid 按惯例）② 发带 uid 的幂等 SQL 交 db-run 落库；③ 上传 AI 脸到存储桶（桶写 service_role 可）。密码随机生成、只进 accounts.json（键 guide_pt04 / guide_ptReg），从不打印。
- **触发器顺着走、不绕**：offer 用 `sent_by=schools.id`（非账号 uid，否则 trg_filing_gate 报 filing_unset）；接受→付款顺序让 trg_offer_paid_unlock 自动置 unlocked_at；DU(gz17/before_letter) 接受时 trg_filing_task_on_offer 自动建档任务，再 UPDATE 到 submitted/approved；用无面试任务(ADM-100005/100036)避开 gate_offer_insert_interview。
- **名额口径**：agency 名额=partners.referral_quota=10；已用=count(referred 且 (withdrawn空 或 submitted非空))=9（pt-01 草稿是 referral_drafts 行、不是 students 行，故不占）。提额走 quota_requests(status=pending, requested=30)。
- **脸**：国籍→G6 外貌组（C非洲/A南亚/F欧洲中亚）× 性别，九张互不重复，存桶 `<uuid>/photo/gp1-face-<code>.jpg`，更新各生最新 photo 文档 file_path。

## 产物与脚本（主仓库 jobs/JOB-GP1/，本轮只提交不推）
- `states/cleanup.sql`（FK 安全清 guide-pt·文件名含 cleanup 放行 delete）
- `states/build-core.sql`（8 名 SQL 生 + pt-01 草稿 + offer/付款/建档 + 名额10 + 提额待审）
- `states/verify.sql`（16 断言）、`states/reset-pt.sh`（清回0 + 删两 auth）
- `states/st-pt07-letter.sql` / `st-pt08-jw202.sql` / `st-quota-approve.sql`（录制态：通知书/JW202 上传、提额批准→30）
- `rebuild-partner.sh`（清0→build→auth→脸→自检，幂等）
- `rec/mk-accounts.mjs`（建两 auth + 发 pt04-reg.gen.sql）、`rec/assign-faces-gp1.mjs`（配脸 + 发 faces.gen.sql）、`rec/del-auth.mjs`（删两 auth）、`rec/shot-list.mjs`（取证截图 + 打码）
- **不入 git**：`rec/out/`（截图）、`rec/specimen/`（SPECIMEN 样件）、`*.gen.sql`（node 生成，可重出）、`rec/probe-*.sql`（侦察草稿）、`node_modules`。
- `~/mh-jobs/`：本回执 + `JOB-GP1-castlist.md` + `shots/GP1/en/ch2-badges-list-en.png`。

## 合规
- 只动 is_test 且挂 Demo Agency 名下的数据 + Demo Agency 自己的名额/提额 + 三所演示校对这些学生的 offer + 新造 guide-pt-04/reg；未碰 partner1 等其它中介、未碰非 guide 学生、未碰平台总开关、未碰优惠码表现有行（MAXHOUSE 码只在付款单引用，未改 coupons 表）。
- 未改五端 HTML/JS/迁移；未改 JOB-G*/JOB-GS*/JOB-GP0 原文件（SPECIMEN 仅 cp 到 JOB-GP1/rec/specimen/）；别的线(G8/G9/GP0)改动未碰未提交。
- 未起后台任务；node 走代理（NODE_USE_ENV_PROXY 未清）；密码未打印、未进回执/ git。
- supabase-js 本地装在 ~/mh-verify/sbjs（不入 git），因 ~/mh-verify 原 package.json 的 supabase CLI 依赖损坏 npm 树，故隔离目录单装。

## 下一包 GP1-02（字幕 + 四语配音）要点
captions-v1.json（每镜 EN/中照抄 storyboard + RU/FR CC 译回译自检）+ 四语 say 配音（Samantha/Tingting/Milena/Amélie）逐镜 wav + 时长表；俄法超 3 行压短清单入回执。

## 留给 GP1-03 录制的小前置（非本包闸项，已点明）
- **SPECIMEN 上桶**：admission-letter.pdf / jw202-form.pdf / demo-agency-licence.pdf / demo-officer-passport.jpg 已 cp 到 `rec/specimen/`（源 JOB-GS3/JOB-32）；documents.file_path 现指 `specimen/…`，桶内 specimen/ 当前为空 → 录 ch7 下载前需上桶（或改走各生路径）。列为 GP1-03 录前第一步。
- **MRZ 合成护照（§2.6）**：ch3 pt-01「护照姓名核对」要带机读区护照图，本包未合成（需图像合成）；GP1-03 录 ch3 前生成，若 OCR 对合成图不触发则照 storyboard 预授权改静态高亮提示区并记因。
