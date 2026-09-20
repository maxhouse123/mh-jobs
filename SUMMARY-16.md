PUSH_OK=yes

# SUMMARY-16 · 第十六轮收官（只修不加：还第十五轮验收不过的 10 项旧账）

> 本轮换验法（§0.3 六道新闸 N1–N6 零例外），核心不是多写代码而是「真页面真点、先红后绿、带身份取证」。
> 10 包 16-00～16-09 全部完成。以下每包的回执在 `~/mh-jobs/JOB-16-0X.md`，公开截图在 `~/mh-jobs/shots/16/<包号>/`。

## 一、五端版本 + md5（现役 = 各 index.html 重定向指针，已逐个核对一致）

| 端 | 版本 | 文件 | md5 |
|---|---|---|---|
| admin | v215 | admin-portal/maxhouse-admin-portal-v215.html | baf5e020f619150955c82737e0803835 |
| student | v396 | student-portal/maxhouse_student_portal_v396.html | ad9c867f4fbdb81fa7241a8796f7d54d |
| partner | v163 | partner-portal/maxhouse-partner-portal-v163.html | 71cb40325850746dbb4df7ad2b785720 |
| school | v233 | school-portal/maxhouse-school-portal-v233.html | fb4e405288236c8ae553a031bc833137 |
| reviewer | v40 | reviewer-portal/maxhouse-reviewer-portal-v40.html | 97251499efcc44f3c2865cab146140de |

起点基线（SUMMARY-15）：admin v213 / student v394 / partner v160 / school v232 / reviewer v38。

## 二、迁移清单（正本 supabase/migrations + 镜像 docs/supabase 文件；`bash jobs/ledger-check.sh` = LEDGER OK 差集0）

| 编号 | 文件 | 内容 | 状态 |
|---|---|---|---|
| 0207 | 0207_soft_delete_revoke_filters.sql | 软删/撤销过滤：11 读者补 deleted_at，reviewer_doc_queue 另补 revoked_at | 已应用（16-03） |
| 0208 | 0208_doc_slim_status.sql | documents 加 slim_* 五列 + set_doc_slim(text) + student_bootstrap 带出五列 | 已应用（16-03） |
| 0209 | —（编号留空） | 用量预警正文——按裁决**不做**：0206 rollup 正文本已是 {zh/en} 人话 | 空号（16-07） |

## 三、两只云函数（源码改**未部署**；部署在业主卡1119）

| EF | 版本 | md5 | 部署状态 |
|---|---|---|---|
| precheck-ai | v22 | 1c4ce932208c0b63181d223c5ed4cf49 | 线上仍 v21；业主卡1119 用 jobs/JOB-16-06 部署脚本部署（`--no-verify-jwt`，本轮不改鉴权部署方式） |
| watermark-doc | v33 | 55debf4dcc841c8370d2b4280d9e8768 | 线上仍 v32；业主卡1119 用 jobs/JOB-16-08/deploy-watermark.sh 部署（JWT 校验保持开） |

## 四、每包一句话

- **16-00**：造工具（realpage.mjs / inv.mjs / secret-scan.mjs / acct-check.mjs）+ 带身份探针取六段病根 + 旧病复现（必须先红）+ 旧版按钮清单基线；除测试件外零写库。
- **16-00b**：抹除已跟踪文件 jobs/JOB-10-04/report.md 里 1 处旧测试密码明文（换占位符）。
- **16-01**：放大缩小重做（甲案）——MHViewer2（PDF 阅读器式工具条）装进 reviewer v39 / school v233 / admin v214；reviewer 真页面红→绿（checkViewer 28 过 chromium+webkit）。
- **16-02**：中介端 v161——`_dlLoadInvites` 裸变量 uid（ReferenceError 被静默吞）→ 用 `_dlState.uid`；partner1 真登 v160 显 0 → v161 显真实 10。
- **16-03**：迁移 0207（软删/撤销过滤）+ 0208（瘦身状态字段与写入函数）；带身份验证 reviewer1 队列 61→60 无 259、stuA bootstrap 17→15 无 mh10 死图。
- **16-04**：学生 v395 / 中介 v162——上传闸补原因框 + 被拒说人话 + 姓名核对改软提醒 + 坏件预览说人话。
- **16-05**：学生 v396 / 中介 v163——瘦身状态入库 + 从库读出来显示 + 前端回落查询补软删过滤。
- **16-06**：precheck-ai v22——有钥匙走定时路 / 有登录态走按需路 / 都没有才 401（本地矩阵 15 格 AS-EXPECTED）。
- **16-07**：admin v215——通知时间线不再红字（前端兜底 `_v215NotifText`）；迁移 0209 按裁决不做、编号留空。
- **16-08**：reviewer v40 + watermark-doc v33——已撤销/已软删件不进队列、云函数也拒（403/410）+ 文件图标按真实扩展名。
- **16-09**：收官——本 SUMMARY（含 PUSH_OK）+ 线上走查脚本（jobs/JOB-16-09/online-walk.sh + .mjs，本地干跑全绿）+ 收尾残留清点。

