# JOB-GP1-03 进度交接（**进行中 · 未过闸 · 无 STOP**）

日期 2026-10-11｜Mac mini 无人值守 **第 5 趟**。GP1-03（英文全片横/竖 → 停审）是整条线最大的一包；本趟继续打地基、又产出一章完整成片，**仍未把全片做完**，**没写 rGP1-STOP.txt、没写 REVIEW=yes**，下一趟从这里接着做。

## 一句话（给业主）
这一趟干了三件实打实的事：①**堵了一个会泄密的漏洞**——账户设置页原来会把我们真实的测试登录邮箱（@gmail）明晃晃显示在画面上，等于录进视频就泄露了；现在全画面任何地方出现这个真邮箱都会自动换成 `agency.demo@example.com`，真帧已复验盖住。②**又录好一整章**——第 9 章「增值服务」横竖两个版本都录了真屏、配好英文旁白和字幕、合成了成片（1920×1080 和 1080×1920 各一条，带声音，约 21.7 秒），画面逐帧看过没问题。③**把第 6、10 章的真实按钮位置在真页面上摸清了**（原来镜表里记的选择器有一半对不上真页面），为下一趟省去返工。还没做的：第 6 章那种"点开录取弹窗、输优惠码、揭校名"的两层弹窗编排，第 10 章要删一个中介端没有的镜头再重录，以及第 1/3/4/5/7/8 章、开场片尾、整片拼接、海报缩略图、俄法中三语——所以**整片离交付还早**，这趟不叫你审。

## 本趟实际完成（都已验证）
1. **环境复核**：代理 127.0.0.1:10808 通（curl 200）；`bash jobs/db-run.sh states/verify.sql` → **16/16 PASS**（十名被荐生各状态、名额9/10、两盲offer、¥0付款单、提额待审全在）。DB 本趟**零写入**（只跑只读 begin/commit 探针 + 浏览）。
2. **铁律9 画面脱敏漏洞修复（影响全片）**：`rec.mjs` 的 `MASK_INIT` 原来只把登录框 `#emailInput` 的 @gmail 改掉；账户设置弹窗「Login email」行会原样显真邮箱。已改成**全画面周期 sweep**：所有 input/textarea 值 + 所有叶子元素文本里凡匹配 `…@gmail.com` 一律替换成 `agency.demo@example.com`。**真帧复验**：account-settings 帧邮箱已显 `agency.demo@example.com`（修前显真号）。
3. **逐章「开上下文」编排机制进 rec.mjs**：新增 `CONTEXT[CH]`，在登录+setLang 后、逐镜前镜外跑一次。已配 ch9/ch6=`viewReferredStudent(N)`、ch10=`toggleSettingsMenu+openAccountSettings`。
4. **第 9 章「Optional extras」完整成片**（继 trip4 的 ch2 后第 2 章完片）：
   - 实证：增值服务区是**学生列表卡内联**渲染（非详情弹窗），`.partner-premium-title/row/row--boost` 真在；4 镜高亮全中。
   - 横版 `en-land-ch9`、竖版 `en-port-ch9` 非 dry 录屏 → `prod-ch.mjs` 合成：
     - `ch9-land-en.mp4` **1920x1080 · audio=yes · 21.69s · 4镜 OK**
     - `ch9-port-en.mp4` **1080x1920 · audio=yes · 21.65s · 4镜 OK**
   - 合成帧肉眼复验：顶章节条「Chapter 9 · Optional extras」+ 页面高亮 + 底部英文字幕带（"unlimited unlocks…"）+ 音轨齐全。
   - 成片在本机 `~/guide/dist/partner/`（不进 git/mh-jobs/桶，遵铁律10）。
5. **ch6 / ch10 真选择器实证**（原 shots-v1 多处对不上 v184 真 DOM，已记 CHOREOGRAPHY.md trip5 节）：
   - **ch10**：账户设置 = `#asModal`；语言切换真 class = 顶条 `.lang-switcher/.lang-btn` 或 `#asModal` 内 `.stu-set-langs`（需下滚）；退出 = `settingsSignOut()`。10-1「再次申请」中介端无（storyboard 预授权删）。
   - **ch6**：两盲 offer = detail 内 `.school-card.school-card-clickable`，onclick=`openCloudAdmissionModal('agent',6,'<uuid>')`（uuid 运行时抓、rebuild 变）；6-2..6-7 在二级 admission 弹窗内，未开则 MISS（实测 7 镜 6 MISS）。

## 主仓库（本轮点名 commit，不推主仓库——遵铁律）
- 改：`jobs/JOB-GP1/rec/rec.mjs`（MASK_INIT 全画面脱敏 + CONTEXT 开场编排 + openSettings 增 openAccountSettings）、`jobs/JOB-GP1/rec/CHOREOGRAPHY.md`（trip5 修正节）。
- 新：`jobs/JOB-GP1/rec/probe-ctx.mjs`（只读 DOM 探针）。
- 录帧/音频/成片仍不入 git。别线（G8/G9/GP0）改动未碰未提交。

## 下一趟要做（GP1-03 续，按此序）
1. **ch10 收尾**：改 shots-v1 ch10 选择器（langs→`.stu-set-langs`/`.lang-switcher`、signout→`settingsSignOut`）+ 删 10-1（连带 captions-v1 / voice/*/10-1.m4a / durations）→ 录横竖 → 合成。
2. **ch6 两级弹窗编排**：rec.mjs 加 `openAdmission`/`openPayment` special——运行时从 detail 的 `.school-card` onclick 抓 offerId → `openCloudAdmissionModal('agent',6,offerId)` 开二级弹窗；实证二级弹窗内 `.admission-id-tag`/`#couponInput`/`.cloud-offer-unlock`/`.btn-accept` 选择器 → 修 shots-v1 ch6 → 录横竖 → 合成。
3. **其余简单章**：ch2(已完)、ch9(已完)后，补 ch4(viewReferredStudent(4)+邀请)、ch8(_qrOpenRaise 提额)、ch5(退回理由 selector 定位)。
4. **难章**：ch1 reg 从零注册（guide_ptReg 登录态，录完 reset 删）、ch3 向导步进+MRZ 护照（OCR 不触发则静态高亮，storyboard §2.6 预授权）、ch7 letter/jw202（先 `st-pt07-letter.sql`+`st-pt08-jw202.sql` 传 SPECIMEN 到桶）。
5. **OP/ED + 整片**：gp1-overlays 出开场/片尾卡 → 配 OP/ED 配音 → 章节 mp4 拼 full + quick 速览 + 海报 + 缩略图（横竖各套）+ 格式闸 + 联络表(shots/GP1/en/) + hl 审查表。
6. **全章横竖齐、格式闸全过后**才：写 `~/mh-jobs/JOB-GP1-03.md` + `SUMMARY-GP1-A.md`（REVIEW=yes），写 `~/mh-verify/rGP1-STOP.txt=WAIT_REVIEW`，结束本趟。**GP1-04 前提 = jobs/JOB-GP1/REVIEW-en.md 存在**。

## 合规
无需业主拍板（storyboard 已定照办，未写 NEEDS_OWNER_DECISION）。未改五端 HTML；未碰 JOB-G*/GS*/GP0 原文件；未碰 R2/CF；未起后台任务；node 走代理；DB 零写入（只读复核 + 浏览）；本轮不推主仓库、未写 NEED_PUSH。画面脱敏漏洞已补。
