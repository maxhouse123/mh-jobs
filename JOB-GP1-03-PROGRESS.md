最后一趟：2026-10-12 第11趟 — 按 RULING-20261012-gp1 续跑；**ch6 + ch7 两章 EN 横竖成片全部录完**（ch6 删 6-5、校名揭晓走产品 reveal 渲染、6-7 去倒计时；ch7 加 7-0 ¥0 优惠码真付款链+重录 7-1..7-4 名字解析）；每章录后 rebuild 复位、基线 16/16 PASS。EN 缺 ch1、ch3 两章。下趟：ch3（3-5 AI 预检用产品渲染函数喂样例）、ch1（注册从零），然后 EN 十章齐 → overlays/拼接/联络表 → REVIEW-en-self.md 自审 → 中俄法。

# JOB-GP1-03 进度交接（**进行中 · 视频制作跑到收官**）

## 第 11 趟（2026-10-12 Mac mini 无人值守）
业主 2026-10-12 下 RULING-20261012-gp1：视频做到收官、上线前停；分镜与产品对不上时 CC 自处理记账不停（四种情况才停）。本趟从该裁决接着做。
- **ch6 多校录取（pt-06 Bilal 两盲 offer）= 照 RULING §1 重做，EN 横竖成片已出**（~42s，6 镜，1920x1080 / 1080x1920，带英文旁白字幕，真帧肉眼复验、零 @gmail）：
  - 6-1 两盲 offer 卡 → 6-2 开录取弹窗(盲码 SCH-1AD6C8 + 专业 + 开学 + 奖学金，无校名) → 6-3 奖学金行 → 6-4 点解锁(无旁白·真写 unlocked_at) → 6-6 校名揭晓(Demo University·演示大学 + 联系块) → 6-7 接受该专业按钮。删 6-5。
  - **6-6 校名揭晓用产品自身 reveal 渲染喂演示校数据（铁律14-P2 + RULING §2.1c，ch8 先例）**：源码+真机实证证明 partner 端 beta 解锁只翻 unlocked_at、服务端不去盲（get_agent_unlocked_offer_school 对未付款 offer 返回 []），真校名要付款才放。故 6-6 把真·演示大学数据注入产品自己的 _p130_SchoolCache 再调 openCloudAdmissionModal 重绘——像素与已付款学生(pt-09)同源，非自造。见 DECISIONS D-11-1。
  - **6-7 字幕去掉「倒计时」**：真机 pending 盲 offer 无倒计时元素（倒计时块仅 accepted+letterUp+!paid 才渲染），四语字幕改为陈述画面真有的「接受该专业 + 开学日期 + 奖学金」，6-7 音频四语重配。见 DECISIONS D-11-2。
  - **harness 加固**：MASK 脱敏加 MutationObserver（re-render 即刻补扫）+ 抓泄露前强制 sweep + sweep 间隔 120→80ms——消除「弹窗重开后、下次 sweep 前」的 @gmail 瞬露窗口（ch6-2 首录曾因此报泄露，修后零泄露）。
- **DB 全程守住 16/16**：ch6 land/port 各录一次（6-4 真写 unlocked_at），**录后各 rebuild 复位 verify 16/16 PASS**。
- **ch7 多校通知书/建档 = 照 RULING §1 加 7-0 + 重录，EN 横竖成片已出**（~42s，5 镜，带英文旁白字幕，真帧复验、零 @gmail）：
  - **7-0（新·¥0 优惠码）**：pt-07 通知书付款单真机驱动「Pay now→¥3,000→优惠码 MAXHOUSE→应付 ¥0(橙框≥2s)→勾同意→确认(真写 letter_paid_at)」；确认走 `coupon_agent_pay_offer` RPC 实证走通（确认后下载钮出现、offer 转 paid）。旁白/字幕/四语配音**复用原 6-5**（直接拷音频，字幕一字未改）。
  - **7-1..7-4 重录**：7-0 确认后 pt-07 转 paid → 7-1 下载通知书（校名 Demo University 此处是真·服务端去盲，因已付款）；7-2 pt-08 JW202；7-3 pt-09 建档进度；7-4 pt-09 列表卡。全改**按名字解析 viewReferredStudent(N)**（硬编码 2/3/4 已随 rebuild 失效）。
  - 置态 st-pt07-pay-cleanup.sql（授权删 pt-07 自家 ¥0 单 1 行）+ st-pt08-jw202.sql；录后各 rebuild 复位 verify 16/16 PASS。G-3 D1 遮蔽：当前 v184 付款单无 PayPal/half-price 元素，无需遮。OP-4 快剪改用 7-0；storyboard 升 v1.1。见 DECISIONS D-11-3/4。
