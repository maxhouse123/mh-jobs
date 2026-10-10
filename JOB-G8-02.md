# JOB-G8-02 · 产品侧三件事（进度：§3.2 完成，§3.1 / §3.3 待续）

日期 2026-10-10　机器 Mac mini　本轮代号 G8-02（第 1 趟，部分完成）

## 一句话（大白话）
G8-02 有三件事。本趟把**第二件（三个接口按 is_test 过滤）整件做完并验过、已生效在线上数据库**；第一件（付款单改名）和第三件（第 10 章补充信息表排版）**还没做**，原因与精确落点写在下面，下一趟照着直接施工即可。**本趟还没写 NEED_PUSH**——因为 cycle=1 要等三件事都齐了（第一件改了 HTML 才需要推）再一起推。

---

## ✅ 已完成：§3.2 三接口按 is_test 过滤（迁移 0226，已应用 + 已验证）

**做了什么（大白话）**：演示用的三个学校接口，以前不分真假学生、谁都能被查到。现在改成：**演示校只看得到测试学生，真实学校只看得到真实学生**，中间一个都不串。

**怎么做的**：
- 新迁移 `supabase/migrations/0226_demo_school_is_test_filter.sql`（取 supabase/migrations 下一个空号 0226），用 `CREATE OR REPLACE` 重建三函数：
  - `search_students_blind`（脱敏逐个浏览加候选）
  - `match_task_candidates`（一键按条件圈候选）
  - `get_task_candidates`（读候选池）
- 每个函数体里只加**一条**过滤：`students.is_test = 该任务所属学校的 is_test`（学校由任务 task_code 定、调用方必是该校成员，沿用已有守卫）。
- **签名、返回列、LANGUAGE、STABLE、SECURITY DEFINER、search_path 一字不变**；CREATE OR REPLACE **保留原 GRANT**（验到 authenticated 仍在）；RLS 不碰。
- 用 `bash jobs/db-run.sh` 应用到 maxhouse_main（输出 BEGIN / CREATE FUNCTION ×3 / COMMIT）。
- 这是业主已拍板四件事之一（§0.5-2，照办不问），CREATE OR REPLACE 不删表不改数据行，符合铁律9。

**验证（真输出，jwt 模拟调用方身份、事务内 rollback 不留痕）**：
| 调用方 | 接口 | 返回总数 | 串台泄漏 |
|---|---|---|---|
| 测试校(is_test=t) ADM-100000 | search_students_blind | 48 | 非测试生 **0** |
| 测试校 ADM-100000 | match_task_candidates | 新加 2（均测试生） | — |
| 测试校 ADM-100000 | get_task_candidates | 池内 9 | 非测试生 **0** |
| 真校(is_test=f) ADM-100006 | search_students_blind | 10 | 测试生 **0** |
| 真校 ADM-100006 | match_task_candidates | 新加 0 | — |
| 真校 ADM-100006 | get_task_candidates | 池内 4 | 测试生 **0** |

→ **全 0 串台，§3.2 通过**。GRANT 仍为 {PUBLIC,authenticated,postgres}；三函数体 `has_is_test_filter` 全 t。
- 调用方摸底（G8-00 已证）：真正 rpc 这三接口的只有 school 端，admin 那处是注释非真调用，reviewer/partner/云函数都没有 → §0.6「别的调用方依赖」不触发，没停工。
- 录制层白名单（QUEUE-G7 §0.3）作兜底保留。

**已 commit 到主仓库（JOB-G8-02(§3.2):，未 push）**：`supabase/migrations/0226_demo_school_is_test_filter.sql` + 探针 `probe-rpc-defs.sql` / `probe-verify-0226.sql` / `probe-func-0226.sql`。

---

## ⬜ 待续：§3.1 付款单改名（下一趟首做，精确落点已钉好）

**现役版本**（各 index.html 跳转读出，G8-00 查定）：student **v411**、partner **v182**、admin **v249**、school v245、reviewer v46。改版新版号起点：**student v412 / partner v183 / admin v250**（school/reviewer 无付款单不改）。

**旧名命中数（现役文件 grep -c，含 EN+ZH，RU/FR 另在各语词典块）**：
- student v411 = **10 处**；partner v182 = **15 处**；admin v249 = **2 处**。

