# JOB-G8-00 · 体检先红（只读）— 第 1 趟（部分完成，可续）

日期 2026-10-10　机器 Mac mini　本趟代号 G8-00（第 1 趟）

## 一句话
G-8 第一包是「只读体检 + 先红」。本趟把**不花长时间、能立刻拿到真数据**的部分做完了：付款单旧名在哪几处、三个接口现状、Cloudflare 缓存现状、页面/媒体的真实缓存命中、测速工具写好并跑通一格验证。**还差**：完整测速矩阵（要跑几十格、每格最长 90 秒，太长，下一趟专门跑）、视频文件规格（moov 分析）、第 10 章坏排版截图、脸的摸底、清理摸底。下面逐条交代，并给下一趟可照抄的命令。

---

## 已拿到的真东西

### 1) 各端现役版本（从各 index.html 跳转读出）
- admin **v249**、student **v411**、school **v245**、reviewer **v46**、partner **v182**。
- G8 产品改版新版号起点：student v412 / partner v183 / admin v250 / school v246（school 本包不需改付款单，见下）。

### 2) 付款单旧名在哪几处（§3.1 要改的全集）
grep 只在**现役文件**里找（历史版本文件不碰）：

| 端 | 有没有旧名 | 说明 |
|---|---|---|
| student v411 | **有，多处（四语）** | payment.title / payment.amountDesc / payment.serviceFee.lead / coupon.banner100 / unlock.payDesc + 两处内联 HTML（第 4307、6266、6268、6304、6322、6845、15299、16382、16463 行一带），四语词典都要改 |
| partner v182 | **有，多处（四语）** | 同上 + `payment.detail.serviceName`「中介服务费」+ `payment.timelinePaid` + `admission.privacyDesc` 里「中介服务费」 |
| admin v249 | **有，2 行** | 优惠码提示/汇总里的「中介服务费全免」「仅中介服务费 ¥3,000」（coupon 文案），§3.1 说"有就改" |
| school v245 | **无** | 学校端不渲染付款单（学校是发 offer 方不是付款方） |
| reviewer v46 | **无** | — |
| supabase functions/migrations | **只有注释与词库** | `ai-translate/index.ts` 有翻译词库 `["中介服务费","агентский сбор","frais d'agence"]`；迁移 0069/0078 里是 SQL 注释。**没有把发票名字存成文字的表/列/邮件模板/云函数**。 |

- **是否存成历史数据行**：没查到"发票/支付表把发票名字存成文字列"的地方——付款单标题是前端 i18n 词典里的，不是库里的行。所以 §0.6 第一条（历史行改不动）**基本不触发**；仍待在清理/接口趟顺带确认 payments 台账表无文字名列。
- **法律文本检查（§0.6 停的条件）**：付款说明句是付款弹窗里的 UI 文案（payment.serviceFee.lead），**不是**独立的用户协议/收费说明法律文档；未发现把"中介服务费"写死进协议类法律文本。→ **不触发停**（下一趟改时再最后扫一遍"协议/条款/terms"关键词确认）。

### 3) 三个接口现状（§3.2）
用 `bash jobs/db-run.sh jobs/JOB-G8/probe-rpcs.sql` 和 `probe-istest.sql`（只读 begin/rollback）读出：
- `search_students_blind` / `match_task_candidates` / `get_task_candidates` 三个都是 **SECURITY DEFINER**，都 GRANT 给 `authenticated`。
- **三个都没有任何 is_test 过滤**（函数体里 `position('is_test')` = 0）。→ **先红成立：接口不过滤**。
- `students.is_test`：true=**50**、false=**11**（有 11 名真学生）。`schools.is_test`：true=**14**、false=**1**（1 所真校）。两列都已存在（之前迁移 `0188_is_test_flag.sql` 建的列，但当时没给这三个接口加过滤）。
- **调用方（§0.6 停的条件）**：真正 `rpc()` 调用这三个接口的**只有 school 端**（search 11 次、match 1 次、get 9 次）。admin 端那 1 处是**注释里提到**，不是真调用；reviewer/partner/云函数**都没有**。→ **不触发停**，可以安全只对"调用方是学校账号"加过滤。

