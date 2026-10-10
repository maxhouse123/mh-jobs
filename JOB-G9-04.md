# JOB-G9-04 · 上线真验 + 复测（4格 after）+ 发现平滑度不达标 → 停下来请业主拍板

日期 2026-10-11。上一趟 G9-03 推送成功（PUSHED-234614.txt，git log origin/main..HEAD 为空）。
这一趟等到 Pages 部署完（23:53 两页构建串都翻到 g9），做了线上真验 + 复测。
**结论：秒开达标，但分段接缝的平滑度不达标；修它要改播放器加预下载——这是设计选择，已写 NEEDS_OWNER_DECISION.md 请业主定，暂停清理。**

## 一、部署确认
- 前台轮询线上构建串，第 7 次(23:53)两页同时翻新：学生 `g9-2026-10-10`、学校 `gs9-20261010`。
- origin/main 顶是 9d49104 JOB-G9-03，本地无待推。

## 二、线上真验（全过 ✅）
### 2.1 新对象 60/60 全部 200/206 且字节==本机
- 公桶 student/v2/<四语> 53 个（c10-g9/full-g9/quick-g9/c10-lite-g9/posters/thumbs/各语分段）：HEAD 全 200或206、Content-Length 全==本机字节。pass=53 fail=0。
- 私桶 school/v1/zh 7 个（quick-lite-g9-01…06 + manifest.json）：wrangler r2 object get 回读字节全==本机。pass=7 fail=0。
### 2.2 第10章顶栏章名==页面章名（四语，线上抽帧为证）
线上下载 c10-g9.mp4 四语，抽正片内容帧(14s)看顶栏：
- zh 顶栏「第 10 章 · 录取后的补充信息表 + 在华学生专项」==页面长名 ✅
- en 顶栏「Chapter 10 · Supplementary form & students in China」==页面长名 ✅
- fr 顶栏「Chapitre 10 · Formulaire complémentaire et étudiants en Chine」==页面长名（缩字号那版，放得下）✅
- ru 顶栏「Глава 10 · Доп. анкета и студенты в Китае」==页面长名 ✅
- 图：~/mh-jobs/shots/G9/c10-topbar-online-<lang>-content.png
### 2.3 片尾二维码 线上解码 ✅
线上 full-g9.mp4(zh) 片尾帧 jsQR 解出 `https://www.maxhouses.net/`。其余三语：线上字节==本机、G9-01 已四语解码过，故同。
### 2.4 无 gmail ✅
顶栏帧里邮箱是演示 `omar.demo@example.com`(@example.com，非 gmail)；页面联系邮箱 Service@maxhouses.net。画面无 gmail、无名单外真学生。
### 2.5 分段串播播到最后一段 ✅
学生 zh 实测 seg01→02→03→04→05→06→07(末段)逐段顺序推进；学校 6 段同理。段数与清单一致、四语切换正常。

## 三、复测 4 格 after（同 before 口径：proxy，3次中位，stall=60）
| 格子 | before 出第一帧 | after 出第一帧 | TTFF闸 | after卡顿次数 | 卡顿闸 |
|---|---|---|---|---|---|
| 学生 zh 3G | 1815ms | **838ms** | ≤2500 ✅ | 3 次 | 0 ❌ |
| 学生 zh 慢3G | 6396ms | **2505ms** | ≤4000 ✅ | 4 次 | ≤1 ❌ |
| 学校 zh 3G | 1799ms | **656ms** | ≤2500 ✅ | 2 次 | 0 ❌ |
| 学校 zh 慢3G | 13509ms | **5380ms** | ≤4000 ❌ | 9 次 | ≤1 ❌ |

逐接缝实测(ended→下一段playing):
- 学生 zh 3G 六个接缝 = 650/667/654/825/818/660 ms（闸≤600 ❌超）
- 学生 zh 慢3G = 1765/1767/1778/2428/2431/1780 ms（❌超）

数据存 jobs/JOB-G9/speed-after.json。

## 四、为什么卡顿（根因）
播放器 `preload="none"`，且只在当前段 `ended` 事件里才去取下一段 → 没有"播这段时后台预下一段"。
弱网上每个接缝都要现下现播，于是接缝处顿 0.65~2.43 秒、超 0.6s 闸，60 秒内撞上 2~9 个接缝=卡顿若干次。
（G9-03 本地走查测到接缝仅 38~41ms 是因为本地文件秒开，掩盖了真网下载延迟。）

## 五、为什么停下来（不自己改、不清理）
- 修法 = 给播放器加"预下载下一段"（标准做法，能保住秒开又消接缝卡顿），但这要**改 guide 页面播放器并再推一次**，属新的设计改动、且页面已上线——按铁律(改码先请示、视觉/行为改动先业主验)，这类决定该你定。
- 已写 `jobs/JOB-G9/NEEDS_OWNER_DECISION.md`：四个选项(①加预下载【推荐】/②照现状收/③退回整条/④切大段)+学校首段偏大一并说明，大白话。
- **清理暂缓**：G9-04 本应删旧 g8 对象(quick-lite-g8 等)。若业主选③退回要用回 quick-lite-g8，故旧对象先不删，等拍板。

## 六、还差什么 / 下一步
- 等业主在 NEEDS_OWNER_DECISION.md 选项里回一句。
- 选①：下一趟给播放器加段预下载(两线)→出新版页面→commit→写 NEED_PUSH(cycle=1)→推→再复测 4 格 + 逐接缝，达标后再做清理 + 收官 SUMMARY-G9。
- 选②：直接做清理 + 收官（SUMMARY 首行 PUSH_OK=no 平滑度未达标，如实写）。
- 新脚本入库(主仓库 commit JOB-G9-04:)：g9-04-live-diag.mjs / g9-04-measure-repro.mjs / g9-04-crossgap.mjs / speed-after.json / NEEDS_OWNER_DECISION.md。本趟不推主仓库；回执+图推 ~/mh-jobs。
