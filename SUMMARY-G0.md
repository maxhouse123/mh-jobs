PUSH_OK=yes

# SUMMARY-G0 · G 线第零轮（学生端操作说明视频·演示数据）收官单
日期 2026-10-05 ｜ 七包 G0-00～G0-06 全做完，六道包的判据**全过**（含业主裁决 R1 的第二份 offer 补件）。业主可推主仓库。

## 一、一句话总览
把拍"学生端操作说明视频"要用的**全套可重置演示数据**造好了，全部走线上真站真页面 + 真后台函数，没碰任何真实学生/学校/中介/审核员的数据，没改任何端口代码，没建迁移、没部署云函数、没调 AI 读材料、没发生真实扣款。一条命令就能把演示数据清空重建。

## 二、演示账号清单（打码邮箱；密码只在 ~/mh-verify/accounts.json，600 权限）
| 键名 | 打码邮箱 | 角色 | 当前状态 | 申请编号※ |
|---|---|---|---|---|
| guide_stuA | ***+guide-stua@*** | 境外学生 Lina Demo | 2 份 offer：#1 已确认(通知书+JW202 可开)、#2 待付 ¥1,500(带到期倒数)；6 份材料全批 | MH-X3SG5X |
| guide_stuB | ***+guide-stub@*** | 在华学生 Omar Demo | offer 已确认(两文件可开)；签证已批；补充信息表橙色卡在(未填)；所在地变更入口在 | MH-7W33H8 |
| guide_agent | ***+guide-agent@*** | 学生中介 Sam Demo Agent | 已批准为活跃中介、名下 2 名被荐生、名额余额 5、is_test | MH-ABSMBB |
| guide_agentFresh | ***+guide-agentfresh@*** | 待申请学生 Sam Demo | 已提交申请、**未**申请中介(Step5"成为合伙人"入口可见) | MH-K9DAG9 |
| （被荐生，无登录） | ***+guide-ref1@*** | Ravi Demo | 材料 3 份、成绩单被退回→"待补材料" | — |
| （被荐生，无登录） | ***+guide-ref2@*** | Nour Demo | 材料全批→offer→中介代接受→通知书→**停在待付款** | — |
| guide_sch2 | ***+guide-sch2@*** | 第二所演示校 Demo University 2 | is_test、active、建档=none（校代码 SCH-8E561C） | — |

- 测试学校 schX = `***+schx@***`（武汉大学 demo，is_test；账号在 accounts.schX）。顶层旧 schX（sc1 真校）业主已删，此后只认 accounts.schX。
- ※ **申请编号/各种 id 每次重建都会刷新**（回收按邮箱删、不按固定 id），上表是当前这次构建的值，仅供参考；密码不变。

## 三、流程 → 后台函数/表/桶 对照表
完整版见仓库 `jobs/JOB-G0/flow-rpc-map.md`（含每个流程调用的 RPC、写入的表、用的存储桶、带身份调用签名）。要点：
- 材料传 `student-documents` 桶；通知书+JW202 都在 `offer-letters` 桶。
- ¥0 解锁走优惠码 MAXHOUSE（百分百折，阶梯 [0,1500]：学生第 1 份 offer ¥0、第 2 份 ¥1,500）。
- 开学季可选 2027 春/秋；曝光档位 10/20/30 天。

## 四、每包用的哪条路（按 §0.2 优先级）
- **学生侧全程真站真页面**（Playwright 驱动 www.maxhouses.net）：注册、第2-4步、传材料、提交、接受 offer 这些"学生自己做的动作"都走真页面，脚本在 `jobs/JOB-G0/flows/`（register/login/student-apply/school-register/school-upload）。
- **学校/审核/管理/付款侧**：走"带身份调同一个后台函数"（`bash jobs/db-run.sh` 事务里按各账号 uid 调 RPC）+ 学校真会话传 PDF 到桶。材料审核结论因审核端本就是直接写表，故按 reviewer 身份直写 `review_verdicts`（审核端同款做法）。
- **被荐生材料**：用直写 documents 表 + reviewer 写结论造出"全批/一项退回"（仪表盘只看状态）；被荐生材料文件本身未上传到桶（见下 G-1 待补）。
- 每包回执（JOB-G0-00~05）里逐条写明了用的哪条路。

## 五、本机工具探针（给 G-1 录制 / 配音）
- **语音**：Samantha✅ Tingting✅ Milena✅ Thomas✅ Amélie✅(法语音，系统里带音标) ／ **Ava❌ 不在**（需换别的英文音，如 Samantha）。
- **ffmpeg / ffprobe：都没装 ❌**（G-1 录制/剪辑前要装：`brew install ffmpeg`）。
- **字体**：PingFang SC✅、Helvetica Neue✅。
- **Playwright**：已装 1.63.0，自带 Chrome 测试版在。

## 六、重建命令（一行）
```
cd /Volumes/Dev/MAXHOUSE && bash jobs/JOB-G0/rebuild.sh
```
（先挂代理 127.0.0.1:10808。幂等，可反复跑：回收演示数据→重跑全套流程。真跑验证过连跑两整轮都 EXIT=0。）

## 七、G-1 录制前要补 / 要知道的事
1. **装 ffmpeg**：`brew install ffmpeg`（录屏/合成要用，现未装）。
2. **英文配音别用 Ava**（本机没有），用 Samantha 或其它。
3. **"已录取(enrolled)"学生冷登录会落在第2步**：Lina/Omar 的 offer 走到"传完 JW202"就算正式录取，系统会关闭本轮、把提交时间移进轮次表，于是**重新登录时首屏是第2步（开新一轮），而不是录取仪表盘**。这是平台对"已录取学生开新申请"的真实行为，不是数据错——她们的 offer/材料/文件都在、在录取(Admissions)页/step5 正常显示。
   - 录"已确认+两文件可打开"的仪表盘画面时，用 flows 脚本把学生开到 step5（offers 真实在）；或**录到"付款解锁、通知书到手"这一刻**（此时还没传 JW202、本轮未关，冷登录就落在仪表盘）。两种状态都真实、都能录。agentFresh/agent（已提交、无已录取 offer）冷登录正常落在自己的工作台。
4. **被荐生的材料文件**：Ravi/Nour 的材料只造了"状态"（全批/退回），**文件实体没传到桶**（�console里仪表盘看的是状态）。若视频要点开被荐生的材料文件看，G-1 需用中介真会话把文件也传上（flows 已具备上传能力）。
5. **第二份 offer 用了第二所演示校 guide_sch2**（业主 R1=A 裁决）：这是平台"一个学生收到多所学校 offer"的真实形态；schX 一所校对一个学生只能发一份未拒 offer（数据库硬约束）。
6. **真邀请码**：学生注册用的是真站现有的学生渠道真码（单例、全局），本轮**没有新建码、没改全局配置**；回执里一律写"真码"不写码值（业主 R3）。

## 八、没做成 / 需留意
- 无"硬卡住"项；六包判据全过。
- 上面第 3、4 条是"按真实产品行为的说明 + G-1 待补的小事"，不影响演示数据正确性。
- `~/mh-verify/accounts.json` 新增键：guide_stuA/guide_stuB/guide_agent/guide_agentFresh/guide_sch2（密码只在此文件，未进任何回执/日志/仓库）。