## 五、10 项旧账逐项 旧版红图 → 新版绿图

| # | 旧账（第十五轮验收不过） | 修在 | 红（旧版） | 绿（新版） |
|---|---|---|---|---|
| 1 | 放大缩小·审核端（点工具条没反应） | 16-01 | shots/16/16-01/reviewer-v38-OLD-red.png | shots/16/16-01/reviewer-v39-1..7-*.png（真鼠标 checkViewer 28 过） |
| 2 | 放大缩小·学校端 | 16-01 | shots/16/16-01/school-v232-OLD-red.png | shots/16/16-01/school-v233-1..7-*.png（**真页面开图待业主手验**） |
| 3 | 放大缩小·管理端（图片跑出取景框） | 16-01 | shots/16/16-01/admin-v213-OLD-red.png | shots/16/16-01/admin-v214-1..7-*.png（**真页面开图待业主手验**） |
| 4 | 中介端「已发邀请 0」（库里 10） | 16-02 | shots/16/16-02/partner-v160-invites-RED.png | shots/16/16-02/partner-v161-invites-GREEN.png |
| 5 | 中介端「邀请学生自传」按钮消失 | 16-02 | （15-04 倒退，v160 无按钮） | shots/16/16-02/partner-v161-button-located.png ＋ 线上走查③（干跑绿：可见+点得开） |
| 6 | 学生端上传闸裸报错（无原因框） | 16-04 | shots/16/16-04/student-v394-barefail-RED.png | shots/16/16-04/student-v395-reasonbox-GREEN.png |
| 7 | 学生端死图 mh10-test（软删件混入） | 16-03＋16-05 | N3 探针 stuA bootstrap 17（含 mh10） | 0207 后 bootstrap 15 无 mh10；线上走查② CV 无 mh10（干跑绿） |
| 8 | 学生端瘦身行不入库/不显示 | 16-05 | shots/16/16-05/student-v395-slim-none-RED.png | shots/16/16-05/student-v396-slim-fromDB-GREEN.png |
| 9 | 按需预检 POST 401（登录态路没验） | 16-06 | （v21 学生登录态路 401） | 本地矩阵 15 格 AS-EXPECTED；**线上绿灯在卡1119 走查②**（sent 1 got 1 + precheck-ai 200） |
| 10 | 管理端时间线正文丢/红字 | 16-07 | shots/16/16-07/timeline-214.png（纯字符串正文被丢） | shots/16/16-07/timeline-215.png（正文补回、0 报错） |
| 11 | 审核端撤销件仍在队列+云函数放行 | 16-08 | shots/16/16-08/queue-v39.png ＋ card-v39.png | shots/16/16-08/queue-v40.png ＋ card-v40.png（403/410 兜底） |
| 12 | 审核端图标按 doc_type 标错（Word 显 JPG） | 16-08 | shots/16/16-08/icon-v39.png | shots/16/16-08/icon-v40.png（按扩展名显 DOCX） |

（第十五轮 10 项旧账，本轮拆成上述 12 行逐条红→绿；放大缩小三端各一行、审核端撤销件与图标各一行。）

## 六、收尾残留清点（N3 带身份探针，`jobs/JOB-16-09/residue-probe.sql`）

- **学生A**（uid 43668ae4 回显）：名下 documents 活 15 行、软删 6 行；**本轮测试特征名（r16/mh10/synthetic/【测试】/slim-test）活着的 = 0**（已全软删）。
- **reviewer1**（uid 80c62372 回显）：`reviewer_doc_queue` 60 行；**259f456a present = false**；队列内本轮测试件 = 0。
- **partner1**（uid 1aad823a 回显）：`named_invites` 共 10 条（sent 6 / claimed 1 / opened 1 / expired 1 / revoked 1），**与开工一致**（本轮中介端只读不写邀请）。

## 七、未放行清单（已标记、不影响其它功能，故不阻断推送）

