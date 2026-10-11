# JOB-GP1-03 进度交接（**进行中 · 未过闸 · 无 STOP**）

日期 2026-10-11｜Mac mini 无人值守 **第 6 趟**。GP1-03（英文全片横/竖 → 停审）是整条线最大的一包；本趟把第 10 章做成完整成片、并把第 4/6 章的真实结构摸清，**仍未把全片做完**，**没写 rGP1-STOP.txt、没写 REVIEW=yes**，下一趟从这里接着做。

## 一句话（给业主）
这趟干了两件实打实的事：①**第 10 章「账户、语言与安全」录成完整成片**——横竖两个版本都录了真屏、配好英文旁白和字幕、合成成片（1920×1080 和 1080×1920 各一条，带声音，约 16.3 秒），画面逐帧看过：顶部章节条、账户菜单、橙框高亮、底部字幕都对，**真实测试邮箱已被自动遮成 `agency.demo@example.com`**（没泄露）。原分镜里有个「毕业后再次申请」的镜头，中介端其实没有这功能（分镜里早已写明没有就删），本趟按约删掉了。②**把第 4、6 章的真实按钮位置在真页面上摸清了**，记进了编排图，省下趟返工。
还没做的：第 6 章「解锁校名→付款→揭晓」那一串、第 4 章「邀请→提交」的后半、以及第 1/2(重录)/3/5/7/8 章、开场片尾、整片拼接、海报缩略图、俄法中三语——**整片离交付还早，这趟不叫你审。**
一个要提前讲清的结论：**剩下的章节大多不是「只看不点」就能录的**——很多「结果画面」（比如名额从 10 批到 30、材料换版后变审核中、校名解锁后揭晓）必须先改一下数据库状态才拍得到，拍完再改回去。这类写操作规则是允许的（只动演示机构自家的数据），但**不适合无人值守裸跑**（万一中途断网会把演示数据留在半截状态）。建议这些「动作章」集中到一趟有人看着、或带可靠「拍完自动还原」的流程里做。

## 本趟实际完成（都已验证）
1. **环境复核**：代理 127.0.0.1:10808 通（curl 200）；ffmpeg 9.0.2 在；accounts.json 有 guide_partner；四语配音在（en 60 条）。`bash jobs/db-run.sh states/verify.sql` 开工前 **16/16 PASS**，收工前再测 **仍 16/16 PASS**（本趟 **DB 零写入**，全是只读探针 + 浏览）。
2. **第 10 章完整成片**（继 ch2[trip4 dry]、ch9[trip5] 后第 3 章）：
   - 只读探针 `probe-ch610.mjs` 实证真选择器：账户菜单 `#settingsMenu`[300x322] 内「Account settings / 语言 / Sign out」三样全可见；顶条语言切换 `.lang-switcher`[153x32]「EN 中 РУ FR」常驻。原分镜的 `.stu-set-langs` 在当前 DOM 不可见（废），`.dl-ibtn` 等也核了。
   - 据此改 `shots-v1.json` ch10 选择器 + rec.mjs `CONTEXT['10']`（只开菜单不开 asModal，否则 Sign out 会消失）。
   - 删 10-1（中介端无再次申请，storyboard 预授权）：连带删 captions-v1 的 10-1、voice/{en,zh,ru,fr}/10-1.m4a、四语 durations 的 10-1 键；shot_count 62→61，narrated_shots 59→58。
   - 录横 `en-land-ch10`(3 镜全解析无 MISS) + 竖 `en-port-ch10` → `prod-ch.mjs` 合成：
     - `ch10-land-en.mp4` **1920x1080 · audio=yes · 16.26s · 3镜 OK**
     - `ch10-port-en.mp4` **1080x1920 · audio=yes · 16.26s · 3镜 OK**
   - **真帧肉眼复验**（/tmp 抽帧）：章节条「Chapter 10 · Account, language & security」、账户菜单（邮箱显 `agency.demo@example.com`=MASK 生效）、三镜橙框分别框住 Account settings / 顶条语言 / Sign out、底部英文字幕齐。成片在本机 `~/guide/dist/partner/`（不进 git/mh-jobs/桶）。