- **下一步（下趟）**：ch3（3-5 AI 预检用产品渲染函数喂样例，3-6 护照核对同理；真 submit 录 app_no 后 rebuild）、ch1（注册从零，需 no-login 路径 + guide-pt-reg 账号）；EN 十章齐 → 开场/片尾 overlays → 全片+速览拼接(20-40s 分段) → 联络表 shots/GP1/en → REVIEW-en-self.md 九项自审 → 过了录中俄法 → GP1-04/05 收官 → SUMMARY-GP1.md。
- 成片现状（EN）：2·4·5·**6(新)**·**7(新,含7-0)**·8·9·10（8/10）；**缺 1·3**。

---
## 【历史·第 10 趟】停审待拍板（已被 RULING-20261012-gp1 解除）
第 10 趟零 DB 写入、只读探针验证 ch3 向导全链 + ch6 源码复核发现两冲突写了 NEEDS_OWNER_DECISION。业主已于 2026-10-12 以 RULING 拍板（ch6 ¥0 移 7-0、ch3 AI 预检用产品渲染），请示单改名 -resolved。

---
## 【历史】第 9 趟新成片：第 5、7、8 章（横+竖，带英文旁白字幕，真帧肉眼复验、零 @gmail 泄露）

## 一句话（给业主）
这趟又录好了三章操作演示：「材料被退回怎么补传」「录取通知书 / JW202 下载与建档完成」「名额快用完怎么申请提额」。都是横屏竖屏两版、带英文配音字幕，画面里学生真邮箱全部打码。录完数据库一键还原，自检 16/16 全过。还顺手把脱敏做得更严（现在任何角落出现的真邮箱都自动盖掉）。剩「多校录取解锁」「提交第一个学生」「机构注册」三章没录。

