# JOB-G8-04c —— 学校线流畅版转码收口 + lite-manifest + 页面施工图（§5 包 G8-04 续，半成品可续）

日期 2026-10-10　机器 Mac mini　本趟代号 G8-04c。大白话。

## 一句话
接 G8-04b（学生线 lite 已 60/60），本趟把**学校线流畅版全部转码出来并全过闸**（17 个，zh），
把两线的流畅文件清单汇总成一个 `lite-manifest.json`，
再把剩下最大的一块活——**两页「高清/流畅」双档开关 + 弱网自动降档 + 流畅整片串播 + 传桶 + 走查**——
写成一张**自包含施工图**（下趟照着一次做完，不用再翻别处）。
**没改任何产品网页、没传桶、没推送**；没有「必须停」的事。

## 二、本趟实际做掉的（都已 commit，可验）

### 1. 学校线流畅版（zh）全量转码——17 个全过五闸 ✅
- 先核对：学校线 14 章 + 速览 + 整片的本机源 `guide/dist/school/zh/` 与**线上私有桶对象逐字节一致**（md5 前 8 位 == 线上 manifest 的 v，16 个全 OK）。所以**直接本机转码，不用走私有桶鉴权下载**，满足 §0.4「源与线上字节一致」。
  - 线上学校各章用的真实对象名（从 guide/school/v1/manifest.json 读的）：c01/c03/c04/c09 原名，c02/c05/c06/c11/c12/c14=-g7，c07/c08/c10/c13=-g6b，full/quick=-g7。
- 开场卡 `intro-lite-g8`、片尾卡 `endcard-lite-g8`：用本机已建的 HD 开场/片尾片（c00-intro.mp4 / c99-ending.mp4，是 full 里真用的那两段）转，横版 960×540。
- 转码脚本 `lite-transcode.mjs` 补了个真 bug：原来输出路径写死 `guide/dist/<lang>`，学校线会错写到学生 zh 目录——改成 line-aware（学校→`guide/dist/school/<lang>`）。真放脚本 `lite-play-all.mjs` 同样修。
- 跑法：`node jobs/JOB-G8/lite-transcode.mjs --line school --lang zh --srcdir jobs/JOB-G8/lite-src/school-zh --names c01..c14,quick,intro,endcard`（lite-src/school-zh 是 17 个硬链接，把带后缀的线上对象名映射成平名 cNN，这样输出就叫 cNN-lite-g8）。
- **五闸真实输出（全 PASS）**：
  - 分辨率 == 960×540：17/17 ✅
  - moov 在 mdat 前（+faststart）：17/17 ✅
  - 平均码率 ≤ 350 kbps：实测 145~221k，17/17 ✅
  - 时长与高清差 ≤ 0.1s：章节全 0s、intro/endcard 0.01s，17/17 ✅
  - 无头真放 3s 无 error（系统 Chrome，含 H.264）：**17/17 PLAY-OK** ✅
  - 体积 ≤ 高清 60%：章节 37%~62.3%；intro 76%、endcard 69.3% **超 60%**——§0.4 写明「超了如实写、不算红」，这两个是短静态卡片，压缩比天然低，不判红。
  - 原始记录：`jobs/JOB-G8/lite-gate-school-zh.json`（17 条，含 src/srcMd5/dstBytes/res/kbps/durDelta/moovBeforeMdat/pass/playOk）。

### 2. lite-manifest.json ✅（§5.1）
- `jobs/JOB-G8/lite-manifest.json`：汇总学生四语 60 个 + 学校 zh 17 个，每条含 name/file/srcMd5/dstBytes/seconds/kbps/res/pass/playOk。
- 统计：**学生 lite 60/60 全过（pass && playOk）、学校 lite 17/17 全过**。

### 3. 页面双档/传桶/走查 自包含施工图 ✅（给下趟）
- `jobs/JOB-G8/g8-04-page-blueprint.md`：把下趟要做的 §5.2（两页双档）/§5.3（传桶）/§5.4（走查）全写死，含已实测硬数据：
  - 学生线重录 HD 章新时长（c07/c10/c12 四语 + full/quick）、ch10 四语新章名（已 grep 实证 captions-v2.json L650-653）。
  - **重要简化**：学校媒体函数读过了，是「鉴权后前缀内任意 key 都放流」，content-type 已含 .mp4——所以 §5.2「白名单放行 *-lite-g8.mp4」**根本不用改函数**，上传即可取（鉴权一字不动）。学生线走公开 CDN 也无白名单。
  - 学生页 D 对象要改的每一处（BUILD→g8、OVERRIDE c07/c10/c12→-g8、full→full-g8、quick→quick-g8、dur、ch10 章名）；双档 JS 的状态机/开关/自动判/降档/串播/位置换算写法；四语新 i18n 键（qHd/qLite/qSwitched/chOfN）。
  - 学校页构建串 gs8、manifest 加 lite/intro/endcard 条目、横版串播保持全屏。
  - 传桶清单（学生 ~104 对象、学校 17 lite 对象）、数据血缘三问已答。

### 4. Cloudflare §2 第 3 条——仍跳过（令牌无权）
- 本趟复测 `GET /zones/<zone>/settings/http3`（及 0rtt/early_hints）**仍回 9109 Unauthorized**。按规约「仍没权限就跳过不停工」。
- 待业主在 CF 后台补：`Zone.Zone Settings:Read + Edit`、`Zone.Cache Settings:Edit`（tiered cache smart topology 当前 off）。

## 三、还差什么 + 下一步（G8-04 收口，下趟照施工图做）
**学生线 lite + 学校线 lite + manifest 全好，下趟不用再碰转码。** 剩下按 `jobs/JOB-G8/g8-04-page-blueprint.md`：
1. 学生页 guide/student/index.html：改 D（BUILD/OVERRIDE/dur/ch10章名）+ 加双档 JS/DOM/CSS。
2. 学校页 guide/school/index.html + manifest（两份）：构建串 gs8 + 加 lite 条目 + 双档 JS。
3. 传桶：学生公开桶 -g8 + -lite-g8、学校私有桶 17 lite；逐个 HEAD 核字节。
4. 本地三层自验（铁律11）+ 走查 §5.4。
5. commit `JOB-G8-04:` → 写 NEED_PUSH.txt 首行 `cycle=2` → 推回执 → 立刻结束（**这才是 cycle=2 推送点**）。
> 下趟开工先：ls guide/dist/<lang>/thumbs 确认重录章小图在不在（施工图 §3.1 已标为待确认）。

## 四、本趟写入 / 推送
- 主仓库（**仅 commit 未推**，G8-04 未收口、非推送点）：
  - `f1829f3 JOB-G8-04(wip):` 学校线 lite 转码 —— lite-transcode.mjs(改) + lite-play-all.mjs(改) + lite-gate-school-zh.json。
  - `2a3c589 JOB-G8-04(wip):` lite-manifest.json + g8-04-page-blueprint.md。
  - 待推累计（全 JOB-G8 开头）：2a3c589 / f1829f3 / 1284468 / 07e791a / 1e2d674。等 G8-04 收口随 cycle=2 一起推。
- 成片 `guide/dist/school/zh/*-lite-g8.mp4`（17 个）与硬链接暂存 `jobs/JOB-G8/lite-src/school-zh/` 均 .gitignore，不入库，传桶在下趟 §5.3。
- ~/mh-jobs：本回执，push。

## 五、安全
- 转码/真放纯本机，无账号、无 PII、无钥匙；核对学校私有桶只比 md5（本机算），未下载私有对象。
- 产品 HTML 一行未改；画面无邮箱、无测试名单外真学生。
