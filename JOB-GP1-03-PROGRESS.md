# JOB-GP1-03 进度交接（**进行中 · 未过闸**）

最新：2026-10-11 Mac mini 无人值守 **第 9 趟**。按 RULING-20261011-ch4（选 B 无人值守继续）继续动作章。
本趟新成片：**第 5、7、8 章**（横+竖，带英文旁白字幕，真帧肉眼复验、零 @gmail 泄露）。
**未写 rGP1-STOP.txt / SUMMARY-GP1-A.md**——那只在英文十章全片拼完时写；剩 1 / 3 / 6 + 开场/片尾/拼接/联络表 未做。

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
- **ch6 多校录取（pt-06 Bilal，两盲 offer）= 最难**：detail 内两张盲 `.school-card.school-card-clickable`(offerId 运行时抓)→开 `#admissionModal`→`.cloud-offer-unlock`(onclick `_cloudAdmUnlock()` **写 unlocked_at**)→`#paymentModal` 优惠码框打字 MAXHOUSE→应付 ¥0(停≥2s 框住)→确认→校名揭晓 Demo University→`.btn-offer-accept`(`_cloudAdmRespond('accepted')` **又写库**)。需 harness 打字+顺序点击(已有 type/click/clickConfirm)+可能加 waitFor 等 #paymentModal。第二盲 offer 留盲比较。**真写 pt-06 自家 offer，录后必 rebuild 复位(verify #5 两盲 pending)**。建议先只读探针走一遍 unlock→payment 选择器(探针本身会写 unlocked_at，跑完即 rebuild)。
- **ch3 提交第一个学生（pt-01 草稿 Ayesha）**：`openReferralForm()`→`_wzOpen()` 向导；步进函数/stepper 选择器待实证；打字填表+传 SPECIMEN+提交→真 app_no(写 pt-01)。MRZ 合成护照 OCR 不触发则按 storyboard §2.6 预授权改静态高亮。录后 reset 回草稿。
- **ch1 注册从零**：harness 现**强制登录 guide_partner**，ch1 需「不登录」路径——rec.mjs 要加 `--nologin` 分支或 ch1 专用录法(gateShowRegister→注册→资质打字→传 2 SPECIMEN→审核中→切 guide_partner 录 APPROVED)。先删 guide-pt-reg 账号(注册才走得通)，录完 rebuild 重建 reg。**最复杂，建议放最后或留待下趟**。
- 齐后：开场 OP / 片尾 ED（gp1-overlays）→ 整片拼接 full/quick → 联络表 → 写 `JOB-GP1-03.md` + `SUMMARY-GP1-A.md`(REVIEW=yes) + `~/mh-verify/rGP1-STOP.txt`=WAIT_REVIEW 停审。

## 两级弹窗 / ch7 实证索引（供下趟 ch6 复用）
- 学生卡→`viewReferredStudent(N)`，N=列表显示序(非 pt 号)。本轮基线真机映射：N=2 Nilufar(pt-07)、N=3 Abena(pt-08)、N=4 Dmitri(pt-09)、N=8 Rahim(pt-03)。**rebuild 后顺序可能变，录前用 DB 名字→viewReferredStudent 现对**。
- detail 内 `[onclick*="openCloudAdmissionModal"]` = school-card，eval 其 onclick 开 `#admissionModal`。
- 下载钮 `.admission-doc-btn-letter` / `.admission-doc-btn-jw`；建档进度 `.offer-progress`(含 ✓Enrollment)；揭晓胶囊 `.admission-id-tag--unlocked`；校名联系块 `_p130_ContactBlock`(含 @gmail，靠 MASK TreeWalker 盖)。

## 合规
未改五端 HTML(只读 partner v184)；未碰 JOB-G*/GS*/GP0 原文件；未碰 R2/CF；未起后台任务；node 走代理。写入仅 ch7 置态(pt-07 letter / pt-08 jw202，指既有 specimen/ 对象)，**录后 rebuild 清回基线 verify 16/16 PASS**；ch5/ch8 零 DB 写入(前端暂存/示意)。画面脱敏：真帧复验 + 程序 @gmail 探测双证，本轮全章 ✅ 无泄露。本轮**不推主仓库**、未写 NEED_PUSH；主仓库仅点名 commit 自己的文件。