### 4) Cloudflare 现状（只读 GET，存 `jobs/JOB-G8/cf-before.json`）
- zone：maxhouses.net，id `3dad665936b18cbac6ddb6e5f1002c1c`，active。
- **令牌权限不够读 Zone 设置**：http3 / 0rtt / early_hints / brotli 全部回 9109/10000 Unauthorized。→ 缺权限 **`Zone.Zone Settings:Read`（G8-01 改还要 `Zone.Zone Settings:Edit`）**。按规矩不停工，记下继续。
- `tiered_cache` smart topology = **off**（G8-01 要开，但开也可能缺 `Cache:Edit` 权限，到时再看）。
- 缓存规则（phase http_request_cache_settings，ruleset `089dcbc46c72420fa3112b08cc267ea9`）现有 3 条：
  - `portal versioned html`：五端 maxhouse* 路径，edge **bypass_by_default**；
  - `guide-student-html`：路径 `/guide/student` 开头，edge **bypass_by_default**、browser respect_origin；
  - `guide-html-cache`：`/guide/school/`（排除 api/media/admin），edge **respect_origin**。
  - **没有** media.maxhouses.net 的缓存规则（规则都只管 www）。

### 5) 真实缓存命中实测（curl，真直连 vs 代理分开，脚本 `jobs/JOB-G8/probe.sh`）
**出乎预期：边缘缓存基本已经在工作**（预期的"HTML/媒体非 HIT"这条**没红**）：
- 代理路（海外学生）：页面 + 媒体第 1/2 次**几乎全 HIT**，TTFB 稳定 ~0.65s。
- 真直连路（国内老师，已清掉环境代理）：TTFB **1.0–2.2s、波动大**；页面第 1 次 UPDATING/EXPIRED、第 2 次 HIT；个别媒体第 1 次 MISS、第 2 次 HIT。
- 结论：**"2 次后 HIT"已达成**；真正的痛点更可能是**视频首帧前要下的字节（moov/首段）**和**国内直连到 Cloudflare 的高 TTFB/波动**，不是 HTML 不缓存。完整判定等测速矩阵。
- ⚠ 口径提醒：`probe.sh` 原先直连路会偷偷走环境里的代理（两路测成一样），已修成直连强制 `--noproxy '*'` 并 unset 代理变量；重测即真直连。

### 6) 测速工具已写好并跑通一格
- `jobs/JOB-G8/measure.mjs`（Playwright）参数：`--line student|school --lang --path direct|proxy --net none|4g|3g|slow3g --what ch1|full|quick --quality hd|lite [--runs 3] [--qparam lite]`。
- 跑通一格（student en / proxy / 4G / ch1 / hd / 1 次）：page TTFB 711ms、首屏 11KB、**TTFF 591ms**、首帧前字节 ~1.32MB、卡顿 1 次/553ms、该次 cf=MISS。证明脚本能真点章、真等 `playing`、真数卡顿。
- 已把 `node_modules` 软链到 `~/mh-verify/node_modules`（同 JOB-G1 办法）。
- ⚠ 已知小限制：`bytesBeforeFirstFrame` 目前统计的是该视频对象**整格内收到的字节**（上限值），不是严格"首帧前"；因 before/after 用同一脚本同一口径，**相对对比有效**，先这样用，收官若需精确再细化。

### 媒体对象真实映射（学生页 D.OVERRIDE 读出，供规格/清理/重录用）
- base：`https://media.maxhouses.net/guide/student/v2/<lang>/`；章 1-3 = `c01/c02/c03`（无后缀），章 4-13 = `c04-g7 c05-g6b c06-g6b c07-g7 c08-g7 c09-g6b c10-g7 c11-g6b c12-g7b c13-g6b`，full = `full-g7b`，quick = `quick-g7`，海报在 `posters/`。
- 学生页构建串 `g7b-2026-10-10`（G8 目标 `g8-2026-10-10`）；学校页 `gs7-20261010`（目标 `gs8-20261010`）。

---

