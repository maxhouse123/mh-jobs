# v185 漏斗修复已就绪，请 Claude 审核后由业主推送上线

**第 27 趟（2026-10-12 Mac mini 无人值守）· 停下情形④（需要推主仓库）**
依据：`RULING-20261012d-funnel.md` §三.1——修好后写本请示单，等 Claude 审过、由业主用卡推送上线；CC 不推。

---

## 一句话（给业主）

你上一轮选的 **A：先修产品再录**，我已把中介端工作台那个「录取漏斗/人均 offer 对云端学生全是 0」的毛病修好了，做成了 **合作伙伴端 v185**。本机真登录中介账号、四种语言都验过，漏斗现在正确显示 **9 → 3 → 2 → 1、5 个 offer、人均 0.6**，和数据库里算出来的期望值一致；工作台其它字一个没动，`TOTAL PAYMENTS PROCESSED` 按你的要求保持 ¥0。代码已在本机提交（没推）。**请 Claude 审一遍这次改动，确认没问题后，由你用卡去原生终端挂代理把 v185 推送上线。** 上线并确认线上是 v185 之后，循环会重开，接着录被这个毛病卡住的那些章节的定版。

---

## 二、改了什么（技术版）

- **文件**：
  - 新建 `partner-portal/maxhouse-partner-portal-v185.html`（自 v184 cp 后改）
  - `partner-portal/index.html` 入口重定向 v184 → v185（4 处）
- **唯一的逻辑改动（diff 仅 4 处块）**：
  1. `_getPartnerStats()` 云端推荐生分支——弃读废弃列 `students.stage`（恒 NULL），改按**卡面同口径**数页面已加载的真 offer 数据 `stu._offers`（`get_agent_student_offers` RPC，与学生卡同源）：offer 份数=行数 / 拿通知书=`letter_uploaded_at` / 已付=`letter_paid_at` / 录取完成=`completed_at`。
  2. 人均 offer 零学生兜底 `'0'→'0.0'`。
  3. `[VER]` 版本探针 v184→v185（加修复说明）。
  4. `MH_PORTAL_VER = 184→185`。
- **按裁决不动**：`TOTAL PAYMENTS PROCESSED`（`totalPaid`）、「Invested on this student」、学生/学校/管理/审核四端、首页——一字未改。
- 路径按裁决 §一.4 选了**第一条（只改前端）**：不新增迁移、不新发请求。

完整代码 diff + 前后对比截图 + 期望值来源见公开回执 **`~/mh-jobs/JOB-GP1-PF.md`** 与 `shots/GP1/funnel/`。

---

## 三、验过了（裁决「二、闸」全过）

| 闸 | 内容 | 结果 |
|---|---|---|
| 1 | 只读探针从 offer_decisions 算期望值 | 9→3→2→1，offer 5，人均 0.6（与裁决估计一致）✅ |
| 2 | v185 真登录 guide_partner，四语截图漏斗/offer | EN/ZH/RU/FR 全 9/3/2/1 · 5 · 0.6 ✅ |
| 3a | 除漏斗/offer 数字外工作台文字与 v184 逐字一致 | diff 仅 4 块；四语面板数字遮罩后文本逐字相同 ✅ |
| 3b | 页面零报错 | 唯一 console.error 是 v184 同存的 `file://` 产物（非本次引入，线上 https 不出）✅ |
| 3c | 0 学生态无 NaN、人均 0.0 | 只读内存实测 avg=`0.0`、无 NaN、面板空串 ✅ |
| DB | 零写入 | 开工+收工 verify 17/17 PASS 0 FAIL ✅ |

---

## 四、请业主做的事（按顺序）

1. **先让 Claude 审这次改动**（看 `~/mh-jobs/JOB-GP1-PF.md` 的 diff 与截图）。
2. 审过无误后，**用卡去原生终端挂代理推送**（CC 不推）——主仓库本趟已点名提交 v185 文件 + index.html + jobs/JOB-GP1，提交说明以 `JOB-GP1-PF` 开头，待推。
3. 推送后在线上确认中介端版本已是 **v185**（控制台 `[VER] partner portal v185`）。
4. 线上确认 v185 后循环重开，我再接着做 review1 里被缺陷2 卡住的定版重录（ch1/2/3/5/7/8/10 带工作台的镜四语横竖、2-2/2-4/7-4/ch8 横幅/节奏、OP-3/4/5 开场快剪），完后四语过十一项重审写新的 SUMMARY-GP1。**v185 上线前不录定版**（免视频漏斗与线上不一致）。

---

本趟到此结束等审。GP-1 未收官。
