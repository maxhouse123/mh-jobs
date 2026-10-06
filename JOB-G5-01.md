# JOB-G5-01 · 速度优化（先量后改，每项带改前改后）

日期 2026-10-06 ｜ 包 G5-01 ｜ 页面：guide/student/index.html + _headers（未推，推在 G5-02 闸后）

## 一句话结论
做了两件真有收益的事：**①把列表那 13 张小封面从"偷偷拉大图"换成真正的小图**，首屏图片字节直降约 88～91%（约 390KB → 35～47KB）；**②给引导页 HTML 加了"过期后先回旧版再后台更新"的缓存头**（降重访/传播时的首字节等待）。另外几项候选逐一量过：有的页面本来就已达标、无需动；最重的"全部视频再出 720p 低清版"评估为代价过大且当轮必达指标不靠它，本轮不做并写明原因。

## 改动一·列表缩略图（最大收益）
**改前**：列表每条封面 `<img class="cover">` 直接加载大海报 `.../v2/<lang>/posters/cNN.webp`（单张约 33KB，c01 实测 34178B），13 张首屏共约 380～422KB，却只显示 54×96 像素。
**改法**：
- 用 jobs/JOB-G1/g5-make-thumbs.mjs 从大海报下采样出 216×384 小图（webp，逐级降质到 ≤8KB），落 `/tmp/g5thumbs`，经 jobs/r2-put.sh 传到新路径 `guide/student/v2/<lang>/thumbs/cNN.webp`（52 个对象，不覆盖任何 v2 已有海报）。
- 页面新增 `thumbFile(n)` 解析函数（与海报同基名，含 en 第 6 章的 c06-b 覆盖）；列表 `<img>` 改指小图，并补 `width="54" height="96"`（消 CLS）、`decoding="async"`、前 2 张加 `fetchpriority="high"`。**播放器打开后仍用大海报**（mountPlayer 不变），小图只用于列表。

**改前 → 改后（列表图片字节，两法交叉验证）**：
| 语言 | 改前(海报,首屏) | 改后(缩略图合计) | 降幅 |
|---|---|---|---|
| en | ~390 KB | 42.5 KB（硬盘实测）/ 43 KB（限速抓包） | −88.9% |
| zh | ~380 KB | 35.0 KB | −90.8% |
| ru | ~378–410 KB | 45.2 KB | −88% |
| fr | ~388–421 KB | 47.2 KB | −88% |

- CLS 布局抖动：改前 0 → 改后仍 0（补了显式 width/height，稳）。
- 缩略图 52 个单张 1.6～5.0KB，全部 ≤8KB 目标 ✓。
- 本地渲染核验：en 列表 13/13 张小图成功加载，naturalWidth=216 naturalHeight=384 ✓（截图 /tmp/g5-after-list.png）。
- R2 上线核验：52/52 http=206、content-type=image/webp ✓。

## 改动二·缓存头 stale-while-revalidate
**改前**：`_headers` 里 `/guide/student/*` 只有 `Cache-Control: public, max-age=300`；线上 cf-cache-status=DYNAMIC（边缘不缓存 HTML，每次回源）。
**改后**：改为 `public, max-age=300, stale-while-revalidate=86400`——过期后 1 天内边缘先秒回旧版、再后台拉新版，降重访/传播链路的首字节等待；max-age 维持 300 便于内容及时更新。
**核验时点**：边缘命中效果只在线上才看得到，放 G5-03 线上重测（看 cf-cache-status 与 TTFB）。另两项已线上确认：**Brotli 已开**（HTML 响应 content-encoding: br）✓、**媒体对象 immutable**（poster 响应 cache-control: public, max-age=31536000, immutable）✓。

## 其余候选项（量过的结论）
- **首帧更快（候选#2）**：现页面本就是"章节展开才建 `<video>`、preload=none"的按需加载；点第 1 章到出画面 4G 中位数 0.53～0.78s，已 ≤1.0s 目标 ✓；video 带大海报占位不黑屏。→ **测过、已达标、无需改**。
- **内联瘦身（候选#5）**：CSS 覆盖率实测仅 3% 未用（128/4328 字符，均为 focus-visible/toast/QR 等合法状态）；HTML gzip 后 9499 字节（Brotli 更小），已 ≤10KB 目标。→ **测过、已达标、不改**。
- **预连接（候选#6）**：`<link rel=preconnect href=media.maxhouses.net>` 已在 `<head>` 最前。→ **已有、不改**。
- **弱网 720p 低清版（候选#3）**：评估代价——需对 4 语 × (13 章 + full + quick) ≈ 60 个视频整体重编码 CRF25 + 上传，耗时以小时计、无人值守风险高；而本轮**必达指标**（4G LCP / 慢3G FCP / CLS / 点第1章到出画面4G）均不依赖它，业主首要诉求"页面打开速度"已由缩略图解决。→ **本轮不做**，建议留作专轮（独立出片块）再上，届时顺带做低流量/高清开关。

## G5-01 目标闸 vs 现状（页面侧改动后）
| 闸 | 目标 | 状态 |
|---|---|---|
| CLS | ≤ 0.02 | ✅ 0 |
| 点第1章到出画面 4G | ≤ 1.0s | ✅ 0.53–0.78s |
| 慢3G FCP | ≤ 2.5s | ✅ 1.18–1.73s（基线已达） |
| 4G LCP | ≤ 1.2s | ⚠ 1.29–1.82s：LCP 元素是正文**文字**，受 TTFB（连 CDN 建连接 1.1–1.6s）主导，页面侧改动难直接压；唯一杠杆=边缘缓存 HTML（本轮已加 swr），线上重测验证，若仍超将如实写明"非页面代码可控"。 |

## 产出物
- 页面：guide/student/index.html（thumbFile + 列表改小图）—— 未推。
- 配置：_headers（/guide/student/* 加 swr）—— 未推。
- 脚本：jobs/JOB-G1/g5-make-thumbs.mjs（已有）、g5-measure-local.mjs（本包新增，本地改后测量器）。
- R2：guide/student/v2/<lang>/thumbs/*.webp（52 个新对象，已上线 206）。

## 遗留/须清
- **首次误传路径**：我首轮把缩略图传到了 `guide/student/v2/thumbs/<lang>/...`（层级写反），已改传到正确的 `guide/student/v2/<lang>/thumbs/...`。那 52 个写反路径的对象成了**孤儿**（页面不引用、无害），但 r2-put 只许删 v1/_probe，无法本轮清除——**列为待清**，建议后续授权一次性删 `guide/student/v2/thumbs/` 前缀。
