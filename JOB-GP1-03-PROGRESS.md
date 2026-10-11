# JOB-GP1-03 进度交接（**进行中 · 未过闸 · 已停下等业主拍板**）

最新：2026-10-11 Mac mini 无人值守 **第 7 趟**。本趟补成第 2 章正式成片，随后撞墙：剩余七章无人值守做不出来、且第 4 章有一处分镜/现网冲突（铁律 14）必须业主定案 → 已写 `jobs/JOB-GP1/NEEDS_OWNER_DECISION.md` 并停下。**没写 rGP1-STOP.txt**（那只在英文全片做完时写），**没写 REVIEW=yes**。

## 一句话（给业主）
英文片十章里，**第 2、9、10 章已成片**（都是「只看不点」能录的纯读章）。**剩第 1、3、4、5、6、7、8 共七章全部卡住**——都要「先改数据库状态/传样件到桶 + 录屏时打字、连续多步点击」，现录屏工具只会「高亮+单步」，做不了；且这类「动作章」要边改演示数据边录、录完复位，无人值守裸跑有断网留半截风险（前两趟同结论）。另第 4 章「材料齐→提交申请按钮」现网找不到该按钮，按铁律 14 须业主读源码定案。详见 `jobs/JOB-GP1/NEEDS_OWNER_DECISION.md`（两个待定：①ch4-5 提交入口落点 ②动作章用「有监督一趟」还是「无人值守继续」）。

## 本趟实际完成（已验证）
1. **环境复核**：代理 127.0.0.1:10808 通（curl 200）；ffmpeg 9.0.2；四语音在；accounts.json 有 guide_partner。
2. **数据库零写入**：开工 `verify.sql` **16/16 PASS**，收工再测 **16/16 PASS**（全程只读探针+录屏浏览）。
3. **第 2 章补成正式成片**（此前仅 trip4 dry 空跑版）：
   - `rec.mjs --chapter 2 --orient land/port --lang en` 各一遍，5 镜全高亮命中、**0 MISS**（2-2 677x70 / 2-3 220x73 / 2-4 509x50 / 2-5 铃 90x90）。
   - `prod-ch.mjs` 合成：`ch2-land-en.mp4` **1920x1080 · audio=yes · 27.61s · 5 镜 OK**；`ch2-port-en.mp4` **1080x1920 · audio=yes · 27.58s · 5 镜 OK**。
   - **真帧肉眼复验**：章节条「Chapter 2 · Your Partner Hub」、Demo Agency 抬头、名额提示条（10→30 pending）、通知面板（ACTION REQUIRED/GOOD NEWS/under review）、底部英文字幕；**无 @gmail 真邮箱**（页头为平台 maxhouses.net 服务邮箱，与已验收的 ch9/ch10 一致）。橙色高亮环跟随正确。成片在本机 `~/guide/dist/partner/`（不进 git/mh-jobs/桶）。
   - 旧 dry 版 `ch2-*-en-dry.mp4` 已被正式版取代（rm 受本机权限限制未删，文件名 `-dry` 可辨；下趟清理）。
4. **第 4 章只读实证**（新只读探针 `probe-ch4.mjs`，纯读不写库）：
   - 邀请弹窗 `_dlOpenInvite()` → `#dlModal` 可见；`#dlInviteList` 现显 pt-04「Aizhan Serikova … Registered」（**4-4「已注册」态现已成立✅**，比 trip6 的「· Sent」更进一步）；弹窗按钮：Create invite link / Cancel / ×。
   - **4-5 冲突实证**：工作台 + pt-04 详情**无任何 `submitApplication` 类按钮**，可见 submit 入口只有「+ Submit New Student Referral」(openAddStudentModal=发起新推荐)。→ 分镜 4-5 与现网冲突，入 NEEDS_OWNER_DECISION ①。
   - 另注：`viewReferredStudent(N)` 的 N **≠ pt 号**（运行时按排名排序，本次 (4) 打开的是 Islam Rahim=pt-03），CHOREOGRAPHY 原「N=pt号」表述不可靠，动作章录制须运行时按姓名/状态抓目标。

## 成片进度表（正式成片）
| 章 | 横 | 竖 | 状态 |
|---|---|---|---|
| 2 | ✅ | ✅ | 完片（trip7，补掉 dry） |
| 9 | ✅ | ✅ | 完片（trip5） |
| 10 | ✅ | ✅ | 完片（trip6） |
| 1/3/4/5/6/7/8 | — | — | 卡住，待业主拍板（见 NEEDS_OWNER_DECISION） |
| 开场OP/片尾ED/整片拼接/海报/缩略图/联络表 | — | — | 未做（待章节齐） |

## 主仓库（本轮点名 commit，不推主仓库——遵铁律）
- 新：`jobs/JOB-GP1/rec/probe-ch4.mjs`（只读 ch4 邀请流探针）、`jobs/JOB-GP1/NEEDS_OWNER_DECISION.md`。
- 录帧/成片/verify 抽帧（out/）、voice/ 均 gitignore 不入 git。别线（G8/G9/GP0 等）改动未碰未提交。

## 下一趟（业主回话后）
- 若给 ch4-5 落点 + 选「有监督一趟」：给 rec.mjs 加「打字+连续点击」能力 → 逐章 states/*.sql 置态→录→reset（每章前后 verify 16/16）→ 开场/片尾卡 → 整片拼接+海报+缩略图+联络表 → 写 JOB-GP1-03.md+SUMMARY-GP1-A.md(REVIEW=yes)+rGP1-STOP.txt=WAIT_REVIEW。
- 若选「无人值守继续」：同上但我自跑，每章出错即 rebuild-partner.sh 复位。

## 合规
无需改五端 HTML；未碰 JOB-G*/GS*/GP0 原文件；未碰 R2/CF；未起后台任务；node 走代理；DB 零写入（开工+收工各 16/16）；本轮不推主仓库、未写 NEED_PUSH；画面脱敏生效（真帧复验）。已按铁律 14/规矩 0.7 写 NEEDS_OWNER_DECISION 并停。
