# JOB-GP3-02 路线丙第 10 趟回执 · v5 派生：整片 / 分段 / lite 四语重出

日期：2026-10-15（接第 9 趟「全 80 章重合成到 partner-v5」）
归属：GP3-02 修成片，RULING-20261015e §三「字幕带与派生文件」
线上：未推主仓、未传删 R2、未碰 Cloudflare（本趟全在本机准备）。

## 这趟做了什么（大白话）
第 9 趟把 80 条章节视频按新做法重新合成好了（剪掉开头死等、字幕带加粗加高、橙框对齐），放在本机暂存盘 `partner-v5`。但「整片」「分段串播」「流畅版（lite）」这几种给网页播放用的派生文件还没重出。这趟就把它们按新的 80 条章节重新拼出来。

## 建的两个工装（只在 jobs/JOB-GP3/，不碰别处）
1. **gp3-derive-v5.mjs**（cp 自 jobs/JOB-GP1/rec/gp1-finish.mjs 的 film 流程）
   - 成片根改到 `~/guide/dist/partner-v5`（完全不碰 v4）。
   - **关键修正**：切章成子片的 splitter 改读每章 `*.recon.json` 的 `shots[].actualDur`（成片里每镜真实帧数/30），按 `scale = mp4总时长 / Σ actualDur` 比例切——因为 v5 剪了头、补了定格，真实镜时长已变，旧 gp1-finish 按 prod-ch 原始公式重算会切错点（见 D-GP3-10-2）。
   - **分段收尾改「借镜头平衡」**：旧算法把不足 20s 的末内容段整个并回上一段，v5 镜变短后实测产生 51.6s 巨段（超 40s 上限）。改为从上一段尾部逐镜借过来平衡，两段都落回 20~40s（见 D-GP3-10-1）。
   - OP/ED 片段复用 `REC/out/_book` 既有卡片、**不改**（§三.2）；速览（trailer）**不重出**，清单继续指 v4（§三.2，D-GP3-10-4）。
2. **gp3-lite-v5.mjs**（cp 自 jobs/JOB-GP2/gp2-01-lite.mjs）
   - 成片根改到 partner-v5；gate 写 `jobs/JOB-GP3/lite-v5-gate-<lang>.json`。
   - 只做 chapters + fullseg（trailerseg 不做，速览指 v4）。规格同 GP2-01。

## 产出（本机 ~/guide/dist/partner-v5，仓库外、不入 git）
- 章节 HD：80（4 语 × 2 画幅 × 10 章）
- 章节 lite：80
- 整片 master HD：8（4 语 × 2 画幅）
- 整片分段 HD：land 44 / port 43；分段 lite：land 44 / port 43
- 段清单 `segments/<o>/manifest-<lang>.json`：每画幅 4 份
- v5 目录现大小约 614M（含 recon/yavg 等辅助文件；仅暂存，不入 git、不上传原片）

### 整片时长与分段（对比 v4 变短 = 剪头生效）
| 语 | 画幅 | v5 整片 | v4 整片 | 段数 | 越界段 |
|----|------|---------|---------|------|--------|
| en | land | 359.5s | 422.5s | 11 | 仅 ED 尾段 13s |
| en | port | 347.4s | — | 10 | 仅 ED 尾段 13s |
| zh | land | 368.7s | — | 11 | 仅 ED 尾段 12.6s |
| zh | port | 358.3s | — | 11 | 仅 ED 尾段 12.6s |
| ru | land | 378.0s | — | 11 | 仅 ED 尾段 14.7s |
| ru | port | 369.8s | — | 11 | 仅 ED 尾段 14.7s |
| fr | land | 368.5s | — | 11 | 仅 ED 尾段 13.9s |
| fr | port | 357.6s | — | 11 | 仅 ED 尾段 13.9s |

（唯一"越界"是片尾二维码卡 ED 段，GP-1 设计就有意独立成短尾段，非缺陷。）

### lite 转码闸
- en 41 文件 fail=0 / zh 42 fail=0 / fr 42 fail=0 / ru 42 fail=1
- ru 唯一 CHECK：`segments/port/full-ru-seg05-lite.mp4` 223kbps（port ceil 220，超 1.3%，260KB/34.5s）——繁忙帧 1-pass ABR 过冲，属 GP2 已记行为（D-GP2-3-2 / D-GP3-10-3）；对流畅兜底无实质影响，不作阻塞，留停点二乙全量闸复核。

## 没做什么（留下趟）
全闸（联络表 / 禁用词 / 二维码解码 / 无 PII / 字幕带规格 / 剪头定格清单最差 12 对比图 / 跟随框闸）、清单 `m/<lang>` 两份（manifest.json + lite-manifest.json，新 md5 ?v=）、`cp gp2-upload.sh` 改 v5 前缀出上传计划 --dry-run、页面 §四两处（静音 emoji→内联 SVG 两态 + 查默认静音源保证点章有声）+ 版本串 bump（gp2-20261015b）、停点二乙请示单。

## 红线自查
只读 partner-v5 recon/mp4 + REC/out/_book（OP/ED 未改）；新脚本只在 jobs/JOB-GP3/；派生产物落仓库外暂存 partner-v5、未碰 v4；未改端口/首页/guide 既有文件、未动库、未推主仓、未传删 R2、未碰 Cloudflare。

决定：D-GP3-10-1 ~ D-GP3-10-6（见 JOB-GP3-decisions.md）。
