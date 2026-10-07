PUSH_OK=yes

# SUMMARY-GS2 · 学校端 G 线第二轮 收官

日期 2026-10-06 ｜ 无人值守会话（rGS2-loop 自动启动）＋一趟续跑补验 ｜ 八包 GS2-00 ~ GS2-07 全做完
逐包回执见 `JOB-GS2-00.md … JOB-GS2-06.md`；演员表 `JOB-GS2-castlist.md`；截图在 `shots/GS2/`。

## 一句话（给业主）
把 GS-3 录制每一章要用到的画面，提前在数据库里都摆好了：第三所演示学校（演示大学三号）新建好并能一键切「刚注册 / 已通过」两态；演示大学（schX）升到标准等级、名额不再超额、有一条已批准的提额记录、两个任务改成好认的演示名；八名演示留学生把「审核中 / 可发录取 / 在途录取 / 已接受 / 已入学」五种状态，加「已暂停」「面试已确认」「待传通知书」「待传 JW202」「三种建档状态」全摆齐；六类通知每种至少一条。每种状态都写成「一条命令切到位」的脚本，整套能一键重建，连跑两遍结果完全一样。Resend 发信那一项因为没有 DNS 权限，按规矩跳过了。

## 续跑说明（这趟补了什么）
上一趟会话做完 GS2-04 后，**起了个后台截图任务就退出了**，收官单只写成 PENDING，而且 GS2-04 那几条「脚本自检 OK / rebuild 两遍一致 / 每状态一张截图」的闸判据**只写了没真跑**。这趟（第二趟）按 RULING-resume 把它们**真跑了一遍**，并修掉两个一跑就会露馅的脚本毛病：
1. 「回收演示生」脚本删学生前漏删了两张引用它的子表（操作日志、申请轮次），外键顶着删不动、整个回收回滚 → 原来是「假回收」。已补齐删除，修后实测：8 → 0 → 重建 8，真回收真重建。
2. 「整套重建」脚本探测演示大学三号账号在不在的写法有 bug，老是误判成「账号不存在」而跳过它的复位。已改好，修后能正确复位。
3. 第 10 章那张「面试已通过·可发 offer」截图一直拍不到（页面误显「请先安排面试」），病根是脚本没等云端数据读完就截图 → 已改成先等读完，截图正确。
以上只改本轮自己写的脚本和截图程序，**没碰五端代码、没碰数据库结构**。三条闸判据现在都是真跑真过（见 JOB-GS2-04.md「续跑补验」节）。

## 1. 演示校三所现状
| 账号 | 校名 / 编号 | 等级 | 名额 | 建档 | 任务 | 用途 |
|---|---|---|---|---|---|---|
| schX | 演示大学 / SCH-1AD6C8 | 标准 | 配额 30 / 已发 13（含 5 名演示生）/ 剩 17 | 17gz·出通知书前 | 8（ADM-100005 奖学金＝五档池、ADM-100003 自费、ADM-100004 面试制） | 第 2~13 章主场 |
| guide_sch2 | 演示大学二号 / SCH-8E561C | 标准 | — | 不建档 | 2 | 邮箱门已开；第 3 章建第 3 任务弹审核；S3 在途 offer 来源 |
| guide_sch3 | 演示大学三号 / SCH-5CBD28 | fresh 无 / approved 标准 | — | — | 0 | 第 1 章新校全流程；可一键切 fresh / approved |

## 2. 演示生八人状态表
| 代号 | 申请编号 | 国籍 | 专业 | 资助 | 状态 |
|---|---|---|---|---|---|
| S1 | （每次 rebuild 刷新） | 巴基斯坦 | Computer Science | 奖学金 | 审核中 + 演示面试被拒 |
| S2 | — | 孟加拉国 | Software Engineering | 自费 | 可发录取（材料齐全双审） |
| S3 | — | 尼日利亚 | Artificial Intelligence | 奖学金 | 已有在途录取（二号校） |
| S4 | — | 埃及 | Computer Science | 自费 | 已接受·待传通知书 / 建档待补充 |
| S5 | — | 印尼 | Data Science | 奖学金 | 已入学 / 建档学校已通过(DEMO-2027-0001) |
| S6 | — | 越南 | Computer Science | 自费 | 已暂停·材料待复核 |
| S7 | — | 俄罗斯 | Software Engineering | 奖学金 | 已付款·待传 JW202 / 建档已导出 |
| S8 | — | 哈萨克斯坦 | Computer Science | 自费 | 面试已安排并确认 →（ch10）面试通过待发 offer |
（内部 id / 申请编号每次 rebuild 刷新，属正常；录制前以当时真值为准，具体编号见 castlist 当次示例。）
五档人数实测：审核中 1 / 可发录取 1 / 在途录取 2（S3+S8）/ 已接受 2（S4+S7）/ 已入学 1 / 已暂停 1。

