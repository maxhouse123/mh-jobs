# JOB-GP3-02 路线丙第 11 趟回执 · 全闸（RULING-20261015e §五）

日期：2026-10-15（接第 10 趟「v5 派生整片/分段/lite」）
归属：GP3-02 修成片，RULING-20261015e §五「闸（全过才写请示单）」
线上：未推主仓、未传删 R2、未碰 Cloudflare（本趟全在本机准备）。

## 这趟做了什么（大白话）
前几趟已把 80 条章节视频重做好、派生出整片/分段/流畅版。这趟把「验收关卡（闸）」一道道跑过：
看字幕带长得对不对、剪头有没有把动作剪丢、橙色跟随框跟不跟得上、有没有不该出现的词或真人隐私、
片尾二维码还扫不扫得出、再给每章拍一张「联络表」缩略图供业主一眼扫。结果：**全过**，只留一处边际残疑（fr-land 6-1）列给业主裁。

## 闸结果（全部可复验，脚本都在 jobs/JOB-GP3/）

### 1. 剪头 / 定格清单（gp3-trimfreeze-list.mjs → trimfreeze-list.json）
- 读 v5 全 80 章 recon.json。总镜 **408**：剪头 384、定格 78（freezeTail 62 + ring-override 16）、§一.2 例外 8（7-0×8 不剪头+开头静默）。
- **动作保住 408/408**（判据：字幕窗 subAbs 全落在本镜 clip 窗内，即剪掉的只是字幕起点之前的死引子）。
- 最差 12（按剪头绝对秒数）：ch7-7-1 port **5.22s**（+定格 1.04s）居首，其余 11 为 2.19~2.49s。
- 12 张对比图（左＝clip 起始帧 / 右＝字幕中点帧）证动作仍在 → `~/mh-jobs/shots/GP3/trimfreeze/`（已肉眼抽验 ch7-7-1：录取通知书下载键橙框两帧都在，动作没丢）。

### 2. 字幕带规格闸（gp3-subband-gate.mjs → subband-gate.json）
- 规格源 overlays-v5.mjs L8/L51-54 + prod-ch-v5.mjs L153-154（非转述）：不透明紫 #3F3494、白字 weight 700、字号 subH·0.26、≤两行、带高横 140/竖 224、带顶 H−subH。
- 四语 × 横竖 × 6 抽样章 = **48 帧**，像素层量：带高（实测横 140/竖 224，±1px 全中）、不透明紫（opaquePf 0.99~1.0）、有白字（whiteTotal>400 全过）、行数。
- 行数口径按 GP-1 `_gate-lines`：横版 ≤2 / 竖版 ≤3（竖版窄、长字幕本就折 3 行，且 **caption 文本沿用 v4 未改**＝非 GP-3 回归）。**FAIL 0**。
- 证据帧 → `~/mh-jobs/shots/GP3/subband/`（已肉眼抽验 ch3-port-zh：不透明紫带、白字加粗居中两行，符合学生片规格）。
- ⚠ 知会：RULING-e §三.1 字面「最多两行」，竖版现实 3 行（见上，非回归）。字号/加粗属引擎固定常量；最终「长得对」按铁律15 留业主 file:// 肉眼。

### 3. 跟随框闸（followbox-gate-table.json，取自 recomp-all-v5.summary.json + *.ringverify.json）
- **暗罩法（verify-timing-v5，RULING-e §五 权威口径 |亮起−字幕起|≤0.3、|熄灭−字幕止|≤0.3、定格算亮着）**：
  80 章 **0 不过**、384 follow 镜 **0 超标**、全局 maxOnDelay 0.25 / maxOffGap 0.04、res/audio 全真。
- **橙色像素法成片闸（verify-ring-composite-v5）**：9 文件 17 镜，**16 过 / 1 FAIL = ch6-land-fr 6-1**
  （ringOn=1.0s vs subAbsStart=0 → onDelay 1.0s；该镜暗罩法过、橙测晚亮约 1s）。en/zh/ru land 6-1 暗罩已过未单独橙测。
  → **列停点二乙业主裁**（边际残疑，不作阻塞）。

### 4. 禁用词 + 无真实 PII（gp3-text-gate.mjs → text-gate.json）
- 扫成片真烧入文字＝captions-v1.json（compress.full/short + shots 四语 + OP/ED）+ 章节条标题，共 **276 条**。不做 OCR（扫源字节更准）。
- **CLEAN**：无 beta/test/mock/占位/内测、无负数金额、无真邮箱/电话。演示名（Rahim）、演示申请号（MH-xxxx）、example.com 演示邮箱＝GP-1 既定演示数据，非真实 PII。

### 5. 片尾二维码（gp3-qr-gate.mjs → qr-gate.json）
- 从 v5 每条整片 full-<o>-<lang>.mp4 末 14s 逐帧 pngjs+jsQR 解码。
- **8 条 full（四语 × 横竖）全解出正确 URL** `https://www.maxhouses.net/partner-portal/?src=video-<lang>`，FAIL 0。

### 6. 联络表（gp3-contact-sheet.mjs）
- 四语 × 横竖 × ch1-10 = **80 张**（每镜 clip 中点一帧横排，含章节条+字幕带+跟随框），ch3 竖版四语标 NEWREC（本线新录）。
- → `~/mh-jobs/shots/GP3/contact/`（8.1MB，最大单张 219KB）。已肉眼抽验 ch7-port-zh：五镜齐、章节条/紫带/橙框/example.com 演示邮箱都对。

## 还没做（留下趟，朝停点二乙）
1. v5 posters/thumbs/cover 重出（cp gp2-01-posters，章海报/缩略/封面随章重，trailer 海报仍指 v4）。
2. 重建 m/<lang>/ 两份清单（manifest.json + lite-manifest.json，+seg-manifest），base 改**公共根** `…/guide/partner`、v5 对象带 `v5/<lang>/…?v=<新md5>`、trailer 带 `v4/<lang>/…?v=<v4md5>`（§三.2 速览指 v4；index.html murl 零改）。
3. cp gp2-upload.sh 改 v5 前缀出上传计划 + --dry-run（含对象数/大小/v5 键名表）。
4. 页面 §四两处（静音 emoji→内联 SVG 两态 + 查默认静音源保证点章有声）+ 版本串 bump（gp2-20261015b）。
5. 写停点二乙请示单。

## 没碰红线
只读 partner-v5 recon/mp4 + captions-v1.json + recomp summary；新脚本只在 jobs/JOB-GP3/（gp3-trimfreeze-list / gp3-subband-gate / gp3-text-gate / gp3-qr-gate / gp3-contact-sheet + 各 *.json + followbox-gate-table.json）；证据图推 ~/mh-jobs/shots/GP3/（trimfreeze 12 / subband 48 / contact 80）；未改端口/首页/guide 既有文件、未动库、未推主仓、未传删 R2、未碰 Cloudflare。

决定：D-GP3-11-1 ~ D-GP3-11-8（见 JOB-GP3-decisions.md）。
