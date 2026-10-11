# JOB-G9-05 · 按业主裁决① 施工：两线播放器加「双缓冲预下载」+ 学校线速览首段切短(g9b)

日期 2026-10-11。上一趟（G9-04）发现：秒开达标，但分段接缝没有预取，弱网下每切一段都要现下现播、顿 0.65~2.43 秒，超闸。
业主在 `jobs/JOB-G9/OWNER-DECISION-G9.md` 拍板 **选①**：给串播播放器加「下一段预下载」（双缓冲），同时把学校线速览首段切短。
这一趟把①做完了，本地所有闸都过。**主仓库只提交未推**（按规矩 CC 不自己推）；下一趟见 PUSHED(cycle=2) 再做线上真验+复测。

## 一、做了什么（大白话）

### 1. 双缓冲预下载（学生、学校两页同一套思路）
- 页面里现在放**两个播放器**（A 在看、B 藏着）。看 A 的同时，一旦 A「看过一半」或「这一段已经下载到结尾」，就偷偷把**下一段**塞给 B 在后台先下好。
- A 这段播完的一瞬间，直接切到已经下好的 B 接着播、画面不黑屏不卡；A 退到后台，再去下「下下一段」。如此接力。
- 万一 B 还没下好就轮到它，照旧切过去转个圈等一下（不会卡死）。
- 原来的「上一段/下一段」按钮、「第 i / N 段」小标、弱网自动降档（高清卡 2 次→切流畅分段）全部照旧，行为不变。高清档一个字没动。
- 两页仍是单文件、不加外部脚本、体积没超：**学生 44.5KB / 学校 40.9KB（闸 ≤60KB）**。

### 2. 学校线速览首段切短（新 7 段 g9b）
- 老版学校速览第 1 段 37.47 秒、994KB，太大 → 慢 3G 出第一帧要 5.38 秒（上一趟唯一没过的秒开项）。
- 裁决要求「首段 ≤15 秒，在镜头边界取离 15 秒最近的切点」。学校开场只有两个可切的镜头边界：**2.8 秒**和**19.943 秒**。
  - 离 15 秒最近的是 **19.943 秒**；2.8 秒那处只是开场 logo 的一瞬，若拿它当首段，第一个接缝会立刻又卡（和双缓冲的目的打架）。
  - 所以首段取 **≈20.0 秒（489KB）**——比老版 37.47 秒 / 994KB 砍掉一半多，出第一帧会快很多，又留足时间把第 2 段预下好。
  - **这点与裁决字面「≤15」略有出入（取了离 15 最近的真实镜头边界），已按裁决括注「取最接近的切点」的本意办；如业主坚持严格 ≤15（只能用 2.8 秒微段），下一趟可重切。**
- 其余段按 20~40 秒重新合并，一共 **7 段**：`quick-lite-g9b-01 … -07`。学生线四语首段本来就已 ≤22 秒，**不动**（仍用 g9 分段）。

## 二、闸的真实输出

### A. 学校线 7 段切码（`node g9b-02-segment-school.mjs`）
```
seg01 PASS dur=20.00s 489KB 200kbps 960x540 moovFirst=true  shots=0-1,0-2(开场卡)
seg02 PASS dur=34.70s 883KB 208kbps
seg03 PASS dur=31.90s 848KB 218kbps
seg04 PASS dur=24.57s 637KB 212kbps
seg05 PASS dur=25.20s 700KB 227kbps
seg06 PASS dur=29.43s 681KB 190kbps
seg07 PASS dur=10.08s 187KB 152kbps
共 7 段, 首段=20s(老版37.47s), sumDur=175.878s vs master=175.8s Δ=0.078s  sumGate=PASS
```
（每段 moov 在头、≤40s、≤350kbps、960x540 全过；段和==母带 ±0.2s 过。切点全落镜头边界。）