## 3. 状态脚本清单与用法（一行一个）
- `bash jobs/JOB-GS2/rebuild-school.sh` — 回收演示生 → 整套重建到 st-base（两遍一致）。
- `bash jobs/JOB-GS2/states/st-base.sh` — 切到 GS2-03 完成态（八人五档）。
- `bash jobs/JOB-GS2/states/st-ch10-ready.sh` — S8 面试通过·未发 offer·schX 建档清空（演示首次发 offer 建档闸）。
- `bash jobs/JOB-GS2/states/st-ch11-accepted.sh` — S4 已接受·通知书未传。
- `bash jobs/JOB-GS2/states/st-ch12-paid.sh` — S7 已付款·JW202 未传。
- `bash jobs/JOB-GS2/states/st-ch12-enrolled.sh` — S5 已入学。
- `bash jobs/JOB-GS2/states/st-sch3-fresh.sh` — guide_sch3 回到未完善资料。
- `bash jobs/JOB-GS2/states/st-sch3-approved.sh` — guide_sch3 已审核通过·标准·0 任务。
（ch10 会清空 schX 建档方式，录完该章跑 st-base 或 rebuild 恢复 17gz。）

## 4. 截图清单（shots/GS2/，横版，非 guide 学生不入镜/打码）
01-schX-home-quota / 02a-task-scholarship / 02b-task-selffunded / 02-schX-tasklist / 03-schX-quota-approved / 04-guide_sch2-home / 05-sch3-approved-home / 06-sch3-fresh-onboarding / 07-pool-5stages / 08-S2-materials / 09-S8-interview / 10-S4-letter-pending / 11-S5-enrolled / 12-S7-jw202-pending / 13-S3-pending-offer / 14-notifications / 15-settings-filing / **16-ch10-S8-interview-passed（本趟补拍）**。

## 5. Resend 域名结果
**跳过**（precheck `DNS=no`）：Cloudflare 令牌无 DNS 编辑权限，无法只加不改地写入 Resend 要求的 DNS 记录。Resend 钥匙本身已配（`RESEND_KEY=yes`）。自助领码入口仍按设计降级显示「正在配置中」，不崩。详见 JOB-GS2-06.md。本包按规矩不算失败。

## 6. 给业主的肉眼事
1. 手机登学校端（演示大学 schX，账号在 ~/mh-verify/accounts.json 的 accounts.schX），进「计算机硕士招生（奖学金）」任务 → 候选池能看到五种颜色的状态 + 一名「已暂停」。
2. 二号校（guide_sch2）现在登进去直接是工作台，不再卡邮箱验证门。
3. 第三所校（guide_sch3）第一次登录看到的是「完善学校资料」表单（第 1 章用）。

## 7. 遗留
- Resend 自助领码待 DNS 权限到位后另起一卡完成（GS2-06 跳过项）。
- 「录取文件」里通知书 / JW202 为状态占位（未上传真 PDF）；若录制要点开预览真 PDF，需补传 SPECIMEN 文件到 offer-letters 桶。
- 演示生材料的「学校端评审」留作录制时现场点（当前显示待审核，属正常）。
- ch10 截图脚本按当次 S8 真 id 硬传（schX 因双盲 RLS 读不到学生 id）；录制前若重建过，需以当时 S8 真 id 重拍或现场操作。

## 8. 第 GS-3 录制前要定的事
- 录制脚本（分镜）正本若定稿，按 castlist 对齐每章账号 / 学生 / 状态脚本 / 截图。
- 非 guide 测试学生在候选池 / 浏览页的画面层改名（打码或改演示名）是 GS-3 的事，本轮未做。
- 竖版 → 横版录制参数见 SUMMARY-GS0 §5。

全轮红线零触发；数据库仅新增 / 改演示对象，删除只限本轮自建演示生；未改五端代码、未建迁移、未部署云函数、未动 Cloudflare / DNS / Resend。
