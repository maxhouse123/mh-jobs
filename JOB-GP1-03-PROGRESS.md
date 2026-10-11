# JOB-GP1-03 进度交接（**进行中 · 未过闸 · 无 STOP**）

日期 2026-10-11｜Mac mini 无人值守 第 4 趟。GP1-03（英文全片横/竖 → 停审）是整条线最大的一包；本趟没有把它做完，**没有写 rGP1-STOP.txt，没有写 REVIEW=yes**，下一趟从这里接着做。

## 一句话（给业主）
英文操作视频这一大包，这一趟把"**合成机器**"修好并试通了：现在能把录好的画面配上**四语配音和字幕**合成章节片（之前的合成脚本只有画面没有声音）。还把每一章该点哪个按钮、该打开哪个学生、哪两份盲录取怎么调出来——**在真页面上逐一试探记清了**（写进 CHOREOGRAPHY.md）。但真正把 10 章横竖两版都录下来、拼成整片、加开场片尾、出联络表——这些**还没做**，因为每一章的多步点击编排要在真页面上一步步调，工作量远超一趟无人值守能稳妥做完的量。所以这一趟**只把地基打牢并记清路线**，没有赶工出半成品让你白审。

## 本趟实际完成（都已验证）
1. **DB 基线复核**：`verify.sql` **16/16 PASS**（GP1-01 的十名被荐生各状态、名额 9/10、两盲 offer、¥0 付款单、提额待审等全在，录制可直接读真实状态）。
2. **带配音章节合成器 `prod-ch.mjs`（新建·主仓库已 commit）**：逐镜分段，每镜画面定格到 `max(录制时长, 配音时长+0.45s)`，叠章节条+字幕带，**混入该镜本语配音**（之前的 `asm.mjs` 是纯视频无音轨）。**ch2 横竖两版实测**：`1920x1080` / `1080x1920`，**含 aac 音轨**，各 ~21.6s，分辨率 OK。
3. **开场/片尾叠层卡库 `gp1-overlays.mjs`（新建·已 commit）**：四条重点卡(OP-2..5)、品牌/目录卡(OP-1/6)、片尾回顾卡(ED-1)、二维码卡(ED-2)、带「Chapter N·标题」的章节条。渲染法照 gp0-overlays（Playwright 透明/满帧 PNG），未改 gp0 原件。
4. **逐章 live 钩子实证 `CHOREOGRAPHY.md`（新建·已 commit）**：真页面登录 guide_partner + setLang('en') 探针实证，记清每章开场钩子：
   - `.partner-student-card` onclick = **`viewReferredStudent(N)`**（N=pt 号，非卡面 #序）。
   - **ch6 全链实证**：`viewReferredStudent(6)` → detail 内**两盲 offer 行真渲染**（SCH-1AD6C8 / SCH-8E561C 校名遮蔽）→ 点 `openCloudAdmissionModal('agent',6,'<offerId>')` 开录取弹窗（coupon/¥0/解锁在其内）。offerId 是真 uuid、rebuild 会变 → **运行时抓 DOM onclick 参数，勿硬编码**。
   - ch9 detail 内 `.partner-premium-title` 增值服务区真渲染 ✅。
   - ch8 `_qrOpenRaise()`；ch10 `toggleSettingsMenu(event)`→`openAccountSettings()`；ch3 `openReferralForm()`→`_wzOpen()`。
   - `_cloudOffers`/`state` 在模块作用域、**不在 window**；取参靠 DOM 抓 onclick。

## 主仓库
- 点名 commit `edc151c`：`jobs/JOB-GP1/rec/{prod-ch.mjs, gp1-overlays.mjs, CHOREOGRAPHY.md}`。**本轮不推主仓库**（遵铁律）。
- 录帧/音频/成片（out/、voice/、guide/dist）仍不入 git（.gitignore）；*.gen.sql 不入 git。
- 别线（G8/G9/GP0）改动未碰未提交。DB 只读复核，**零写入**。

## 下一趟要做（GP1-03 续，按此序）
1. **写录制编排器**（扩 rec.mjs 或新建 prod-rec.mjs）：按 CHOREOGRAPHY.md 为每章加「开上下文」步骤——
   - 简单章先行验证闭环：**ch2 工作台**（已证）、**ch9 增值服务**（viewReferredStudent(10)，detail premium 已证）、**ch10 设置**。录真（非 dry）→ prod-ch.mjs 合成 → 肉眼看一帧。
   - 两级弹窗章：**ch6**（detail→抓 offerId→openCloudAdmissionModal→coupon/¥0/reveal/accept）、**ch7**（需先 `st-pt07-letter.sql`/`st-pt08-jw202.sql` 把 SPECIMEN 传桶，再录 letter/jw202 下载）。
   - **ch3 向导**步进函数待实证（`_wzGoStep`? stepper selector）+ 护照姓名核对触发（填 AMINAH DEMO 触发琥珀）。
   - **ch5** 退回理由真 class 待定位（detail 内 `.amber-box`/`.reason-box` 未可见）。
   - **ch1** reg 账号从零注册（gateShowRegister + guide_ptReg 登录态，录完 reset 删）。
2. **录前两前置**：① ch3 MRZ 合成护照（DEMO<<AMINA 校验位；OCR 不触发则改静态高亮，storyboard §2.6 预授权）；② SPECIMEN 上桶（ch7 下载前）。
3. **OP/ED 合成**：gp1-overlays 出卡 → 配 OP/ED 配音 → 插第 6/3/7 章快剪 2s（quick-cut footage 从已录章节抽窗）。
4. **收尾**：章节 mp4 → full + quick（§三速览清单）+ 海报 + 缩略图（横竖各一套）；格式闸（分辨率/faststart/字幕带/音画对齐）；联络表每章横竖各 1 张（6~8 帧）推 `shots/GP1/en/` + hl 审查表（IoU/边差）；竖版双层镜单列。
5. **过闸后**才：写 `~/mh-jobs/JOB-GP1-03.md` + `SUMMARY-GP1-A.md`（REVIEW=yes），写 `~/mh-verify/rGP1-STOP.txt=WAIT_REVIEW`，结束本趟。**GP1-04 的前提是 jobs/JOB-GP1/REVIEW-en.md 存在**。

## 合规
无需业主拍板（storyboard 已定，照办；未写 NEEDS_OWNER_DECISION）。未改五端 HTML/JS/迁移；未碰 JOB-G*/GS*/GP0 原文件；未碰 R2/CF；未起后台任务；node 走代理；DB 零写入。