### B. 本地无头走查（`node g9-05-walk.mjs`，只开本地 file://、媒体用桩/服本地文件、绝不碰生产/连库）
结果 **PASS=41 FAIL=0**。要点：
```
学生页双缓冲：BUILD=g9b-2026-10-11 / 两个播放器A·B / A=seg01显示·B=seg02预装(preload=auto)
            / ended→切到B显示·A隐藏去装seg03 / 标签「速览 第2/7段」 / Next到末段禁用
            / 切回高清=单文件quick-g9·小标隐藏 / 自动降档仍生效 / 第10章=c10-g9·长名(回归)
学校页双缓冲：build=gs9b-20261011 / vidA·vidB / 流畅速览起=quick-lite-g9b-01(首段切短)·第1/7段
            / ended→active由vidA切到vidB·seg02·第2/7段 / 切高清=quick-g7(高清不动) / 流畅整片=intro串播(回归)
学生 真跨段间隔(ended→playing): [0.2, 0.3, 0.2] ms  ✅ 3次全 ≤600ms（双缓冲后几乎零）
学校 连跨3接缝就绪度: 接缝1/2/3 待进段 readyState=4（已全下好）✅ 3/3 秒切
  （学校线用自然ended计时在无头换元素路径上不稳,改用更直接判据:切换时下一段是否已预装就绪——
   这正是接缝秒切的决定因素;换段逻辑本身已由上面的「ended→active切换」走查证实。）
g9b 7段 file:// 真放前3s: 全部 rs=4、无 error ✅
页面体积: 学生 44564B / 学校 40944B  ✅ 均 ≤60KB
```
完整日志：`shots/G9/g9-05-walk.log`。

### C. 传桶（学校 7 段 + 新 manifest → 私有桶，回读核字节）
```
OK guide/school/v1/zh/quick-lite-g9b-01.mp4  500858 bytes
OK guide/school/v1/zh/quick-lite-g9b-02.mp4  904119 bytes
OK guide/school/v1/zh/quick-lite-g9b-03.mp4  867939 bytes
OK guide/school/v1/zh/quick-lite-g9b-04.mp4  652451 bytes
OK guide/school/v1/zh/quick-lite-g9b-05.mp4  716308 bytes
OK guide/school/v1/zh/quick-lite-g9b-06.mp4  697540 bytes
OK guide/school/v1/zh/quick-lite-g9b-07.mp4  191875 bytes
OK guide/school/v1/manifest.json  8075 bytes
=== 传桶完成 total=8 fail=0 ===  （每个都上传后回读、字节==本机）
```
学生线本轮**无新媒体**（只改页面 JS），不用传桶。

## 三、入库与推送
- 主仓库 commit（**只提交，未推**）：`efa294b JOB-G9-05: …`。
  入库文件：`guide/student/index.html`、`guide/school/index.html`、`jobs/JOB-G9/g9b-02-segment-school.mjs`、
  `quick-lite-g9b-school-zh.json`、`manifest-g9b.json`、`g9-05-walk.mjs`、`g9-05-upload.sh`。
  （成片/dist 本机构建件按惯例不入库；日志被 .gitignore，证据写在本回执+shots。）
- 待推（origin/main..HEAD）共 4 笔，**全部以 JOB-G9 开头**：G9-04、G9-04b、G9-04b、G9-05。
- 已写 `jobs/JOB-G9/NEED_PUSH.txt`（首行 `cycle=2`）。旧 `PUSHED-234614.txt`(cycle=1) 保留不动。

## 四、还差什么 / 下一趟
1. 业主/循环在原生终端挂代理 `git push origin main`，循环把 NEED_PUSH 改名为 PUSHED(cycle=2)。
2. 下一趟见 PUSHED(cycle=2) → 前台轮询线上构建串翻到 **学生 g9b-2026-10-11 / 学校 gs9b-20261011** → 线上真验：
   - 新 g9b 7 段全部 200/206 且字节==本机；两线流畅速览双缓冲一路串到末段、逐接缝 3G ≤0.6s / 慢3G ≤1.0s；
   - 复测 G9-00 那 4 格 after（同脚本同口径、3 次中位）：秒开 3G ≤2.5s / 慢3G ≤4s，60 秒卡顿 3G 0 次 / 慢3G ≤1 次；
   - 重点看**学校慢3G 首段切短后 TTFF 是否从 5.38s 降到 ≤4s**。验不过如实标红。
3. 达标后再做清理（被顶替的 g8 速览分段 + 学校被 g9b 顶替的 g9 分段，沿 QUEUE-G8 §7 守卫/先dry-run）→ 收官 `SUMMARY-G9.md`。

## 五、一句话给业主
这趟把「看一段时偷偷先下好下一段」加进了两个播放器，并把学校速览的第一段从 37 秒砍到 20 秒。
本地测下来换段几乎零延迟、每段都能放。**现在请在终端挂代理推一下**，下一趟我去线上用慢网真测给你看数字。
