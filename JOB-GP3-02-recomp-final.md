# JOB-GP3-02 路线丙 · 新引擎全 80 章重跑 + 双闸统一绿 + 派生设计定案（2026-10-15 第 9 趟）

承第 8 趟（橙色像素法复核 74 解析镜、§一.2 例外实现、ch7 修齐双闸过）。本趟把第 8 趟做好的新引擎（自动读 ring-override + §一.2 例外 + subAbs 字段）**整体重跑全 80 章**，让全部 recon 统一带 subAbs、两道闸统一复测一遍绿，刷新 summary；并把「派生」这一步的做法查清定案（发现一处必须改的正确性点），留下趟照单施工。

## 做了什么（全部可复验）

### 1. 新引擎重跑全 80 章（RULING-20261015e §一）
- `recomp-all-v5.mjs` 以 `--force` 分两段重建（`--force` 会重置 summary，故先 force 跑 chs1-5×4语×2画幅=40 章重置+填，再不带 force 跑 chs6-10 追加另 40 章）。
- **结果：80/80 章重合成成功；时序全过章 80/80；follow 镜总数 384，超标镜 0。**
- 全 80 份 recon 现**统一带 `subAbsStart/subAbsEnd`**（字幕窗绝对坐标，例外镜已后移到环亮起）——核对脚本实测 `recon files: 80 / with subAbs: 80`。
- 其中 **8 镜为 `follow-exception`**（7-0「¥0 优惠码」×8 变体，走 §一.2 不剪头+开头静默）；**16 镜带 ring-override 标记**（7-0×8 + 7-1×8）。

### 2. 双闸统一复测（RULING-20261015e §五 跟随框闸）
- **暗罩法闸（verify-timing-v5）**：全 80 章 376 个常规 follow-realign 镜 maxOnDelay ≤0.25、maxOffGap ≤0.04，逐章「时序过」。
- **橙色像素法成片闸（verify-ring-composite-v5）**：ch7 全 8 变体的 7-0（例外）+ 7-1（override 重对齐）逐镜复测，|onDelay| 与 offGap 全 ≤0.3：
  - 7-0：land en/zh/ru/fr onDelay −0.03~−0.08；port en/zh/ru/fr −0.05~+0.02。
  - 7-1：land ≈0；port +0.23~+0.25（仍在 0.3 闸内）。
  - 8/8 变体「结果：全过 ✅ 阈值 0.3s」。
- 口径一致（RULING-e §五取代任务书 0.2s）：|亮起−字幕起|≤0.3、|熄灭−字幕止|≤0.3、定格算亮着。

### 3. 字幕带学生规格（§三.1）——已在引擎内，待业主肉眼（铁律15）
- `overlays-v5.subtitle`：不透明紫带（去掉 v4 的 `e6` 半透明）、白字加粗 700、字号 `h*0.26`、最多两行居中；带高沿用 `subH`：竖版 224px（≈学生片实测 1080×1920 带高 ~224、字 ~52）、横版 140px；带顶 `subY=H−subH`。
- 这套规格已随本趟全 80 章烧进成片。**视觉最终规格按铁律15 属业主本地 file:// 肉眼双闸，列停点二乙**，CC 不自行定「长得对」。

### 4. 派生做法查清 + 一处正确性点定案（给下趟照单施工）
派生链 = ①`gp1-finish --stage film`（拼 OP+ch1..10+ED → `full-<o>-<lang>.mp4` + `segments/<o>/full-<lang>-segNN.mp4`）②`gp2-01-lite`（章/整片段转 lite）。查出**必须改的正确性点**：
- `gp1-finish` 的 `splitChapter/chapterShotDurs` 是用 **prod-ch 原始公式**重算每镜时长再按 `total/recon` 比例切段的。**v5 章因剪头/定格，真实每镜时长已变**，用旧公式切会切错点（联络表取帧同理）。
- **正解**：v5 的派生 splitter 必须**读 v5 `recon.json` 的 `shots[].clipStart/clipEnd`**（已实测存在，即每镜在成片内的真实起止）来定切段边界，不再重算公式。
- OP/ED 片段本身不改（RULING §三.2），`REC/out/_book/<lang>/<orient>/` 下 OP-1..6 / ED-1..2 直接复用。
- 速览 trailer 及其派生、分享图**不动、不重传、清单继续指向 v4**。
- 故下趟建 `gp3-derive-v5.mjs`（cp 自 gp1-finish，DIST→partner-v5、splitter 读 recon clip 边界、只跑 film 不跑 trailer）+ `gp3-lite-v5.mjs`（cp 自 gp2-01-lite，DIST→partner-v5，只做 chapters+fullseg）。

## 验收证据
- `jobs/JOB-GP3/recomp-all-v5.summary.json`：80 章逐章 res/audio/dur/shots/timing（全 pass）。
- 终端实录：RUN A built 40/40、RUN B built 40/40，汇总「时序全过章 80/80，超标镜 0」。
- ch7 橙测 8 变体逐镜 PASS 清单（本趟终端）。
- subAbs 覆盖核对：recon 80 / with subAbs 80 / follow-exception 8 / override 16。

## 下趟做什么（朝停点二乙）
1. 建 `gp3-derive-v5.mjs` + `gp3-lite-v5.mjs`（按本趟第 4 点正确性点），重出整片/分段/lite 到 partner-v5；核对段时长 20~40s、分辨率、A/V 同步。
2. 全闸（§五）：联络表（四语横竖 ch1-10，ch3 竖版新录单独一张）、禁用词扫描、片尾二维码解码、无 PII、字幕带规格闸、剪头/定格清单（最差 12 处对比图推 shots/GP3/）。
3. 重建 m/<lang>/ 两份清单（manifest + lite-manifest + seg-manifest），?v= 用新 md5；cp gp2-upload.sh 改 v5 前缀出上传计划 --dry-run。
4. 页面 §四两处（静音 emoji→内联 SVG 单色两态图标 + 查默认静音是页面还是工装、保证点章有声）+ 版本串 bump（gp2-20261015b）。
5. 写停点二乙请示单。fr-land 6-1 残疑随派生前再定（或直接列业主肉眼）。

## 没碰红线
只读 rec/out + voice + ring-override；成片全落暂存 `~/guide/dist/partner-v5`（仓库外、不入 git、未碰线上 v4）；本趟只重跑既有引擎 + 刷新 `recomp-all-v5.summary.json`，未新增/未改任何脚本源码；未改端口/首页/guide 既有文件、未动数据库、未推主仓库、未传也未删 R2、未碰 Cloudflare。
