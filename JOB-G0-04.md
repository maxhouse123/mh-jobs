# JOB-G0-04 回执 · 学生中介 C + 两名被荐生 + 待申请账号

日期 2026-10-05

## 一句话
备齐了第 11、12 章要用的三类账号：①一个"交了申请、还没申请当中介"的学生（guide_agentFresh，用来录"成为合伙人"那段）；②一个已经被批准的学生中介（guide_agent）；③中介名下两名被荐生——Ravi（材料有一项被退回、显示"待补材料"）、Nour（材料全批、收到一份 offer、中介替她接受、学校发了通知书、停在待付款）。三条判据全过。

## 判据结果
- ① Partner Dashboard（以 guide_agent 登录真站）显示 **2 名被荐生**：Ravi 带"需补/重新上传"提示、Nour 显示 offer 且待付款——**过**。
  - Ravi 的材料状态（真库 RPC 实测）：护照✅、学历✅、成绩单❌被退回（理由"成绩单不清晰，请重新上传"）→ 仪表盘出现待补提示。
  - Nour 的材料：护照/学历/成绩单/证件照 **四项全批**；她的 offer：已被中介代为接受、学校已传通知书、**未付款（待付款）**。
- ② 名额与账本一致、is_test、名额>0——**过**：guide_agent 的 partners 行 status=active、is_test=true；配额账本 = 初始发 2 − 两名被荐生各扣 1 + 管理员补发 5 = **余额 5**（仪表盘名额块读的就是这个账本余额，天然一致）。
- ③ 以 guide_agentFresh 登录，Step 5 出现"成为合伙人/Become a Maxhouse Partner Agent"入口且**未申请**——**过**（入口按钮在、点开即那张申请表；该账号 partners 表里没有行=没申请；本人已交过学生申请）。

截图：`jobs/JOB-G0/shots/g0-04-agent-dashboard.png`（中介仪表盘：两被荐生）、`g0-04-agentFresh-step5.png`（待申请账号的 Step5）。

## 用的哪条路
- 两个 Sam 账号的学生申请：**真站真页面**（复用 flows/student-apply）。
- 中介申请、管理员批准、配额、建被荐生、Nour 的 offer 接受/发通知书：**带身份调同一后台函数**（中介本人身份调 submit_student_agent_application 和 submit_referral；管理员身份调 admin_review_partner 批准 + admin_set_partner_quota；中介身份调 agent_respond_to_offer 代接受）。
- 被荐生的材料：由于"中介代传材料"的真页面流程较重，本轮用**直写 documents 表 + reviewer 身份写审核结论**（status approved/rejected）造出"全批/一项退回"两种状态——仪表盘的材料状态正是读这两张表，显示正确。**被荐生的材料文件本身没有上传到存储桶**（仪表盘只看状态、不看文件；G-1 若要展示文件再补）。
- Nour 的通知书 PDF：用第二所演示校 guide_sch2 的真会话传到 offer-letters 桶。
- 配额补发：往 partner_quota_ledger 记一笔 admin_adjust +5（管理员调账），使名额>0。
- 写入表：partners、students（Ravi/Nour）、documents、review_verdicts、admission_tasks(ADM-100015)、task_candidates、offer_decisions、partner_quota_ledger、offer-letters 桶。

## 一处按真实情况的说明
- 任务书说被荐生 Ravi"状态待补材料"、Nour"全批→offer→代接受→停待付款"，都已照做。Nour 的 offer 用的是第二所演示校 guide_sch2（业主裁决 R1 允许，省事）。
- 中介初始名额系统只发 2（不是 5）；我额外补发 5（管理员调账），让名额充足且账本一致，方便 G-1 录制时中介还能再推荐。

## 产物
- `g0-04-run.mjs`（编排/可重建）、`g0-04-backstage.sql`、`g0-04-quota.sql`、`flows/school-register.mjs`、probe-04*.sql、make-docs 的 sam/sama/nour 资产、`created-ids.json` 追加 G0-04。
- 主仓库：本包脚本已 git add + commit（未 push）。
