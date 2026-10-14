# JOB-GP2-03 回执 · 引导页 guide/partner/index.html（本机，停点二）

趟：第 5 趟（2026-10-14）。承 GP2-02（上传脚本与清单）。
开工核对：五端口 `git diff origin/main --stat` 为空、无未跟踪端口文件 —— PASS（零端口改动）。
本任务**是停点二**：做完写请示单停下，等业主卡装 RULING-*-gp2-03-live 后循环重启。

## 做了什么（全本机；未推主仓库、未传桶、未改 Cloudflare）

### 1. 引导页 `guide/partner/index.html`（新文件，单文件 44.6KB ≤ 60KB，零第三方 `<script src>`）
以线上学生页 g9c 的播放引擎为底 cp 改，适配伙伴端：
- **四语** EN/中/РУ/FR：`?lang=` → localStorage → 浏览器语言 → 默认英文；切语言同步 html lang / title / description / og。
- **画幅自动**：手机(窄屏或触屏)默认竖版、电脑默认横版，右上角可切，记 localStorage（读写 try/catch）。
- **四条橙✓**：英中照 `storyboard §一` 原文、俄法用 `captions-v1.json` keypoints（四语整句俱全；英中与口播一字一致）。
- **播放**：速览(招募片) + 整片两大按钮 + 十章目录(缩略图懒加载)；HD 走单 master、Lite 走分段双缓冲串播、弱网自动降档；下一章/续看照学生页。
- **注册区**：一行「2 个工作日内审核」(与分镜 1-7 口播一致，四语) + **公开邀请码 `MAXHOUSE-PARTNER-2026`**(页面顶部常量，换码改一行) + 复制钮；「注册你的机构」按钮链 `/partner-portal/?src=guide-<lang>`。发布前 db-run.sh 只读实证：`partner_code='MAXHOUSE-PARTNER-2026'` 为真、`partner_enabled`、全局 `enabled` 皆真。
- **分享**：WhatsApp / Telegram / 复制链接 / 微信二维码(QR 编码页面 URL)；og 按语言(og:image = 同源 `/guide/partner/share-<lang>.jpg`)；顶部品牌图复用线上 `brand-300.png`(HEAD 200)作微信缩略图。
- **去下载**：全部 video 加 `controlsList=nodownload` + `disablePictureInPicture` + 禁右键；保留分享。
- **先上线不对外**：head 有 `<meta name=robots content=noindex,nofollow>`；不挂首页、不发链接（对外＝GP2-06 去这一行）。
- 页脚：`Service@maxhouses.net` + 构建串 `build gp2-20261014`。
- 清单**运行时 fetch**（`manifest.json` + `lite-manifest.json`，`?v=<BUILD>`）——因 4 语×2 画幅×~64 文件带 ?v=md5 全内联会顶过 60KB；换片＝重传+重出清单+改页面 BUILD 一行（D-GP2-5-1）。

### 2. 分享图 + _headers + 缓存规则
- `guide/partner/share-{en,zh,ru,fr}.jpg`（og:image 同源；jpg 不入桶）。
- `_headers` 新增 `/guide/partner/*` 段（照 `/guide/student/*`：`max-age=300, swr=86400` + media preconnect Link），**只 +5 行、上方一字未动**。
- `jobs/JOB-GP2/cf/guide-partner-html-cache-rule.json`（逐字段克隆线上 `guide-student-html`：edge_ttl=bypass_by_default / browser_ttl=respect_origin / cache=true；expression 换 `/guide/partner`）。CC 不执行，留业主卡。

### 3. 本地闸（铁律11 三层自验等价 · 全站 route 截流打本机成片，绝不碰生产）
`jobs/JOB-GP2/gp2-03-gate.mjs`：四语 × 手机405/电脑1440 = **8 context × 14 项断言 ALL PASS**：
零裸 i18n 键 / 四条✓ / 十章 / 邀请码显示 / robots noindex / og 本语言 / 无横向溢出 / 可点区≥44px / 画幅自动(手机竖电脑横) / 开章出海报 / 播放首帧 **82~164ms ≤2.5s** / nodownload / 切画幅 / 切语言；零 console 错。
lite 分段串播单测另过：速览 trailer-seg01 **550ms** 出帧、seqNext 进段、零报错。
截图 8 张：`~/mh-jobs/shots/GP2/local/gp2-03-<lang>-<view>.png`。

## 决定账（本趟）
D-GP2-5-1(运行时 fetch 清单，不内联) / 5-2(四条重点取 captions 整句四语) / 5-3(复用 brand-300 + 章 ★/○ 标记) / 5-4(og 同源 share-<lang>.jpg) / 5-5(本地闸 route 截流 + 章帧测播放→首帧) / 5-6(缓存规则/headers 照 guide-student 克隆) / 5-7(界面 chrome 俄法 CC 译，有源文案用源)。详见 JOB-GP2-decisions.md。

## 主仓库提交（未推，共 4 笔待业主卡推）
- `ffadae3` GP2-03 页面 + 分享图 + _headers + cf JSON + gate/qr/probe + DECISIONS（本趟主交付）
- `fbb1231` GP2-03 停点二请示单
- 连同既有 `b0dfba9`(GP2-01 工装) + `b4d976d`(GP2-02 工装) = **4 笔**。
成片/lite/海报/清单在 `~/guide/dist/partner/`（不入 git、不传桶——由 gp2-upload.sh 上传）。

## 停点二请示单
`jobs/JOB-GP2/NEEDS_OWNER_DECISION.md`（覆盖写）+ 本趟复制到 `~/mh-jobs/JOB-GP2-NEEDS_OWNER_DECISION-20261014-1933.md`。要业主卡逐条做：①跑 gp2-upload.sh 上传 528/558MB+读回；②加 CF 缓存规则(照 guide-student-html，改前改后比对原规则不变)；③推 4 笔(四段式)；④线上逐条验(页面200/noindex/og本语言/点章出画面/邀请码/注册 src/无下载/缓存命中)；⑤装 RULING-*-gp2-03-live 重启循环。

## 下一步
等业主卡上线 + 装 `RULING-<日期>-gp2-03-live.md` 后，接 **GP2-04**（线上真验 + 测速，只读）。