**student v411 精确行**（EN 侧，ZH/RU/FR 为各语词典同键，需一并改）：
- 4307 `data-i18n="payment.title"` 内联文案
- 6266 `payment.title`、6268 `payment.amountDesc`、6304 `payment.serviceFee.lead`、6322 `coupon.banner100`、6845 `unlock.payDesc`
- 15299 内联兜底串（unlock.payDesc 的 `||` fallback）、16382 `payment.amountDesc` 内联、16463 serviceFee.lead 内联
- ⚠ i18n 结构：payment.title 在 6266（EN 块）只现一次 → **四语是分块词典**，改时每个键要在 EN/ZH/RU/FR 四块各改一处（下一趟先 grep 定位每语块的该键行号，照铁律14 P1 键实证）。

**定稿文案（§3.1，照抄不改）**：
- 标题 payment.title：EN `Admission Letter Unlock Fee` ／ 中 `录取通知书解锁费`
- 金额标签：EN `UNLOCK FEE — TOTAL DUE` ／ 中 `解锁费 — 应付总额`
- 说明句 serviceFee.lead/amountDesc 系：EN `One-time fee to unlock this admission — reveals the school's name and your admission letter, and covers enrollment paperwork.` ／ 中 `一次性解锁费——解锁后可见学校名称与录取通知书，并含入学手续办理。`
- 正文小写 `intermediary service fee` → `admission letter unlock fee`；「中介服务费」→「录取通知书解锁费」。
- **不动**：`SECURE PAYMENT · OFFICIAL INVOICE`、金额、编号、「由合作伙伴代该学生支付」。
- **RU/FR**：CC 翻译 + 回译写回执（下一趟做；旧词俄 `агентский сбор`、法 `frais d'agence` 一并换）。

**做法要点（下一趟）**：
- 每端出新版本号文件（v412/v183/v250），**版本 bump 四件套**：①文件名 ②头注 ③[VER] 版本探针 ④index.html 重定向（student 下划线命名；partner/admin 连字符）。旧版保留。
- 闸：五端 + 云函数 grep 旧词 = 0（历史数据行除外——G8-00 已证付款单名在前端 i18n 词典、库里无「发票名存成文字列」，§0.6 第一条基本不触发；下一趟再扫一遍 terms/协议/条款 确认无法律文本写死，确认后不停）。
- 四语新词各端齐全（零裸 i18n 键）；Playwright guide_stuA 打开付款单截图 `shots/G8/fee-student-<lang>.png` 四语、guide_agent 代付单 `shots/G8/fee-partner-en.png`。
- 三层自验（铁律11）+ student 端走基线审计（铁律12，付款单属 student 基线功能）。

## ⬜ 待续：§3.3 第 10 章补充信息表排版（需业主登录态协助）

- G8-00b 已出**离线** before 图（独立 harness / 真 v411 未登录 / 去 gate 三配置），结论：**去掉未登录闸后组件横排、字段可见、渲染正常**，唯一「塌陷」是未登录闸的 display:none 假象，**疑似无真 bug**。6 张存 `~/mh-jobs/shots/G8/ch10-before-*.png`。
- **必须业主在场**用 guide_stuA 的生产登录态 + 一条真录取打开「录取后补充信息表」才能最终确认（铁律11：CC 不自驱生产登录/连库）。
  - 若 live 也正常 → §3.3 无需改组件，只在 G8-03 重录 ch10（任务书 §4 本就要重录 c10）。
  - 若 live 不正常 → 按真 bump 在组件内修 CSS/结构，出新版本号文件。
- 按 §0.6 第三条，此项**不算停**。

---

## 还差什么 + 下一步
- **下一趟 = 续 G8-02**：做 §3.1（付款单改名三端，精确行与定稿文案见上）+ §3.3（请业主协助开 ch10 live 一次）。两件齐后：全部 `JOB-G8-02:` commit、写 `jobs/JOB-G8/NEED_PUSH.txt` 首行 `cycle=1`、推回执、立刻结束本趟。
- **本趟无「必须停」触发**：§3.2 调用方只学校端、无法律文本、无数据行改写。
- **钥匙安全**：DB 走 db-run.sh 从 .env 读直连串、从不打印；jwt 模拟仅用库内 user_id（非密钥）；回执无任何密钥/密码/gmail。

## 闸的真实命令输出（节选）
- `bash jobs/db-run.sh supabase/migrations/0226_...sql` → `BEGIN / CREATE FUNCTION ×3 / COMMIT`。
- `probe-verify-0226.sql` → 三函数 GRANT 含 authenticated；has_is_test_filter 全 t。
- `probe-func-0226.sql` → 见上表，六格串台泄漏全 0。
