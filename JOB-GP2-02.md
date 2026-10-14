# JOB-GP2-02 回执 · 上传脚本与清单（本机，不上传）

趟：第 4 趟（2026-10-14）。承 GP2-01（成片整理四项全绿）。
开工核对：五端口 `git diff origin/main --stat` 为空、无未跟踪端口文件 —— PASS（零端口改动）。
本任务**不是停点**（停点＝GP2-00 已过 / GP2-03 下一个）；做完不写请示单，正常收尾。
CC **只跑 `--dry-run`，不执行上传**；真传由业主卡执行。

## 做了什么

### 1. 清单生成器 `jobs/JOB-GP2/gp2-02-manifest.mjs`（照 GS5c make-manifest 的 ?v=md5 做法）
为四语各出三份清单，写入本机 `~/guide/dist/partner/<lang>/`：
- `manifest.json` —— HD + 展示：章标题四语（源 prod-ch.mjs 的 CH_TITLE 系列，= 视频章节条烧入文案一字一致）、每画幅(land/port)的整片/速览 master(url+dur+poster)、十章(n/title/dur/hd/poster/thumb)、封面 cover。
- `lite-manifest.json` —— 流畅：每画幅章 lite(url+dur) + full 流畅段串播序 + trailer(速览)流畅段串播序（seg/dur/url）。
- `seg-manifest.json` —— 分段清单：每画幅 full/trailer 段的 dur + shots(镜头) + url，供串播与核验。
- 媒体地址一律相对 `base`（=`https://media.maxhouses.net/guide/partner/v4/<lang>`）+ `?v=<文件 md5 前 8 位>`（md5 = 本机即将上传字节；换片=改 v 即绕边缘缓存）。
- 血缘三问（铁律14②）：v 源自本机成片 /sbin/md5；缺任一成片/缩略图/海报即报错停、不产出；不兜底。
- 段 dur/shots 取自 GP-1 段清单（full=`manifest-<lang>.json`、trailer=`trailer-manifest-<lang>.json`；lite 段 dur 与 HD Δ≤0.2 等同用）。四语段数随片不同：ru full 13 段、zh trailer 8 段，生成器动态枚举、不写死。

### 2. 上传脚本 `jobs/JOB-GP2/gp2-upload.sh`（照 g9-03-upload.sh 的做法）
- 只往公开桶 `maxhouse-media` 的 `guide/partner/v4/<lang>/<land|port>/` 写新对象，**不删任何对象**。
- 幂等：先并发 HEAD 探测 `media.maxhouses.net/<key>`，200 且 content-length==本机字节即跳过（已在且一致）。
- 上传经 `jobs/r2-put.sh`（它读 `.env` 的 R2_*、自己 PUT + 读回核验；**本脚本绝不读 .env、不碰密钥**），再本脚本二次读回：HEAD 200 + Range 206 + 字节数对上。
- `--dry-run`：只并发 HEAD 分类（新/一致/不符）+ 报将上传对象数与总大小，不传、不碰 .env。
- 计划来源 `jobs/JOB-GP2/gp2-upload-plan.tsv`（528 行，local\tkey\tbytes\tmd58），由生成器产出。

### 桶键模型（D-GP2-4-1/4-2）
前缀 `guide/partner/v4/<lang>/<land|port>/`：
- 章 HD `…/ch<N>.mp4`、章 Lite `…/ch<N>-lite.mp4`
- 整片/速览 HD master `…/full.mp4`、`…/trailer.mp4`
- 流畅段 `…/segments/{full,trailer}-seg<NN>.mp4`
- 海报 `…/posters/*.webp`、缩略图 `…/thumbs/ch<N>.webp`、封面 `…/cover.webp`
- 清单 `…/<lang>/{manifest,lite-manifest,seg-manifest}.json`（清单不分画幅，一份覆盖横竖）
- **不入桶**：HD 分段与 OP/ED 独立母带（页面 HD 走单 master、OP/ED 已含在 full 内，页面取不到的字节不传）；**分享图 `share-<lang>.jpg`**（r2-put.mjs 的 CT 表无 `.jpg` → 会以 octet-stream 上传伤 og:image；不改这条共享基建，改由 GP2-03 随页面 commit 进 `guide/partner/` 由 Pages 同源服务）。

## --dry-run 结果（CC 跑，原样）

```
================================================
[DRY-RUN] 计划对象总数=528  总大小=558.0 MB
  将上传(新/缺)=528  已在且一致(跳过)=0  已在但字节不符(将覆盖)=0
  将上传字节合计=558.0 MB
  （CC 只跑 --dry-run，不执行上传）
```

### 对象分类（528 个 / 558.0 MB）
| 类 | 个数 | 大小 |
|---|---|---|
| 章 HD (ch1~10×横竖×四语) | 80 | 136.8 MB |
| 章 Lite | 80 | 67.5 MB |
| master HD (整片+速览×横竖×四语) | 16 | 232.7 MB |
| 流畅段 (full+trailer 段) | 156 | 115.5 MB |
| 海报 | 96 | 4.1 MB |
| 缩略图 | 80 | 1.2 MB |
| 封面 | 8 | 0.2 MB |
| 清单 json | 12 | 0.1 MB |
| **合计** | **528** | **558.0 MB** |

实测 `v4/` 前缀为空（528 个全为「新」，0 已在、0 不符）。

## 本机脚本/清单（入主仓库 jobs/JOB-GP2，未推）
`gp2-02-manifest.mjs`、`gp2-upload.sh`、`gp2-upload-plan.tsv` + DECISIONS。
清单三件套 json 在 `~/guide/dist/partner/<lang>/`（成片目录，不入 git、不传桶——由上传脚本上传入桶）。

## 下一步
GP2-03 引导页 `guide/partner/index.html`（本机，**停点二**）：cp 线上学生页 g9c 版改，四语/画幅自动/十章目录/速览+整片/注册区公开邀请码/分享/去下载/robots noindex/_headers 新增段/缓存规则 JSON。做完写请示单停点二。
