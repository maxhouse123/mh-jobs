最后一趟：2026-10-15 13:35 GP-3：做完 GP3-01 修页面（顶部 cover→contain、去原生控件改自绘控制条让字幕带恒露、新增字幕带恒可见闸 16 配置全绿），只改 guide/partner/index.html 本地提交未推；写请示单停点二甲等业主本地验收+推页面。下趟等 gp3-01-done 裁后做 GP3-02 成片。

## 任务顺序
- [x] GP3-00 诊断（停点一）—— 已裁：页面先修 GP3-01、成片后修 GP3-02
- [x] GP3-01 修页面（页面方案）—— 本地提交未推，闸全绿，停点二甲（等业主验收+推）
- [ ] GP3-02 修成片（字幕带照学生片规格重做 + 跟随框时序返工，走 v5 新桶键，停点二乙）
- [ ] GP3-03 线上真验 + 收官

## 已停点二甲（等业主本地验收 + 推页面）
- 请示单 jobs/JOB-GP3/NEEDS_OWNER_DECISION.md（= JOB-GP3-NEEDS_OWNER_DECISION-20261015-1331.md）
- CC 本机已提交（未推）：guide/partner/index.html（版本串 gp2-20261015a）
- 证据 ~/mh-jobs/shots/GP3/gate/（128 张四态截图 + _gate-results.json）

## 本趟记录（GP3-01）
- 只改 guide/partner/index.html（+97 −5）。顶部播放器 cover→contain；两播放器去原生 controls；attachCtl 自绘控制条放视频框外下方（播放/拖进度/时间/静音/全屏，画质沿用 #qbar）；手机 playsinline、原生全屏、键盘空格/左右、点视频切播。
- 闸 gp3-01-gate.mjs：页面本机截流、媒体只读走线上 v4；四语×手机/电脑×竖横×两播放器×四态，结构+紫带像素+页面回归全绿 16/16。紫带露出 0.42-0.91 vs 旧版被盖 0.063，阈值 0.30。
- 决定 D-GP3-2-1..7（版本串格式 / 画质档不搬入 / 全屏仅临时开 controls / 闸像素法 / band-in-box 需 videoWidth>0 / 媒体走线上 / 一文件点名提交未推）。