3. **第 6 章实证（一级已验，二级定性卡点）**：一级(6-1/2/3)纯读已验（offer 卡→admission modal→盲卡字段/奖学金/unlock 全可见）。二级(6-4..6-7)卡点=写库+交互：解锁 `_cloudAdmUnlock()` 写 unlocked_at（破 verify #5 盲态）；coupon/¥0 在 `#paymentModal`（无纯前端 opener）；accept 被「先确认专业」锁（`_cloudAdmRespond('accepted')` 又写库）；且需打字+多步点击，现 harness 不支持。详见 CHOREOGRAPHY trip6 节（含三种可行路线）。
4. **第 4 章实证（部分）**：邀请流 `_dlOpenInvite()`→`#dlModal`/`#dlEmail`/`#dlName`/`#dlInviteList` 全可见；**4-1 原 `.dl-ibtn` 是死选择器**，真入口=文案按钮「Invite student to self-upload」。4-4/4-5 状态不匹配（pt-04 仅 3/6、无「提交申请」按钮）→ 待定状态源。详见 CHOREOGRAPHY。

## 主仓库（本轮点名 commit，不推主仓库——遵铁律）
- 改：`jobs/JOB-GP1/rec/shots-v1.json`（ch10 选择器+删10-1+shot_count 61）、`jobs/JOB-GP1/rec/rec.mjs`（CONTEXT['10'] 只开菜单）、`jobs/JOB-GP1/captions-v1.json`（删10-1+计数）、`jobs/JOB-GP1/rec/CHOREOGRAPHY.md`（trip6 实证节）。
- 新：`jobs/JOB-GP1/rec/probe-ch610.mjs`（只读聚焦探针 ch10/ch6/ch4）。
- 录帧/音频/成片仍不入 git（.gitignore）。别线（G8/G9/GP0 等）改动未碰未提交。
- voice/durations 的删改属本地 scratch（gitignore 内），不入 git。

## 下一趟要做（GP1-03 续，按此序）
1. **动作章集中做（建议有监督或带 reset）**：ch6(解锁/揭晓/接受)、ch5(换版)、ch8(提额批准 8-4)、ch4(提交申请 4-5)、ch7(letter/jw202 需 SPECIMEN 上桶)——均需 states/*.sql 置态→录→reset，并需给 harness 加「打字+顺序点击」能力。
2. **纯读章收尾**：ch4 邀请流(4-1 改文案选择器已记) 可先录；ch2 非 dry 重录。
3. **难章**：ch1 reg 从零注册（guide_ptReg 登录态，录完 reset 删）、ch3 向导步进+MRZ 护照（OCR 不触发则静态高亮，storyboard §2.6 预授权）。
4. **OP/ED + 整片**：gp1-overlays 出开场/片尾卡 → 配 OP/ED 配音 → 章节 mp4 拼 full + quick 速览 + 海报 + 缩略图（横竖各套）+ 格式闸 + 联络表(shots/GP1/en/) + hl 审查表。
5. **全章横竖齐、格式闸全过后**才：写 `~/mh-jobs/JOB-GP1-03.md` + `SUMMARY-GP1-A.md`（REVIEW=yes），写 `~/mh-verify/rGP1-STOP.txt=WAIT_REVIEW`，结束本趟。**GP1-04 前提 = jobs/JOB-GP1/REVIEW-en.md 存在**。

## 成片进度表（非 dry 真片）
| 章 | 横 | 竖 | 状态 |
|---|---|---|---|
| 2 | dry 版 | dry 版 | 待非 dry 重录 |
| 9 | ✅ | ✅ | 完片(trip5) |
| 10 | ✅ | ✅ | 完片(trip6) |
| 其余 1/3/4/5/6/7/8 | — | — | 未录 |

## 合规
无需业主拍板（storyboard 已定照办，未写 NEEDS_OWNER_DECISION）。未改五端 HTML；未碰 JOB-G*/GS*/GP0 原文件；未碰 R2/CF；未起后台任务；node 走代理；DB 零写入（开工+收工各一次只读 verify 均 16/16）；本轮不推主仓库、未写 NEED_PUSH。画面脱敏 trip5 已补、本趟真帧再复验生效。
