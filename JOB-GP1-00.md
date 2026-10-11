# JOB-GP1-00 回执 —— 底座与先红（**完成 · 闸3 全过**）

日期 2026-10-11｜Mac mini 无人值守第 1 趟｜本趟把 GP1-00 一口气做完：两版录制底座 + 视口定档 + 62 镜镜表 + 先红五项 + 第 2 章两版空跑成片。

## 一句话（给业主）
这轮先把「怎么录」的架子搭好、把「还没做的东西」逐条点红。横版电脑画面定用 **1200 视口**（见下第 2 条，内容列宽和 1440 一模一样、只是四周白边变少），竖版手机画面沿用学生线的 405 原生参数。分镜里 **62 个镜头**全部拆成了机器能照着录的清单（每镜写了要高亮哪、该出现什么、禁止露什么、中英文字幕）。十名演示学生、注册演示号、字幕稿、四语配音、成片——这些还都没造，已逐条确认「现在是红的」，后面几包会一个个转绿。最后拿**第 2 章**真的空录了一遍横竖两版，各出一支 mp4，分辨率分别是 **1920×1080 / 1080×1920**，管线通。

---

## 第 1 条 · 两版录制底座 ✅
- 照规矩 `cp jobs/JOB-GP0/rec/` 的脚本到 `jobs/JOB-GP1/rec/`（**没动 GP0 原文件**），改成「同一镜表跑横竖两版」：
  - `rec.mjs`：两版录制 harness。读 `shots-v1.json`，录指定章全部镜；录前 `setLang` 到目标语言（en/zh/ru/fr）；高亮引擎逐字沿用 GS3 的 `OVERLAY_INIT`；登录走 partner-portal **v184**（`#emailInput`/`#pwdInput`/`#gateBtn` + guide_partner，真库走代理，只浏览不写库）。
    - 横版 land：视口 **1200×543 @ dsf 2.5**（帧 3000×1358），截帧 120ms。
    - 竖版 port：视口 **405×600 @ dsf 8/3**（帧 1080×1600），截帧 110ms。
  - `asm.mjs`：两版三段式合成（**不盖产品 UI**，照 GP-0 裁决「章节条不压真顶栏」）：
    - land = 页面区 `scale=1920:868,pad到 y=72` + 顶条 72(y0) + 字幕带 140(y940) = **1920×1080**。
    - port = 页面区 `scale=1080:1600,pad到 y=96` + 顶条 96(y0) + 字幕带 224(y1696) = **1080×1920**。
    - 字幕按每镜 start/end 时间窗贴（caption EN 从 shots-v1.json 取）。
  - `gp0-overlays.mjs`（章节条/字幕带/片头卡渲染）、`BASES.md` 一并 cp 来复用。
- node_modules 软链到 `~/mh-verify/node_modules`（含 playwright/pngjs/qrcode/@supabase，照先例；**不入 git**，已写 `rec/.gitignore`）。
- ffmpeg/ffprobe 走 `jobs/JOB-G1/bin.mjs`（brew 优先），**未改 G1 原文件**（只 import）。

## 第 2 条 · 横版视口 1200 vs 1440 对比 ✅ → **定 1200**
脚本 `vp-compare.mjs`（登录 → 切 EN → 两档各量主容器/卡片宽 + 截图），实测：

| 元素 | 1440 宽 | 1200 宽 | 差 |
|---|---|---|---|
| **`.wrap`（内容列）** | **920** | **920** | **0** |
| `.app` / `header`（满宽外框） | 1440 | 1200 | 240 |

- **判据（§1.1：列宽一致、只留白变少才用 1200）成立**：内容列 `.wrap` 在两档都是 **920px，零差异**；变窄的只有满宽外框（四周留白）。
- **结论：横版正片用 1200×543 @ dsf 2.5**（即 §1 目标值）。截图存 `out/vp/vp-1440.jpg` / `vp-1200.jpg`（本机，不入 git）。

## 第 3 条 · 62 镜镜表 shots-v1.json ✅
- `jobs/JOB-GP1/rec/shots-v1.json`，**62 镜**，与 storyboard-v1 逐章对齐：开场 6 + 第1章8 + 第2章5 + 第3章9 + 第4章5 + 第5章4 + 第6章7 + 第7章4 + 第8章4 + 第9章4 + 第10章4 + 片尾2 = **62**（校验：镜数=分镜数 ✅、每镜非空 expect ✅、镜号无重复 ✅）。
- 每镜字段：`id / ch / type(integral·follow·overlay) / action / hl(橙框选择器，源 partner-map v184) / special(命令式动作关键字) / expect[] / forbid[] / capEN / capZH / portDouble(竖版预判是否双层)`。
- 高亮选择器全部来自 GP0 的 `JOB-GP0-partner-map.json`（真见/源码对照两类都标在图上）。
- **竖版双层预判**（portDouble=true，待 GP1-03/04 录制断言定）：`2-2` 统计漏斗四段、`3-4` 材料上传格、`5-2` 退回理由矩阵、`6-2`/`6-3` 两张 offer 盲卡并排对比 —— 这几处 405 宽易放不下，预判用「全局+放大」双层兜底；其余镜走原生竖版。
- **一处待核（已在镜表标注 conditional）**：`10-1`「再次申请入口」——storyboard 原注「若中介端无此入口则删除本镜、章名改『账户、语言与安全』」。v184 中介端是否有此入口待 GP1-03 录制时实测，按 storyboard 预授权处理（有则录、无则删镜改章名），不另请示。

