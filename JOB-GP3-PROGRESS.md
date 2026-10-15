最后一趟：2026-10-15 16:40 GP-3：GP3-02 路线丙——建成「甲·合成层对齐」重合成引擎(prod-ch-v5+overlays-v5+verify-timing-v5，全在 jobs/JOB-GP3，只读素材、输出进 /tmp)并端到端验证：en-land-ch3/en-port-ch3/en-land-ch1 共 24 个 follow 镜全过 0.3s 闸(onDelay≤0.24/offGap≤0.04，原始十章全红)。录制帧+配音+followmeasure 全在本机→76 条非 ch3-port 无需重录即可重合成。字幕带改学生规格首版(不透明+加粗+字号大，带高 224 竖=现役，裁决估的 180/9-10% 与实测学生 224 冲突已留记，待停点二乙肉眼)。下趟：改录制工装→重录 ch3 竖版四语→验工装→全 80 重合成+派生+闸+v5上传计划+页面两处→停点二乙请示单。

## 任务顺序
- [x] GP3-00 诊断（停点一）—— 已裁：页面先修 GP3-01、成片后修 GP3-02
- [x] GP3-01 修页面（页面方案）—— 本地提交未推，闸全绿，停点二甲（等业主验收+推）
- [~] GP3-02 修成片 —— 已测量：十章全超标(385/392)，病根偏「只重合成可修」。停点二乙(变体)等 Claude 裁修法路线(甲/乙/丙)；裁后照走(含字幕带§A)
      · online-01 控制条图 16 张已拍
      · followmeasure.json 全量数据已出(主仓库已提交未推)
- [ ] GP3-03 线上真验 + 收官

## 已停点二甲（等业主本地验收 + 推页面）
- 请示单 jobs/JOB-GP3/NEEDS_OWNER_DECISION.md（= JOB-GP3-NEEDS_OWNER_DECISION-20261015-1331.md）
- CC 本机已提交（未推）：guide/partner/index.html（版本串 gp2-20261015a）
- 证据 ~/mh-jobs/shots/GP3/gate/（128 张四态截图 + _gate-results.json）

## 本趟记录（GP3-01）
- 只改 guide/partner/index.html（+97 −5）。顶部播放器 cover→contain；两播放器去原生 controls；attachCtl 自绘控制条放视频框外下方（播放/拖进度/时间/静音/全屏，画质沿用 #qbar）；手机 playsinline、原生全屏、键盘空格/左右、点视频切播。
- 闸 gp3-01-gate.mjs：页面本机截流、媒体只读走线上 v4；四语×手机/电脑×竖横×两播放器×四态，结构+紫带像素+页面回归全绿 16/16。紫带露出 0.42-0.91 vs 旧版被盖 0.063，阈值 0.30。
- 决定 D-GP3-2-1..7（版本串格式 / 画质档不搬入 / 全屏仅临时开 controls / 闸像素法 / band-in-box 需 videoWidth>0 / 媒体走线上 / 一文件点名提交未推）。
