最后一趟：2026-10-15 17:20 GP-3：GP3-02 路线丙——录制工装修订(rec-v2)建成并验证。改工装三处(§二.1 可见文字 Range 并集修半框 / §二.2 稳定等待≥6帧 + 窗口从橙环亮起算 + hold 到配音尾+0.3)。用 en 一语重录 ch3 竖版端到端：9 个 follow 镜原生 onDelay 0~0.10、offGap 0.01~0.20，9/9 全过 0.3s 闸(原始 3-4/5/6 onDelay≈2.4s/3-7 offGap 1.96s)。单元测试修半框 PASS(溢出 pill 并集 133>被裁盒 92)。肉眼抽帧：3-8 橙环框全 MH-M227EJ 无半框、3-1 窗首环已框。DB 只 scoped 复位(录前清→3-8 真提交→mark test→录后清回 0 + 还原 pt-01 草稿)。下趟：重录 ch3 竖版 zh/ru/fr → prod-ch-v5 加重录帧来源切换 → 全 80 重合成+派生+闸+v5上传计划+页面两处 → 停点二乙请示单。

## 任务顺序
- [x] GP3-00 诊断（停点一）—— 已裁：页面先修 GP3-01、成片后修 GP3-02
- [x] GP3-01 修页面（页面方案）—— 本地提交未推，闸全绿，停点二甲（等业主验收+推）
- [~] GP3-02 修成片 —— 裁走路线丙(RULING-e)。进度：
      · 甲·合成层对齐引擎 prod-ch-v5 建成+三章验证(第4趟)
      · 录制工装 rec-v2 建成(§二三处改)+ ch3 竖版 en 重录验证 9/9 过 0.3s(第5趟)
      · 待办：重录 ch3 竖版 zh/ru/fr → 全 80 重合成 → 派生 → 闸 → v5 上传计划 → 页面两处 → 停点二乙
      · online-01 控制条图 16 张已拍 / followmeasure.json 全量已出
- [ ] GP3-03 线上真验 + 收官

## 已停点二甲（等业主本地验收 + 推页面）
- 请示单 jobs/JOB-GP3/NEEDS_OWNER_DECISION.md（= JOB-GP3-NEEDS_OWNER_DECISION-20261015-1331.md）
- CC 本机已提交（未推）：guide/partner/index.html（版本串 gp2-20261015a）
- 证据 ~/mh-jobs/shots/GP3/gate/（128 张四态截图 + _gate-results.json）

## 本趟记录（GP3-01）
- 只改 guide/partner/index.html（+97 −5）。顶部播放器 cover→contain；两播放器去原生 controls；attachCtl 自绘控制条放视频框外下方（播放/拖进度/时间/静音/全屏，画质沿用 #qbar）；手机 playsinline、原生全屏、键盘空格/左右、点视频切播。
- 闸 gp3-01-gate.mjs：页面本机截流、媒体只读走线上 v4；四语×手机/电脑×竖横×两播放器×四态，结构+紫带像素+页面回归全绿 16/16。紫带露出 0.42-0.91 vs 旧版被盖 0.063，阈值 0.30。
- 决定 D-GP3-2-1..7（版本串格式 / 画质档不搬入 / 全屏仅临时开 controls / 闸像素法 / band-in-box 需 videoWidth>0 / 媒体走线上 / 一文件点名提交未推）。
