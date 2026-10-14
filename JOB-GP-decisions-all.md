# JOB-GP · GP-1 + GP-2 决定账汇总（每条一行：编号 · 章镜/问题 → 选择 · 理由）

> 明细见 ~/mh-jobs/JOB-GP1-decisions.md 与 jobs/JOB-GP2/DECISIONS.md（= ~/mh-jobs/JOB-GP2-decisions.md）。本文件为收官一行速览。

## GP-1（四语横竖成片）
- D-11-1 · ch6-6「校名揭晓」= 产品自身 reveal 渲染喂演示校数据（RULING §2.1c，ch8 先例）
- D-11-2 · ch6-7 字幕去掉「倒计时」（RULING §2.1b，最小改）
- D-11-3 · ch6 删 6-5（优惠码 ¥0 镜移 7-0），shot_count 61→60（+7-0 后回 61）
- D-11-4 · ch7 新增 7-0（¥0 优惠码，照 RULING §1），并重录 ch7 EN 横竖
- D-12-1 · ch3 全章施工（EN 横竖成片）——向导四步真机驱动 + 3-5/3-6 AI 预检用产品渲染喂样例（RULING §1.2）
- D-12-2 · 本机脸库缺口 → ch3 复位改 scoped 删、不跑全量 rebuild（记账留后趟）
- D-13-1 · ch1 注册与开通全章施工（EN 横竖成片）——未登录门禁 + 产品 render 入驻态 + 真登录已批态三段
- D-14-1 · 新建 rec/gp1-finish.mjs：OP/ED 卡成片 + 全片拼接 + 速览 + 20~40s 分段
- D-14-2 · OP-2..5 四条重点「快剪」插入暂缓（卡面承载，不改文字）
- D-14-3 · ⚠ 自审 item-3 发现：中介端 portal 页头常驻平台自有联系方式（WhatsApp/电话/邮箱）——待业主定遮蔽口径
- D-15-1 · item-3 自处理定案：平台自有页头联系「保留不遮」（选 A），解除 D-14-3 的「待业主定」挂起
- D-15-2 · item-4：1-1 EN 字幕引号标签改为逐字引用真控件
- D-15-3 · item-4：3-1 EN 字幕引号标签改为逐字引用真控件
- D-15-4 · item-4 修复的重配音+重出片（§2.2「受影响镜重配音」）
- D-15-5 · item-2 / item-8 收口