1. **16-01 放大缩小·学校端 v233 / 管理端 v214**：代码四件套 + N1 已核，reviewer 真页面已红→绿；school/admin **真页面开图待业主手验**（admin 无密码只能 stub / CF Access 后；school 有 schX 可真登）。
2. **16-05 中介端代传「提交落库」**：瘦身行渲染绿，但代传**提交落库**因 Q1/AI 多步闸在无头 harness 未跑通，DB 持久化**未复现，等业主手验**（wiring 与学生端全等，学生端 E2E 已 DB 验证绿）。
3. **16-07 admin 时间线「崩红」R4**：正文丢弃已修（红→绿），但业主口中的**整块崩红形状未复现**（库内近 30 天通知全是规整 {zh/en} 对象、代码对任何形状不 throw，16-00 两路已证）；按卡1126 标**未放行、等业主手验**。
4. **16-06 precheck-ai v22 / 16-08 watermark-doc v33**：源码改未部署；**线上绿灯在卡1119**（EF 部署脚本自带鉴权探针；学生端按需预检真发得出走线上走查②）。
5. **16-09 线上走查**：`jobs/JOB-16-09/online-walk.sh` 本地干跑（线上地址指本地服务）10 项全绿并写出草稿；**真红绿在业主卡1119 的 live 跑里出**（那一趟才做真上传/即判/刷新仍在/界面删除，并覆写 `~/mh-jobs/JOB-16-09-online.md` 后 commit+push）。
6. **业务提醒（非缺陷）**：业主那份约 894 KB 旧件，库里**没有瘦身记录**——瘦身状态是 16-05 起才随上传入库的，旧件要**重传一次**才会出现「已检查/已瘦身」那一行；不重传则文件卡不显示瘦身行（按设计不猜、不回填对不上出处的旧件）。

## 八、闸与工作树状态

- **N1 差集**：每一次升版 removed = 0（逐包回执有据），本轮只修不加、也不减。
- **secret-scan**：对主仓库待推提交与 `~/mh-jobs` 全树各跑一次 = **SECRET-SCAN-CLEAN**。
- **工作树**：`git status --porcelain --untracked-files=no` = 空（tracked 干净）；`bash jobs/ledger-check.sh` = LEDGER OK。
- **本地领先远端 6180893 的提交**（业主卡1118 推）：

```
e6a9562 JOB-16-08 审核端v39->v40 + watermark-doc v32->v33
6fdb4fd JOB-16-07 admin v214->v215 通知时间线不再红字
c367531 JOB-16-06 precheck-ai v21->v22 三条路径按凭据分流
b34d636 JOB-16-05 学生v396/中介v163 瘦身状态入库+从库读+回落补软删
8fe387f JOB-16-04 学生v395/中介v162 上传原因框+被拒说人话
427f3ec JOB-16-03 迁移0207+0208
9568aaa JOB-16-02 中介端v161 邀请数归零修复
62694a0 JOB-16-00b 抹除旧测试密码明文
df210a1 JOB-16-01 放大缩小重做(甲案)
```

（9 条，全为本轮 JOB-16-xx；主仓库 CC 不推，业主卡1118 认本行的 PUSH_OK=yes 后推。）

## 九、第十七轮建议包（顺延 SUMMARY-15 C–G + 本轮新发现）

- **包 A'（最高优先）· 部署+线上验证闭环**：业主推主仓库（卡1118）后，部署 precheck-ai v22 + watermark-doc v33（卡1119）并跑 `jobs/JOB-16-09/online-walk.sh`（去掉 MH_WALK_DRY）→ 学生端按需预检真发得出、审核端撤销/软删件真被拒、中介端邀请按钮线上真点得开；把 online 回执与 school/admin 放大缩小的手验一并收口本轮 6 条未放行。
- **包 C（顺延）· 用量巡检阈值调优 + 告警去抖**：0206 阈值是首版拍脑袋值，跑一两周按真实基线收紧；把水印现场渲染的 546 单列「渲染超限」不计入 5xx 告警。
- **包 D（顺延）· reviewer「我的操作历史」上云**：仍是 localStorage，换机即丢；可改读 reviewer_access_log（0206 已在用）。
- **包 E（顺延）· png/webp 大图**：库里 2 张 >1500KB png 未动，14-06 工具只压 jpg；扩展工具或上传线拦 png/webp。
- **包 F（顺延）· MHViewer2 铺到学生/中介端预览 + 视频强水印评估**：本轮放大只在审核/学校/管理三端，学生/中介预览仍未铺（本轮甲案 MHViewer2 已就绪，可直接复用）。
- **包 G（顺延）· 259f456a 复测路径固化**：把「测试件复测 = 重新派单」写进测试手册，避免撤销测试件再被当 bug（0207 后队列已不含撤销件，佐证正确）。
- **包 H（本轮新发现）· REJ-1 拒绝类别选择器**：legacy 清算 REJ-1——拒绝弹窗缺类别选择器，studentRejectCategory 读侧/键族/RPC 管道全在但调用点恒传 null；补一个类别选择器即可通链（不属本轮 10 项，未动）。
- **包 I（本轮新发现）· 「邀请学生自传」按钮的门控说明**：`#dlInviteBtn` 由 `_dlDecorateDom` 在 `_dlOn()`（平台+合伙人开关真）时插在 `.partner-add-student-btn` 旁——非缺陷，但线上走查须先滚到「我推荐的学生」区块并等 flags 落地才见按钮；已在 online-walk.mjs 里处理，供后续测试参考。
