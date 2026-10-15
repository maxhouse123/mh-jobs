# JOB-GP3 · 决定账（编号 D-GP3-<趟>-<序>）

## 第 1 趟（2026-10-15，GP3-00 诊断）
- **D-GP3-1-1** · 成片本机缺失 → 以线上 media.maxhouses.net v4 真对象为诊断源。`guide/dist/partner/` 本机为空（GP-2 在另一台机做），A1 文件层改从线上清单指向的真对象下载抽帧（不入 git，/tmp/gp3）。
- **D-GP3-1-2** · 无 tesseract → 字幕带存在性判定改「ffmpeg 抽帧 + CC 肉眼读字幕 + 像素级紫带检测」，不强依赖 OCR。四语整句对账用 captions-v1.json，肉眼核读即可。
- **D-GP3-1-3** · A2 真浏览器只打线上只读（Playwright chromium，§0.4 允许）；node_modules 软链 GP-2 的（不改 GP-2 文件）；新工装落 jobs/JOB-GP3/。
- **D-GP3-1-4** · 【A 病根定性】字幕看不到 = **原生控制条盖贴底字幕带**（主因，两页同病）+ 中介页顶部播放器 object-fit:cover 隐患（次因）；**非文件问题**（所有文件四语横竖 HD/lite/seg/trailer 字幕带俱在，贴底 0.00%）。学生页同病、无法复现「中介页独有」，列请业主确认设备/姿势。
- **D-GP3-1-5** · 【B 病根定性】跟随框**位置准**（稳态 ≤2px，合成映射 port y+96 / land scale+72 精确，80 timeline 全 resolved），**真病在时序**：交互触发型镜高亮比旁白晚 0.5–2.0s 亮起 / 早 ~1s 熄。根因 (a)页面未settle + (c)高亮onset未对齐旁白；非 (b)/(d)。
- **D-GP3-1-6** · 橙环检测的自然橙 UI 混淆（dim 未起时误抓橙按钮）→ 时序判定改用「暗罩 darkFrac」法；大元素镜暗罩占比低、改用稳态位置 + 逐帧 off 曲线综合判。B_transients.jpg 系混淆帧（已标注，B_evidence.jpg 为准）。
- **D-GP3-1-7** · 【C】OP/ED=整屏卡无底部带、不受影响；trailer 底部关键点字幕带按设计在；QR 承 GP-1 item-8 已验。无新问题。
- **D-GP3-1-8** · 诊断完写 NEEDS_OWNER_DECISION 停点一，三问待业主（A/B 方案口径 + 字幕现象设备确认）。未改代码、未碰线上。

## 第 2 趟（2026-10-15，GP3-01 修页面 · 按 RULING-20261015c §一-2 页面方案）
- **D-GP3-2-1** · 版本串格式：按任务书 GP3-01「gp2-2026MMDD 格式 + 字母」，`gp2-20261015` → `gp2-20261015a`（保留 GP 线谱系，加字母 a）。guide/partner 是独立引导页、无 index 重定向，版本串只此 `D.BUILD` 一处，无四件套。
- **D-GP3-2-2** · 画质档按钮不搬进控制条：现有 `#qbar`（HD/流畅）本就在视频框外、全局共享两播放器、永不盖字幕，重复搬入会割裂全局切档逻辑。RULING「有画质档按钮就一并放进去」的本意=切档可达不丢，`#qbar` 恒在恒可用即满足。记此决定备查。
- **D-GP3-2-3** · 全屏实现：iOS 走 `webkitEnterFullscreen`（原生播放器自带控件）；桌面走 `requestFullscreen` 并**仅全屏期间**临时 `controls=true`、`fullscreenchange` 退出即关 → 落实 RULING「全屏用原生全屏、接受原生控件」，又不破坏非全屏态「字幕带恒露」。
- **D-GP3-2-4** · 闸的字幕可见判定：无 tesseract + 视频跨源 canvas taint → 用 Playwright 元素截图（浏览器级，绕过 canvas taint）回灌同源 canvas 读紫带像素（承 D-GP3-1-2）。阈值 0.30（校准：露出 0.42-0.91 / 旧版被控件盖 0.063）。结构断言（controls off / contain / band-in-box / 无遮挡 / bar 在框外下方）为主，像素为辅，二者皆硬断言。
- **D-GP3-2-5** · 闸 band-in-box 需 videoWidth>0：章播放器 preload=none 未 seek 时 videoWidth=0，几何量不出 → 闸在量「刚加载态」前先 preload=auto+load+seek 0.1s 促元数据，再量。非页面问题，是量测时序。
- **D-GP3-2-6** · 闸的媒体只读走线上 v4（本机 dist 空，承 D-GP3-1-1），页面与清单截到本机改版文件；不跑 gp2-03-gate 全量（其把媒体映射本机 dist，本机为空无法跑）。结构 + 像素 + 页面回归三类断言 16 配置全绿。
- **D-GP3-2-7** · 只改 guide/partner/index.html 一文件（+97 −5）；点名提交后停在「已提交未推送」，写请示单停点二甲等业主卡本地肉眼验收 + 推页面（铁律15 闸二）。未推主仓、未碰线上、未传删 R2、未改 CF。
