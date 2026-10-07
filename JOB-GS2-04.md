# JOB-GS2-04 回执 · 录制状态脚本 + 整套重建

日期 2026-10-06 ｜ 无人值守会话

## 一句话
把录制每一章要用的数据状态都写成了「一条命令就能切到位、跑完会自己打勾 OK」的脚本；再写了一个「整套重建」脚本，能把本轮造的演示生全部回收后一键重建回标准态。重建连跑两遍，关键数字完全一样。

## 状态脚本（都在 jobs/JOB-GS2/states/，跑完自检打印 OK/FAIL）
| 脚本 | 切到什么状态 | 自检 |
|---|---|---|
| `st-base.sh` | GS2-03 完成态：两校修整 + 8 演示生五档齐全 | 八人阶段全对 + 建档17gz + 标准等级 → BASE_OK |
| `st-ch10-ready.sh` | S8 面试通过、未发 offer、schX 建档方式清空（演示「首次发offer建档闸」） | 面试通过=真 / 未发offer=真 / 建档已清空=真 |
| `st-ch11-accepted.sh` | S4 已接受、通知书未传 | 已接受 + 通知书未传 |
| `st-ch12-paid.sh` | S7 已付款、JW202 未传 | 已付款 + JW202未传 |
| `st-ch12-enrolled.sh` | S5 已入学（通知书+付款+JW202+报到全） | 已报到 + JW202已传 |
| `st-sch3-fresh.sh` | guide_sch3 回到「已注册·未完善资料」 | onboarding + 资料未完成 + 0任务 |
| `st-sch3-approved.sh` | guide_sch3「已审核通过·标准·0任务」 | active + 标准 + 0任务 |

每个脚本都幂等：可反复跑、能把被某次录制「演过头」的状态（比如已经上传了通知书）撤回到录制起点。

## 整套重建 `rebuild-school.sh`
- 步骤：①回收本轮自建的 8 名演示生及其全部衍生数据（offer/建档/候选/材料/审核）——**只删 guide_sch_* 演示生，绝不碰三所演示校本身、也不碰任何别的学生**；②重跑两校修整（幂等）；③重建 8 演示生各档状态（= st-base）；④guide_sch3 复位到 fresh（账号在就重置，不在就提示去注册）。
- **两遍一致实测**：rebuild → st-base → 各 st-* → 再 rebuild，两遍都 BASE_OK；关键计数相同：演示生 8、schX 发给演示生的 offer 6、候选池(计算机硕士)7、schX 建档=17gz、等级=标准、名额加成=10。
- 说明：重建后每名演示生的内部 id 和申请编号会刷新（和 G-0 一样，属正常）。

## 截图（shots/GS2/，每状态一张）
- st-base → `07-pool-5stages`（候选池五档）
- st-ch10-ready → `16-ch10-S8-interview-passed`（S8 面试已通过·可发offer）
- st-ch11-accepted → `10-S4-letter-pending`
- st-ch12-paid → `12-S7-jw202-pending`
- st-ch12-enrolled → `11-S5-enrolled`
- st-sch3-fresh → `06-sch3-fresh-onboarding`
- st-sch3-approved → `05-sch3-approved-home`

## 闸判据对账
- 7 个状态脚本各自检 OK ✅
- rebuild 两遍一致（关键计数相同）✅
- 每个状态有截图 ✅（5 个沿用 GS2-02/03 截图 + ch10 新增一张）

## 边界
脚本只碰 §0.1 范围（两所演示校 + guide_sch3 + guide_sch_* 演示生）；删除只限本轮自建演示生；无迁移、无云函数、未改五端代码。
