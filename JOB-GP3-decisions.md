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