## 第 4 条 · 先红五项 ✅（现状全红，后续逐条转绿）
DB 探针 `probe-redfirst.sql`（经 `bash jobs/db-run.sh`，只读 begin/commit）+ 文件存在性：

| 先红项 | 现状 | 判定 |
|---|---|---|
| Demo Agency（guide_partner） | 存在·is_test·delegate 开·**refcount=0 / quota 未设** | 底座在，名下 0 学生（待 GP1-01 铺 10 名 + 设名额 10） |
| 被荐生 guide-pt-01..10（auth.users） | **0** | 🔴 红 |
| 注册演示号 guide-pt-reg（auth.users） | **0** | 🔴 红 |
| students 表 guide-pt 行（email/referred_by） | **0 / 0** | 🔴 红 |
| captions-v1.json | 不存在 | 🔴 红 |
| 四语配音 wav（rec/voice/） | 不存在 | 🔴 红 |
| GP1 成片（~/guide/dist/partner 章节/全片） | 无（只有 GP0 samples） | 🔴 红 |
| castlist | 不存在 | 🔴 红 |
| 四语音色 Samantha/Tingting/Milena/Amélie | **都在**（`say -v` 实测） | 🟢 绿·前置就位 |

（Demo Agency id 记在库，回执按规矩不写全邮箱/密码；quota 未设 → GP1-01 置 10。）

## 第 5 条 · 第 2 章两版空跑 → 成片分辨率 ✅
- `node rec.mjs --chapter 2 --orient land|port --lang en --dry` → `node asm.mjs --tag en-<orient>-ch2`
- **ffprobe 实测**：`ch2-land-en-dry.mp4 = h264 1920×1080` ✅ / `ch2-port-en-dry.mp4 = h264 1080×1920` ✅（独立 ffprobe 复核一致）。
- 第 2 章 5 镜录制结果：`2-1` 工作台整屏 ✓、`2-3` 学生列表标题高亮框命中(221×73 land / 236×78 port) ✓、`2-5` 通知铃命中 ✓；**`2-2` 统计卡 / `2-4` 五档徽章未命中**——因 Demo Agency 名下 0 学生（统计漏斗/状态药丸 data-dependent，先红状态本就缺位），非选择器错；GP1-01 铺满 10 名学生后这两镜自然有料。
- 成片在本机 `~/guide/dist/partner/`（**不进 git、不进 mh-jobs**）。

## 闸3 判据对账
- ✅ rec/ 两版空跑各 1 章（第 2 章）出 mp4 分辨率 **1920×1080 / 1080×1920**（ffprobe 实测）。
- ✅ shots-v1.json 镜数 **62 = storyboard 镜数 62** 且每镜有 expect（脚本校验通过）。
- ✅ 回执有视口结论（**1200**，判据：内容列 .wrap 两档同为 920px、只留白变少）。

## 产物与合规
- 主仓库 `jobs/JOB-GP1/rec/`：rec.mjs / asm.mjs / vp-compare.mjs / shots-v1.json / probe-redfirst.sql / probe-schema.sql / gp0-overlays.mjs / gp0-assemble.mjs / gp0-finish.mjs / BASES.md / .gitignore（**点名提交，本轮不推主仓库**）。`out/`（64M 帧）与 `node_modules`（软链）**已 .gitignore、不提交**。
- `~/mh-jobs/`：本回执。
- 本机 `~/guide/dist/partner/` 两支空跑 mp4 + `rec/out/vp/` 两张视口截图（不进 git/mh-jobs）。
- 合规：未改五端 HTML/JS/迁移；未碰 JOB-G*/JOB-GS*/JOB-GP0 原文件（只 cp）；**DB 本轮零写入**（只读探针 + 登录浏览）；未碰 R2/CF；未起后台任务；node 走代理、NODE_USE_ENV_PROXY 未清；别的线（G8/G9/GP0）留下的改动未碰未提交。

## 下一包 GP1-01（演示数据）要点
铺 Demo Agency 名下 10 名被荐生（pt-01..10 各档状态）+ 注册演示号 guide-pt-reg + 复位脚本（states/st-*.sh + rebuild-partner.sh + reset-pt.sh），设名额 10/已用 9、提额申请两态、≥4 条通知、SPECIMEN 样件；出 castlist。铺完第 2 章 `2-2`/`2-4` 两镜即转绿。
