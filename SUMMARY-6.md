# 第六轮队列 · 总回执（2026-09-16）· 收官

> 大白话总账。**主仓库全程未推**——本轮 6 个本地提交等你验收后自己挂代理推；日志仓库 `~/mh-jobs` 已实时推送全部回执。九包里 **7 包全交付、2 包按硬规矩只探/设计、1 个子项按 P2 停工待授权**。全程守双盲、守红线、只加不删。

## 1. 九包结果

| 包 | 结果 | 一句话 |
|---|---|---|
| JOB-6-01 | ✅ 全闸过 | 测试数据标记：三表加 is_test + 回填 35/12/10（零删），两浏览函数加 `not is_test`（真校看不到测试生）；admin v203 三列表灰徽章 + 隐藏测试筹码默认开 + 抽屉标 |
| JOB-6-02 | ✅ 全闸过 | 派单台表格视图（方案乙）：卡片/表格切换（记忆）+ 一行一件表格 + 底部固定条一次派，复用现有派单 RPC；admin v204 |
| JOB-6-03 | ✅ 全闸过 | 开学季配置表：新表 intake_terms + 回填 3 学期 + list_intake_terms()；admin v205 系统设置分区 + 开学季页（列表/新增/启停/排序 四语各一格）|
| JOB-6-04 | ✅ 全闸过 | 三端意向入学学期改读配置表（有配置用配置/无则回落原生成器）；值 label_en 稳定存储、显示按当前语言四语；student v381 / partner v149 / school v230 |
| JOB-6-05 | ⚠️ 2/3 交付，item② 停工 | ①admin v206 学生列表加「来路」列 + 筛选；③partner v150 委托卡隐藏撤回按钮改显解释；**②分页 = 全端无既有分页组件可照抄 → 按铁律14 P2 停工待授权，未自造** |
| JOB-6-06 | ✅ 全闸过 | 学生中介 90 天冷却：submit_student_agent_application 两重载加冷却检查（revoked_at 90 天内 raise cooling_period:N）；student v382 前端四语「还剩 N 天」|
| JOB-6-07 | ✅ 只设计（硬规矩）| 水印预渲染缓存设计文档（派单触发 EF prepare 存私有桶 wm-cache，查看先试桶失败回落 EF，2.7-3.7s→1-2s）；不动代码 |
| JOB-6-08 | ✅ 只探（硬规矩）| 邮件基础设施：Resend + notifications AFTER INSERT 触发器打 notify-email；notify_templates 10 模板四语齐但**无邀请模板**；发陌生邮箱需新 EF + 新触发器 + 模板；不动代码 |
| JOB-6-09 | ✅ 完成 | 收拾根目录：78 个 patch_*.py **mv 进归档夹**（非删），git status 零变化 |

## 2. 三条迁移的跑前跑后（队列说"四条", 实为三个含迁移的包）

| 迁移 | 内容 | 跑前 → 跑后 |
|---|---|---|
| **0188_is_test_flag** | 三表加 is_test + 回填 | students/schools/partners test 行 **0/0/0 → 35/12/10**（= 各表总行数，零删）|
| **0189_intake_terms** | 建表 + 回填学期 + list_intake_terms() | intake_terms **0 → 3 行**（Fall 2026/Spring 2027/Fall 2027，全启用）|
| **0190_student_agent_cooldown** | 两重载加 90 天冷却 | 两函数各含 cooling_period **0 → 1 次**；student_delegates 已结束委托 = 0 行（规则就位待用）|

均只增不删、单事务、走 db-run.sh、落盘 supabase/migrations/。

## 3. JOB-6-07 / 6-08 两份设计·探针要点
- **6-07（设计）**：水印慢在每次「查看」冷启 EF。方案=派单时后台按审核员渲染好存私有桶 `wm-cache/<reviewer>/<doc>`，审核端先试桶（签名 URL）失败再走 EF；迁移全新增型（建桶/策略/触发器）；**注意队列写的"迁移 0174"是笔误，已到 0190，施工取下一空号**。全文 `JOB-6-07-design.md`。
- **6-08（探针）**：邮件链路=Resend（no-reply@maxhouses.net）+ notifications 表 AFTER INSERT 触发器（pg_net 打 notify-email）；模板表 10 个四语齐但缺「命名邀请」；命名邀请发给**无账号的陌生邮箱**，现成两个 EF 都用不了 → 需**新 EF（照抄 send-verify-email）+ named_invites INSERT 触发器 + 邀请模板**，约 1 卡，EF 要你部署。

## 4. 五端最终版本 + md5

| 端 | 版本 | md5 | 本轮 |
|---|---|---|---|
| **管理端** | **v206** | `a04d3f4c96e0b316f935be855c518913` | 6-01/02/03/05 |
| **学生端** | **v382** | `6bac8c5e25b28d270bda0d9f16177586` | 6-04/06 |
| **中介端** | **v150** | `02335808871d5a1f1fed90f614152c8d` | 6-04/05 |
| **学校端** | **v230** | `ba16b9d333ce163225ff7fe3b686cbb2` | 6-04 |
| 审核端 | v31 | `78998c83d4616ff28668aa4b91018a99` | 仅只读探(6-07 设计) |

基底核对：起点 = pre-launch-20260916（admin v202/student v380/partner v148/school v229/reviewer v31，md5 全对上才开工）。

## 5. 本地待推提交（6 个，主仓库未推）
```
7ca7730 student v382    JOB-6-06 学生中介90天冷却
16c93b7 admin v206/partner v150  JOB-6-05 委托邀请二期(item①③)
54d993e student v381/partner v149/school v230  JOB-6-04 三端读开学季配置表
922bd68 admin v205      JOB-6-03 开学季配置表管理页
579242a admin v204      JOB-6-02 派单台表格视图
fc5c856 admin v203      JOB-6-01 测试数据标记
```
（6-07/6-08 无代码、6-09 零提交。）

## 6. 需要你的两件事
1. **JOB-6-05 item② 分页**：全端无既有分页组件可照抄，按 P2 停工——指一个可照抄的页面，或授权用现成按钮最小自建「上一页/下一页」。
2. **验收后挂代理推主仓库 6 个提交**；6-07/6-08 两份设计/探针看过再各开一施工包。

---
**第六轮全部收官（7 交付 + 2 探/设计 + 1 子项待授权），五端线上基线 admin v206 / student v382 / partner v150 / school v230 / reviewer v31。主仓库未推。**
