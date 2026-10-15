# JOB-GP3-01 回执 · 修页面（字幕带永远露出 + 自绘控制条）

**趟**：GP-3 第 2 趟 · 2026-10-15 · 按 RULING-20261015c §一-2 页面方案。
**状态**：本机改好、本地提交**未推**，16 配置闸全绿；写请示单停点二甲，等业主本地验收 + 推页面。
**只改一个文件**：`guide/partner/index.html`（+97 −5）。版本串 `gp2-20261015` → **`gp2-20261015a`**。
**没碰**：成片/R2/Cloudflare/首页/学生·学校引导页/五端口/数据库，一律没动。跟随框(B)留 GP3-02。

## 改动三条
1. 顶部播放器 `object-fit:cover → contain`（与学生页一致，杜绝裁切）。
2. 去原生 `controls`（顶部双缓冲 + 章播放器）→ 新增 `attachCtl()` 自绘控制条，放视频框**外下方**：播放/暂停、可拖进度条、时间、静音、全屏；画质 HD/流畅沿用原 `#qbar`（本就在框外、恒可用）。手机 playsinline、原生全屏、空格/左右键、点视频切播放——都做好。去下载/禁右键照旧。
3. 新增「字幕带恒可见」本地闸 `gp3-01-gate.mjs`。

## 闸结果（全绿 16/16）
四语(中英俄法) × 手机405/电脑1440 × 竖/横 × 两播放器(章+顶部速览) × 四态(刚加载/暂停/点击/播完)：
- 结构断言：原生 controls 关 ✅ / 顶部 object-fit=contain ✅ / 字幕带几何 100% 在框内 ✅ / 底部带上方无遮挡层 ✅ / 控制条在视频框外下方 ✅。
- 像素断言（承 D-GP3-1-2，无 tesseract→紫带像素；Playwright 元素截图绕过跨源 canvas taint）：暂停态 + 点击态字幕时刻，底部 14% 紫带占比 ≥0.30 ✅。实测露出 **0.42–0.91**；旧版被原生控件盖只有 **0.063**，阈值 0.30 干净分隔，病根（控件盖字幕）已消。
- 页面结构回归：十章/四要点/邀请码/版本串 gp2-20261015a/无横向溢出，每配置全过。

## 证据（~/mh-jobs/shots/GP3/gate/，无 PII，引导营销片）
- `_gate-results.json`：16 配置逐项 PASS + 每配置 ch/top 的 purple/box/vid 实测。
- 128 张四态截图：`<lang>_<device>_<orient>_<ch3|top>_{loaded,paused,clicked,ended}.png`，供业主肉眼验收。

## 停点二甲：请业主做
① 本地肉眼验收（看 gate 截图，或 `npx wrangler pages dev guide/partner` 真机点）；② 确认好 → 挂代理、原生终端四段式 `git push origin main`；③ 线上验版本串 = build gp2-20261015a + 字幕带露出；④ 装 RULING-*-gp3-01-done 重启循环。详见请示单 `jobs/JOB-GP3/NEEDS_OWNER_DECISION.md`（= 本仓 `JOB-GP3-NEEDS_OWNER_DECISION-20261015-1331.md`）。

## 工装（本机 jobs/JOB-GP3/）
`gp3-01-gate.mjs`（字幕带恒可见闸）；自验报告 `self-test-report-gp3-01.md`。

下趟（等 gp3-01-done 裁后）：GP3-02 成片——字幕带照学生片规格重做 + 跟随框时序返工，走 guide/partner/v5/ 新桶键，另出上传计划 + 停点二乙。
