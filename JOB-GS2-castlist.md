# JOB-GS2-castlist · GS-3 分镜定稿用「每章 用谁 / 什么状态 / 哪张截图」

日期 2026-10-06 ｜ 演示校三所 + 演示生八名 ｜ 不含任何密码/邮箱/电话（账号密码在 ~/mh-verify/accounts.json）

## 演示校
| 账号 | 校名 / 编号 | 用途 | 状态脚本 |
|---|---|---|---|
| guide_sch3 | 演示大学三号 / Demo University 3 · SCH-5CBD28 | 第1章新校首登/完善资料/审核中/已通过；第3章从零建任务 | st-sch3-fresh / st-sch3-approved |
| schX | 演示大学 / Demo University · SCH-1AD6C8 | 第2~13章主场（名额30/已发/候选池/发offer/通知书/JW202/建档） | st-base + 各 st-ch* |
| guide_sch2 | 演示大学二号 / Demo University 2 · SCH-8E561C | 第3章「恰好2任务→建第3个触发审核弹窗」；S3 的在途 offer 来源 | （GS2-01 已修整，无需脚本） |

## 演示生八名（申请编号 / 国籍 / 专业 / 资助 / 状态）
| 代号 | 申请编号 | 国籍 | 专业 | 资助 | 录制状态 |
|---|---|---|---|---|---|
| S1 | MH-W97MPX | 巴基斯坦 | Computer Science | 奖学金 | 审核中（+ 演示「面试被拒」） |
| S2 | MH-95MAG6 | 孟加拉国 | Software Engineering | 自费 | 可发录取（材料齐全双审） |
| S3 | MH-96S5RY | 尼日利亚 | Artificial Intelligence | 奖学金 | 已有在途录取（二号校） |
| S4 | MH-PGV9GN | 埃及 | Computer Science | 自费 | 已接受·待传通知书 / 建档待补充 |
| S5 | MH-TGPDPH | 印尼 | Data Science | 奖学金 | 已入学 / 建档学校已通过(DEMO-2027-0001) |
| S6 | MH-6TA7M7 | 越南 | Computer Science | 自费 | 已暂停·材料待复核 |
| S7 | MH-7Q29G9 | 俄罗斯 | Software Engineering | 奖学金 | 已付款·待传 JW202 / 建档已导出 |
| S8 | MH-PDXAGA | 哈萨克斯坦 | Computer Science | 自费 | 面试已安排并确认 →（ch10）面试通过待发offer |
（申请编号/内部 id 每次 rebuild 会刷新；此表为某次构建示例，录制前以当时真值为准。）

## 每章对照
| 章 | 用哪个账号 | 用哪个学生 | 状态脚本 | 对应截图 |
|---|---|---|---|---|
| 1 新校首登/完善资料/审核中/已通过 | guide_sch3 | — | st-sch3-fresh → st-sch3-approved | 06-sch3-fresh-onboarding / 05-sch3-approved-home |
| 2 健康工作台(名额不超额) | schX | — | st-base | 01-schX-home-quota（剩余22/配额30，不红） |
| 3 正常建任务 + 第3任务审核弹窗 + 奖学金包任务 | guide_sch3(0任务建新) + guide_sch2(恰2任务建第3) + schX(奖学金包) | — | st-sch3-approved / st-base | 02a-task-scholarship / 02-schX-tasklist |
| 4 标准20/已发/剩≥10/已批准提额 | schX | — | st-base | 03-schX-quota-approved（+10 已批准带批注） |
| 5 匹配出结果(自费/奖学金各有) | schX | 全体 | st-base | 07-pool-5stages（可一键匹配） |
| 6 筛选出结果 | schX | 全体 | st-base | 07-pool-5stages |
| 7 同一池五档各≥1 + 已暂停 | schX | S1~S6 | st-base | 07-pool-5stages（五色+暂停） |
| 8 材料齐全、双审结论可见 | schX | S2 | st-base | 08-S2-materials |
| 9 已安排并确认面试 | schX | S8 | st-base | 09-S8-interview（学生已确认参加） |
| 10 可发offer + 首次发offer建档闸 | schX | S8 | st-ch10-ready（面试通过·未发offer·建档清空） | 16-ch10-S8-interview-passed |
| 11 已接受·待传通知书 | schX | S4 | st-ch11-accepted | 10-S4-letter-pending |
| 12 已付款待传JW202 + 已入学 | schX | S7（待JW202）+ S5（已入学） | st-ch12-paid / st-ch12-enrolled | 12-S7-jw202-pending / 11-S5-enrolled |
| 13 设置页录取办理方式 + offer卡建档状态行 | schX | S4/S7/S5 | st-base | 15-settings-filing + 10/12/11（建档待补充/已导出/学校已通过） |
| 14 六类通知各≥1 + 操作记录 | schX | — | st-base | 14-notifications |

## 录制前复位小抄
- 整套复位到 st-base：`bash jobs/JOB-GS2/rebuild-school.sh`（回收演示生→重建；两遍结果一致）。
- 单章复位：第10章 `st-ch10-ready.sh`、第11章 `st-ch11-accepted.sh`、第12章 `st-ch12-paid.sh` / `st-ch12-enrolled.sh`、第1章 `st-sch3-fresh.sh` / `st-sch3-approved.sh`。
- 注意：ch10 会把 schX 建档方式清空（演示发offer建档闸），录完该章后跑 `st-base.sh` 或 `rebuild-school.sh` 恢复建档=17gz。
