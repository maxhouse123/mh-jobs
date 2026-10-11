# JOB-GP1-03 进度交接（**进行中 · 未过闸**）

最新：2026-10-11 Mac mini 无人值守 **第 8 趟**。按业主 RULING-20261011-ch4（选 B 无人值守继续）开工：
**第 4 章（委托邀请 → 中介提交）动作章完整成片**，并把「打字/连点/确认/选择器等待」动作原语搬进 harness（后续动作章复用）。
**未写 rGP1-STOP.txt / SUMMARY-GP1-A.md（REVIEW=yes）**——那只在英文十章全片拼完时写；剩 1/3/5/6/7/8 + 开场/片尾/拼接/联络表 未做。

## 一句话（给业主）
困住前 7 趟的「第 4 章提交按钮找不到」，这趟查出病根：那颗按钮只在学生被标成「委托生」时才长出来，而建数据的脚本漏标了这一项——补上就有了，不是功能没做。这趟把第 4 章从头到尾录成了成片（横屏 + 竖屏，带英文旁白字幕，约 43 秒），画面里学生真邮箱全部打码成 example.com（新加了自动查泄露，5 个镜头全过）。录完把数据库一键还原到基线，自检 16/16 全过。顺带修好了一个一直潜伏、靠运气没炸的登录 bug。

## 本趟实际完成（已验证）
1. **开工 verify 16/16 PASS**；收工 rebuild 后 verify **16/16 PASS**（REBUILD_OK）。数据库净写入=0（录制中的临时写入已全数还原）。
2. **第 4 章病根实证（iron-law-14）**：委托卡「邀请发出→学生注册→材料传齐→你提交」时间线盒 + 提交按钮由 `_dlDecorateDom()`(v184 L13713) 画，**硬要求 `intake_mode==='delegate'`**(L13730)；seed 只设 `submit_holder='partner'` 没设 intake_mode → 盒子不画 → 按钮不存在。补 `intake_mode='delegate'` 即现。
   - 提交按钮：`button.dl-abtn.primary[data-dl-submit]`，文案键 `dl.submit`；材料齐(`_dlDocCount.ok`)才可点；点→`_dlSubmit`→确认框 `#confirmModalConfirmBtn`→`students.update({submitted_at})`；卡变「Submitted · <app_no>」。
3. **材料口径修正（图纸冲突·按 RULING 授予的代裁权定案）**：委托必传集=passport/education/transcript/photo（in_china=false 不含 visa）=**4 份**；真机显「3/4→4/4」，storyboard/RULING 的「3/6→6/6」是学生端 6 类口径、委托卡不适用。字幕不含数字，无观众面影响。pt-04 缺 transcript，补 SPECIMEN→4/4。
4. **第 4 章成片**（本机 `~/guide/dist/partner/`，不进 git/mh-jobs/桶）：
   - `ch4-land-en.mp4` **1920x1080 · audio=yes · 42.87s · 5 镜**；`ch4-port-en.mp4` **1080x1920 · audio=yes · 42.62s · 5 镜**。
   - 5 镜：4-1 邀请按钮｜4-2 表单打字（演示名/邮箱）｜4-3 已发列表 Copy/Resend（真邮箱已打码 example.com）｜4-4 委托卡时间线 3/4、提交按钮灰｜4-5 材料齐 4/4→提交亮→点→确认→卡变「Submitted · MH-EZX4RE」。真帧肉眼复验全对。
   - **脱敏**：harness 新增「DOM 文本 @gmail 探测」，land+port 两版全 5 镜 **✅ 无 @gmail**。
5. **动作原语底座入 rec.mjs（RULING §7，后续动作章复用）**：shot 支持 `pre`(镜前页面 eval 置态) + `act`[](镜后动作：type/click/clickConfirm/wait/eval/ms)。
6. **顺带修 2 个登录潜伏问题**：①`waitForFunction` options 误位 → 一直只有 30s 超时，改真 60s；②MASK 通用 input 循环在 fill↔点击间把门禁邮箱框盖成演示邮箱→「Invalid login credentials」，加 `window.__mhLogin` 闸（登录 offCamera 不盖门禁框）。MASK 另加「邀请列表数据源头脱敏」。

## 成片进度表（正式成片）
| 章 | 横 | 竖 | 状态 |
|---|---|---|---|
| 2 | ✅ | ✅ | 完片（trip7） |
| 4 | ✅ | ✅ | **完片（trip8，动作章首杀）** |
| 9 | ✅ | ✅ | 完片（trip5） |
| 10 | ✅ | ✅ | 完片（trip6） |
| 1/3/5/6/7/8 | — | — | 待录（动作章；原语底座已就绪，病根式实证逐章补） |
| 开场OP/片尾ED/整片拼接/海报/缩略图/联络表 | — | — | 待章节齐 |

## 下一趟（动作章模板已跑通，照此做）
每章铁律：**开工先 verify 16/16（不过先 `bash jobs/JOB-GP1/rebuild-partner.sh`）→ 置态(states/*.sql 或客户端 pre)→录 land+port→复位(rebuild)→verify**。基线已含多数「结果态」(pt-06 两盲 offer / pt-03 退回 / pt-07 unlocked+accepted / pt-08 letter / pt-09 enrolled / quota_request pending)，很多读镜无需新写库。
- **ch5**：pt-03 transcript 已退回(基线)。5-1/5-2 读；5-3/5-4 换版=上传写库(用 pre 客户端演示或真传 SPECIMEN 后 reset)。退回理由真 class 待定位。
- **ch6**：pt-06 两盲 offer 已在(基线)。6-1/6-2/6-3 读(开 admission modal)；6-4..6-7 解锁/优惠码/接受=写库，录后 reset。二级弹窗 `#paymentModal` opener 待定位（CHOREOGRAPHY trip5/6 记）。
- **ch7**：先 `st-pt07-letter.sql`+`st-pt08-jw202.sql` 传样件→letter/jw202 下载按钮现→录→reset。
- **ch8**：8-1/8-2/8-3 基线已 quota 9/10 + quota_request pending；8-4 跑 `st-quota-approve.sql` 录 10→30→reset。
- **ch3**：向导打字+上传+提交→真 app_no(写 pt-01)；MRZ 合成护照 OCR 不触发则按 storyboard 预授权改静态高亮。
- **ch1**：reg 从零注册（先删 guide-pt-reg 账号→注册→资质打字→传 2 SPECIMEN→审核中→切 guide_partner 录 APPROVED→rebuild 重建 reg）。
- 齐后：开场 OP / 片尾 ED（gp1-overlays）→ 整片拼接 full/quick → 联络表 → 写 `JOB-GP1-03.md` + `SUMMARY-GP1-A.md`(REVIEW=yes) + `~/mh-verify/rGP1-STOP.txt`=WAIT_REVIEW 停审。

## 合规
未改五端 HTML；未碰 JOB-G*/GS*/GP0 原文件；未碰 R2/CF；未起后台任务；node 走代理；写入仅 Demo Agency 自家 is_test(pt-04 一行 + 一份 SPECIMEN transcript + 一次真提交)，4-3 sent 行纯客户端注入不写库，录后全 rebuild 清回基线(verify 16/16)；画面脱敏真帧复验 + 程序探测双证零 @gmail；本轮**不推主仓库**、未写 NEED_PUSH；主仓库仅点名 commit 自己的文件。