## GP-2（成片整理 + 引导页，本机准备）
- **D-GP2-1-1** · GP2-00a 联络表重出 · ch2 的 2-4 分段联络表用现成 `rec/_seg-strip-24.mjs` 重跑，该工具一次循环四语。
- **D-GP2-1-3** · GP2-00 挡法选「根 `functions/_middleware.js` denylist」而非任务书首选的「逐目录 `functions/<dir>/[[path]].js`」。
- **D-GP2-1-2** · GP2-00a 禁用词复扫 · 第 53 趟 ch6 横版复扫「登录限流」的真病根＝登录账号是 gmail，原 `_scan-ch6-forbidden.mjs` 的 MASK_INIT 作为 initScript 在登录前把 #emailInput 的真 gmail 改写成 DEMO → Supabase 返 Invalid credentials，被误判为限流。
- **D-GP2-2-1** · GP2-00b `_routes.json` 的 include 严格照 RULING-20261014b 24 条（既有 `/share/*`、`/guide/school/*` + 11 内部目录 + 11 根级文件），`exclude:[]`。
- **D-GP2-3-1** · 速览(trailer)分段重切口径 · 照 g9b-02-segment-school 的贪心，新 `jobs/JOB-GP2/gp2-01-trailer.mjs`（GP1 原件只读，不改）。
- **D-GP2-3-2** · 流畅档(lite)编码参数 · 新 `jobs/JOB-GP2/gp2-01-lite.mjs`（照 G8 lite-transcode cp 改）。
- **D-GP2-3-3** · 媒体模型（供 GP2-03 页面契约）· 参照线上学校页(segment-based，与伙伴端最近)定：整片 HD=单 master、整片 Lite=full 分段串播；速览 HD=单 master、速览 Lite=trailer 分段串播；十章目录章 HD=`ch<N>-<o>-<lang>.mp4`、Lite=`ch<N>-<o>-<lang>-lite.mp4`（弱网降档兜底）。
- **D-GP2-3-4** · 海报/缩略图/分享图实现 · 本机已装 cwebp，直接 `ffmpeg 抽帧→cwebp(-size 目标字节)` 控大小（省掉 posters.mjs 的 Chromium canvas 迂回）；抽帧点：章取片中(dur×0.5 代表帧)、整片/速览/封面取 t=1.0 开场品牌卡。
- **D-GP2-4-1** · 桶键模型 + 分享图不入桶 · 桶键照任务书前缀 `guide/partner/v4/<lang>/<land|port>/`：章 HD=`<o>/ch<N>.mp4`、章 Lite=`<o>/ch<N>-lite.mp4`、整片/速览 HD master=`<o>/full.mp4`、`<o>/trailer.mp4`、流畅段=`<o>/segments/…
- **D-GP2-4-2** · HD 段与 OP/ED 不上传 · 页面 HD 走单 master（整片/速览/章），不播 HD 分段（D-GP2-3-3）；OP/ED 已含在 full master 内、页面不单独引用。
- **D-GP2-4-3** · 清单字段契约（供 GP2-03）· 每语三份：`manifest.json`(HD+展示：章标题四语、章/整片/速览的 url+dur+poster、cover)、`lite-manifest.json`(章 lite url+dur、full/trailer 流畅段 url+dur 串播序)、`seg-manifest.json`(段 dur+shots+url 供串播与核验)。
- **D-GP2-4-4** · 幂等与读回核验口径 · `gp2-upload.sh` 读 `gp2-upload-plan.tsv`(local\tkey\tbytes\tmd58)逐个处理：先 HEAD `media.maxhouses.net/<key>`，200 且 content-length==本机字节即跳过(已在且一致)；否则经 `jobs/r2-put.sh`(它读 .en…
- **D-GP2-5-1** · 页面消费清单＝运行时 fetch，不内联 · 伙伴页比学生页多「横竖双画幅」且每文件带 `?v=md5`（4 语×2 画幅×~64 文件≈512 条 URL），全内联会把单文件顶过 ≤60KB 闸。
- **D-GP2-5-2** · 四条重点取 captions-v1.json keypoints 的整句(en/zh/ru/fr) · 该文件四语整句俱全，且 `en`/`zh` 与 storyboard §一「口播 EN/中」一字一致（任务书「英中照 storyboard §一 原文一字不改」）；ru/fr 用其 `ru`/`fr`（任务书「俄法用 captions-v1.json 的 keypoints」）。
- **D-GP2-5-3** · 复用共享品牌图 + 章节重点/辅助标记 · 顶部品牌图(hero logo + 微信缩略图)复用线上已存的 `media.maxhouses.net/guide/student/v2/brand-300.png`（通用 MAXHOUSE 标，非学生专属，HEAD 实测 200），不新造资产。
- **D-GP2-5-4** · og:image 同源服务 · 承 D-GP2-4-1，四语分享图 `share-<lang>.jpg` 随页面 commit 进 `guide/partner/`，og:image/twitter:image = `{PAGE_URL}/share-<lang>.jpg`，切语言时 `setMeta` 同步换本语言分享图。
- **D-GP2-5-5** · 本地闸＝全站 route 截流 + 章帧测「播放→首帧」· `jobs/JOB-GP2/gp2-03-gate.mjs`：`page.route('**/*')` 把 `www.maxhouses.net/guide/partner/*`→本机页、`media.maxhouses.net/*`→经 `gp2-upload-plan.tsv` 的 key→lo…
- **D-GP2-5-6** · 缓存规则/headers 照 /guide/student 克隆 · CF 缓存规则 `jobs/JOB-GP2/cf/guide-partner-html-cache-rule.json` 逐字段克隆线上 `guide-student-html`（edge_ttl=bypass_by_default、browser_ttl=respect_origin、c…
- **D-GP2-5-7** · 界面文案(非重点句)俄法由 CC 译 · h1/副标/intro/按钮/画幅与注册区标签等界面 chrome 由 CC 从英译俄/法（金额/专名/按钮口径保留）；画幅切钮俄文用短「Верт./Гор.」避免挤表头。
- **D-GP2-6-1** · 【线上阻断缺陷 + 修法】引导页清单跨源 fetch 被 CORS 挡 → 改同源清单 · **病根**：GP2-03 页面 `fetchManifest` 用 `fetch('https://media.maxhouses.net/guide/partner/v4/<lang>/manifest.json')` 跨源取 JSON，而 media.maxho…
- **D-GP2-6-2** · 【修正】CF 缓存规则克隆对象错了 · RULING-20261014d 实读线上缓存 ruleset 发现：学生页实际命中的是 `guide-student-html-cache`（最后匹配、edge_ttl=**respect_origin**＝边缘真缓存），而非先匹配的 `guide-student-html`（edge_ttl=bypass_by_default）。
- **D-GP2-6-3** · G-9 收尾脚本 bash 3.2 兼容 · `jobs/JOB-G9/cleanup-apply.sh` 的 `--apply` 分支用 `mapfile`（bash 4.0+），macOS 自带 /bin/bash 3.2.57 无此内建，业主卡两趟因无 bash4 跳过 G-9 收尾。
- **D-GP2-6-4** · 【教训】shell 变量后紧跟全角/非 ASCII 字符一律用 `${var}` + 真改真传路径要在本机跑假模式 · 承 RULING-20261014d 第4条：卡 1388 真跑 gp2-upload.sh 在 /bin/bash 3.2 line 72 即死——`$KEY` 后紧跟全角字符（UTF-8 首字节 0xEF）被 3.2 当作变量名一部分报…
- **D-GP2-7-1** · 线上真验口径定案——`gp2-04-verify.mjs` 的 `quick_playing`/整片播放判据由**单点采样**改**窗口采样 currentTime 真前进**（≥2~3 次推进）。
- **D-GP2-7-2** · 弱网降档闸加 400ms 绑定 settle + 单次补点，吸收多 context 连跑后偶发漏点（非页面缺陷，专项探针 3/3 reliably seqNav 1ms 显示）。
- **D-GP2-7-3** · 新增「整片 HD 母带连续播放」专项（hd 档正常网，断言单 master 非分段 + 窗口采样前进 + 0 控制台错误），补齐任务书「速览/整片能播」中整片一路的线上实证。
- **D-GP2-7-4** · 慢3G（400kbps）点章 ~6s 超 ≤4s 线，**如实标红不追加**（任务书 §GP2-04-2 授权；直连 6.07s/代理 6.77s 一致，属物理带宽下限，再压伤画质违码率下限）。
- **D-GP2-7-5** · 第 2 次访问 cf-cache-status=DYNAMIC 记录为**预期**（/guide/partner 边缘缓存规则属 GP2-06 业主卡，CC 不执行），非缺陷。

> 合计：GP-1 15 条 + GP-2 28 条。