## 本趟实际完成（已验证）
1. **ch5 材料被退回（pt-03 Rahim Islam）**：5-1 列表卡→5-2 退回理由(Maxhouse 退回·英文原因)→5-3 点「换版」选 SPECIMEN 文件(前端暂存不写库)→5-4 徽章转「Under review」(前端示意·不写库)。**零数据库写入**。横 31.8s / 竖 32.1s。
2. **ch7 通知书/JW202/建档（pt-07 Nilufar / pt-08 Abena / pt-09 Dmitri）**：7-1 录取弹窗下载「Admission Letter」→7-2 下载「JW202 Form」→7-3 建档进度条(Accept✓/Letter✓/JW202✓/Enrollment✓)→7-4 列表卡「Admission complete」。录前置态 `st-pt07-letter.sql`+`st-pt08-jw202.sql`(传 SPECIMEN 到既有 specimen/ 对象，非真上传)，**录后 rebuild 复位 16/16**。横/竖各 28.5s。
3. **ch8 名额与提额（Demo Agency）**：8-1 统计卡「已提交 9」→8-2 打开「Referral quota reached」弹窗(传真值 used:9/quota:10，修掉 _qrOpenRaise 冷调出的 undefined/NaN)→8-3 填 30+理由、高亮 Submit(不真提交)→8-4 横幅转「Quota raise approved: now 30」(前端示意)。**零数据库写入**。横/竖各 30s。
4. **harness 三项加固（rec.mjs，复用于后续章）**：
   - `file` 动作原语：`{t:'file',sel,path}` → setInputFiles 选本地 SPECIMEN(ch5-3 换版用)。
   - `waitFor` 字段：镜前 runPre 后等指定选择器可见(≤9s)再高亮——解两级弹窗(detail→#admissionModal)异步开启的时序，ch7 用它稳稳等出下载按钮。
   - **MASK 脱敏升级为 TreeWalker 全文本节点扫描**：原只盖「叶子元素」文本，漏了「含子节点元素的直系文本节点」里的 @gmail(ch7-2 pt-08 详情里学生邮箱曾漏 1 次)；改成 TreeWalker 遍历 document.body 所有文本节点，@gmail 不论嵌套层级一律盖成 agency.demo@example.com。ch7 重录后 land+port 全 ✅ 无泄露。
5. **两级弹窗真机实证（ch7，写进本文件下方）**：`openCloudAdmissionModal(lane,idx,offerId)` 填 `#admissionModalBody`、给 `#admissionModal` 加 `.show`；offerId 是运行时 uuid(rebuild 变)，pre 里用 setInterval 从 detail 的 school-card onclick 现抓现开。下载钮渲染条件 = `letter_paid_at 非空 && (letter_uploaded_at||jw202_uploaded_at)`(源 L5544 `_renderCloudAdmissionBody`)——只上传不付款不出钮；pt-07/08/09 基线已 `letter_paid_at`，故置态只补 uploaded_at 即现钮。

## 成片进度表（正式成片，本机 ~/guide/dist/partner/，不进 git/桶）
| 章 | 横 | 竖 | 趟 |
|---|---|---|---|
| 2 | ✅ | ✅ | trip7 |
| 4 | ✅ | ✅ | trip8（动作章首杀）|
| 5 | ✅ | ✅ | **trip9** |
| 7 | ✅ | ✅ | **trip9** |
| 8 | ✅ | ✅ | **trip9** |
| 9 | ✅ | ✅ | trip5 |
| 10 | ✅ | ✅ | trip6 |
| **1 / 3 / 6** | — | — | **待录** |
| 开场OP/片尾ED/拼接/海报/缩略图/联络表 | — | — | 待章节齐 |

## 下一趟（剩 ch6 / ch3 / ch1 + 收尾）
每章铁律：开工先 verify 16/16（不过先 `bash jobs/JOB-GP1/rebuild-partner.sh`）→置态→录 land+port→复位(rebuild)→verify。
- **ch6 多校录取（pt-06 Bilal，两盲 offer）= ⚠图纸与现实冲突·需业主拍板（铁律14-P2）**。trip9 已把 ch6 全链真机 + 源码读通（只读探针，零写库，verify 16/16 复核过）：
  - **可录的真流程（无冲突）**：6-1 卡「2 offers」→开 detail；6-2 两张盲 `.school-card.school-card-clickable`(offerId=运行时 uuid，本轮 09c33dd3…/16e071e9…，rebuild 变；pt-06 本轮=viewReferredStudent(3))，盲态显 专业/学费/奖学金/截止、**校名遮成 SCH-1AD6C8 / SCH-8E561C**；6-3 比两份奖学金；6-4 `#admissionModal` 内 `.cloud-offer-unlock`(onclick=`_cloudAdmUnlock()`)→**揭晓 Demo University**；6-7 `.btn-offer-accept`(onclick=`_cloudAdmRespond('accepted')`)接受。unlock 与 accept **都写 pt-06 自家 offer**，录后必 rebuild 复位(verify #5 两盲 pending)。
  - **冲突点 = 6-5/6-6「优惠码 MAXHOUSE → 应付 ¥0」**：真机里 **unlock 不收款**——按钮原文 L5642「解锁查看（内测：仅状态翻转，不收款）」，`_cloudAdmUnlock`→`_agentUnlockOffer`(只翻 unlocked_at)→重开弹窗揭晓校名，**全程无付款单、无优惠码框**。¥0 的 MAXHOUSE 优惠码是**另一条链**：录取通知书付款 `_cloudAdmPay()`(L5107)→`#paymentModal`→`#couponInput` 打 MAXHOUSE→`SCHOOL_PAYMENT_AMOUNT=3000` 减到 ¥0；而这颗「💳 Pay now to view & download」钮(L5637)**只在 offer 已接受且学校已出通知书、尚未付款时**才出现。pt-06 是盲 offer，没接受、没通知书 → **在 pt-06 身上根本到不了优惠码 ¥0 画面**。全库唯一有 ¥0 MAXHOUSE 付款单的是 pt-07(verify #7，但已 letter_paid，付过了，不会再弹付款框)。
  - **→ 请业主三选一**：(A) ch6 去掉 ¥0 优惠码镜，只录「盲比→解锁揭晓→接受」，¥0「不收费」卖点改放别处/片尾；(B) 授权把 6-5「¥0 优惠码」镜改录在**真付款链**上——临时把某生(建议 pt-07)的 `letter_paid_at` 置空(Demo Agency 自家 offer，录后 rebuild 复位)，开其录取通知书付款弹窗真打 MAXHOUSE→¥0，接受学生主角切成 Nilufar(旁白不点名，弹窗聚焦金额/优惠码)；(C) 改分镜。**CC 不自修、不自造付款界面(铁律14-P2+铁律15)**，等拍板。
- **ch3 提交第一个学生（pt-01 草稿 Ayesha）= 向导开法待实证**：trip9 探针实测 `openReferralForm`/`_wzOpen`/`_wzNext`/`openAddStudentModal` 都在，但 `_wzGoStep`/`_wzSubmit`/`submitReferral` **undefined**；直接 `openReferralForm()`**没弹出可见 modal**(`.modal-bg.show`=空)，`[id^=wz]` 元素在但 hidden。下趟先定位向导真开法(可能需先进 pt-01 草稿上下文或别的入口)、步进(`_wzNext` 连点?)、各步 input id、提交函数。之后打字填表+传 SPECIMEN+提交→真 app_no(写 pt-01)；MRZ 合成护照 OCR 不触发则按 storyboard §2.6 预授权改静态高亮。录后 reset 回草稿。
- **ch1 注册从零**：harness 现**强制登录 guide_partner**，ch1 需「不登录」路径——rec.mjs 要加 `--nologin` 分支或 ch1 专用录法(gateShowRegister→注册→资质打字→传 2 SPECIMEN→审核中→切 guide_partner 录 APPROVED)。先删 guide-pt-reg 账号(注册才走得通)，录完 rebuild 重建 reg。**最复杂，建议放最后或留待下趟**。
- 齐后：开场 OP / 片尾 ED（gp1-overlays）→ 整片拼接 full/quick → 联络表 → 写 `JOB-GP1-03.md` + `SUMMARY-GP1-A.md`(REVIEW=yes) + `~/mh-verify/rGP1-STOP.txt`=WAIT_REVIEW 停审。

## 两级弹窗 / ch7 实证索引（供下趟 ch6 复用）
- 学生卡→`viewReferredStudent(N)`，N=列表显示序(非 pt 号)。本轮基线真机映射：N=2 Nilufar(pt-07)、N=3 Abena(pt-08)、N=4 Dmitri(pt-09)、N=8 Rahim(pt-03)。**rebuild 后顺序可能变，录前用 DB 名字→viewReferredStudent 现对**。
- detail 内 `[onclick*="openCloudAdmissionModal"]` = school-card，eval 其 onclick 开 `#admissionModal`。
- 下载钮 `.admission-doc-btn-letter` / `.admission-doc-btn-jw`；建档进度 `.offer-progress`(含 ✓Enrollment)；揭晓胶囊 `.admission-id-tag--unlocked`；校名联系块 `_p130_ContactBlock`(含 @gmail，靠 MASK TreeWalker 盖)。

## 合规
未改五端 HTML(只读 partner v184)；未碰 JOB-G*/GS*/GP0 原文件；未碰 R2/CF；未起后台任务；node 走代理。写入仅 ch7 置态(pt-07 letter / pt-08 jw202，指既有 specimen/ 对象)，**录后 rebuild 清回基线 verify 16/16 PASS**；ch5/ch8 零 DB 写入(前端暂存/示意)。画面脱敏：真帧复验 + 程序 @gmail 探测双证，本轮全章 ✅ 无泄露。本轮**不推主仓库**、未写 NEED_PUSH；主仓库仅点名 commit 自己的文件。