## 闸的真实命令输出（节选）
- `bash jobs/db-run.sh jobs/JOB-G8/probe-istest.sql` → students is_test t=50/f=11；schools t=14/f=1；三函数 has_is_test_filter = f/f/f。
- `bash jobs/cf-api.sh GET /zones/<id>/settings/http3` → `9109 Unauthorized`。
- `bash jobs/JOB-G8/probe.sh direct` / `proxy` → 见上 §5（直连 TTFB 1–2.2s、代理 ~0.65s，2 次后均 HIT）。
- `node jobs/JOB-G8/measure.mjs --line student --lang en --path proxy --net 4g --what ch1 --quality hd --runs 1` → TTFF 591ms。

---

## 先红表（现状，初判；带★的待测速矩阵/截图最终确认）
| 项 | 预期红 | 实测 | 判 |
|---|---|---|---|
| 学生页 HTML 2 次后非 HIT | 红 | 2 次后 HIT（直连/代理都是） | **绿**（反而不红） |
| 媒体 2 次后非 HIT | 红 | 2 次后 HIT | **绿** |
| 国内直连 TTFB 高/波动 | — | 1.0–2.2s 波动 | 🔴 真痛点之一 |
| 慢 3G 速览 TTFF ≫ 6s | 红 | ★未测（下一趟矩阵） | 待测 |
| 视频首帧前字节大 | — | ch1@4G ~1.3MB | 🔴 疑似真痛点 |
| 付款单旧名 ≥1 处 | 红 | student/partner/admin 多处 | 🔴 成立 |
| 三接口不过滤 is_test | 红 | 三个都不过滤 | 🔴 成立 |
| ch10 坏排版 | 红 | ★未截图 | 待查 |
| near_group=2 | 红 | ★未摸底 | 待查 |
| 未引用对象 >0 | 红 | ★未摸底 | 待查 |

---

## 还差什么 + 下一步（下一趟从这里接着做，不重做上面已完成的）
**仍属 G8-00 的未完成项（建议下一趟先把矩阵跑了）：**
1. **完整测速矩阵**（§0.3）：用 `measure.mjs` 按矩阵跑 student(en+zh) + school(zh)，direct/proxy × none/4g/3g/slow3g × ch1/full/quick，每格 `--runs 3` 取中位，结果汇 `jobs/JOB-G8/speed-before.json`。**很长**，建议单趟就干这个，前台分段、每格打一行进度。先跑 1 格 `--runs 3` 估单格耗时再排期。
2. **媒体文件规格** `jobs/JOB-G8/media-specs-before.json`：对每个线上对象 Range 取前 2MB 解 atom（ftyp/moov/mdat 偏移与长度）+ ffprobe（时长/码率/分辨率/fps/关键帧/音频）。回答两问：①整片/速览 moov 多大、按 400kbps 要几秒出首帧；②哪些文件 moov 不在头。
3. **第 10 章坏排版**：guide_stuA 用 Playwright 390 宽 + 1366 宽打开"录取后补充信息表"，截 `shots/G8/ch10-before-390.png` / `-1366.png`，定位 CSS/结构病根。
4. **脸摸底**：读 `jobs/JOB-G6b/` 配对表，列 near_group 两名测试生（加纳/赤道几内亚）+ 尼日利亚 Chidi 的学生 id/邮箱别名；用录制 DOM 快照查三人出现在哪些章画面。
5. **清理摸底**（只列不删）：列公开桶 `guide/student/v2/`、私有桶 `guide/school/v1/zh/`、Supabase `student-documents` 下 50 名 is_test 学生 `photo/`；对照线上学生页 HTML 的 mp4/webp 引用 + 学校 manifest，算未引用集数量与字节。
6. 把 `speed-before.json`/`media-specs-before.json`/`cf-before.json` 复制到 `~/mh-jobs/` 加 `JOB-G8-00-` 前缀（本趟先复制了 cf-before）。

**本趟已写入主仓库（仅 commit，不 push）**：`jobs/QUEUE-G8.md`、`jobs/QUEUE-G7b.md`、`jobs/JOB-G8/{measure.mjs,probe.sh,probe-rpcs.sql,probe-istest.sql,cf-before.json}`。
**无"必须停"触发**（付款单无法律文本、接口只有学校端调用）。
