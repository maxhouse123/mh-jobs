PUSH_OK=yes

# SUMMARY-22 · 第二十二轮收官

> 主题：预加载规则收口（_headers）+ 中介端卡片进弹窗 + 缩略图续签 + 五端「有新版请刷新」提示 + 积压图纸。
> 全轮只修不加；不改共用查看器 / precheck-ai / admin-doc / watermark-doc；不写迁移；不部署；**未推主仓库**（收官推送由业主用卡1163 做）。
> PUSH_OK=yes 仅表示 CC 自己的闸（真页面红→绿 + N1–N7 + P3 + shell-lint + secret-scan）本轮全过；视觉件线上肉眼验收留业主。

## 一、本轮新版本 + md5（主仓库当前文件；均已 commit 未 push）
| 端/文件 | 版本 | md5 |
|---|---|---|
| partner | v170 | `afe53f4be41237a5c36eb880914e918e` |
| student | v400 | `19391aa80ac10cb7835ef50f989432b0` |
| school | v235 | `f77dcba686c3b5e6d0dd005c796b7435` |
| admin | v219 | `a472693c27426b0b1494c605d1072e3b` |
| reviewer | v46 | `2d4269e9c570481b99b95d70a3691082` |
| `_headers` | v5(JOB-22-01) | `527bdbef4ee289cff38fb16f09c6aa72` |

各端 index.html 重定向、[VER] 探针、头注、changelog 均同版（版本四件套齐；admin/reviewer index 为 3 处重定向、其余 4 处）。

## 二、每包一句话
- **22-00**：开工检查（九件 md5 全等基线 / HEAD / 四账号真登）+ 造探针 + 旧病先红（卡重叠三档红 / 缩略图 404 红 / _headers Link 子资源泄漏结构红 5 条）+ 五端旧版按钮清单（N1 基线）。
- **22-01**：`_headers` 只改 Link 块——删 `/<portal>/*` 的 Link（病根），改挂 `/<portal>/` + `/<portal>/maxhouse*portal*v*`；vendor/字体响应不再带 Link；缓存块零改、预加载载荷未删；结构红 5→0 绿。
- **22-02**：中介端 v170——①卡片进弹窗内顶部置顶容器（sticky·占位·重画不丢·关窗移回右下角），三档 1220/1280/1440 七项交集 3066/2436/756px²→0；②缩略图续签（>50min 批签 + onerror 单件重签一次 + SVG 占位）；③「有新版请刷新」横幅。
- **22-03**：学生端 v400（同套续签 + 横幅）+ 学校端 v235（学校端无持久缩略图签名·再核确认 → 仅横幅）。
- **22-04**：审核端 v46 + 管理端 v219（仅横幅；顶栏用 `.header,.topbar`；审核端 zh-only 回退 zh；CF Access 后取不到 index 静默）。
- **22-05**：走查脚本加两项——④ `_headers` Link 归属（网页有 Link·vendor/字体无 Link）+ ⑤ 控制台预加载告警；对现役线上跑出「改前红」（④ vendor 仍带 Link ×3，待业主推 22-01 后转绿）。
- **22-06**：收官 SUMMARY + 两份积压图纸（REJ-1 / 配额云化，见下「积压」）。

## 三、闸账（各包回执有全表）
- 真页面红→绿：22-02 partner1 全绿（卡进弹窗×3 / 重画不丢 / 续签 16-16 / 横幅四语+N7 不遮按钮 / 同版不出 / 取不到静默）；22-03 学生续签逻辑桩 + 同族已在 v170 真数据证绿 / 学生·学校横幅全绿；22-04 reviewer1 横幅全绿 + 管理端无头零报错+功能核。
- N1：五端升版**零 id/handler/function 移除**（新增均为本轮 `_v170*/_v400*/_mh*`）。
- N7：中介端卡片三档视口七项交集 0 + 横幅第 1/4 秒可见/紫底/不遮页头按钮。
- P3：`tests/job22-02-partner-v170.mjs`(27) + `job22-03-student-school.mjs`(35) + `job22-04-admin-reviewer.mjs`(30) = **92/92 全绿**。
- shell-lint 每包全绿；secret-scan 每包 CLEAN。

## 四、截图（`~/mh-jobs/shots/22/`，元素级·无 PII·收官统一推）
- `22-02/`：`A-card-in-modal-top-1280.png`（卡进弹窗顶部）、`D-version-banner-zh.png`
- `22-03/`：`STU-version-banner.png`、`SCH-version-banner.png`
- `22-04/`：`REV-version-banner.png`
- `walk/`：`schX-partner-login.png`（22-05 走查·样式打码）+ `INDEX.md`
- 各含 `INDEX.md`。

## 五、未放行清单（CC 未自行放行，留 Claude/业主定）
1. **审核端 700 字重删除**（22-01 图纸原前提「reviewer @font-face 只有 300–600」经亲读 reviewer v45 L170 **证伪**，且首屏 700 在用）：**未执行**，700 保留；预加载载荷一字未删。待业主/Claude 定是否删。
2. **`_headers` 22-01 未部署**（随主仓库推送生效）：现役线上 `vendor/supabase.js` 仍带 Link（22-05 ④ 已如实记红 ×3）；**业主收官推送后应转绿**。
3. **console「preloaded using link preload」告警**：本地/无头**不可稳定复现**（CF 边缘 Early Hints 时机依赖）；可靠判据 = 22-05 ④ 结构信号；线上真效果待**业主本人浏览器控制台肉眼核**（含 admin/reviewer 登录后）。
4. **视觉件线上肉眼验收**（铁律15）：中介端弹窗内顶部卡片、缩略图久开不断、五端横幅——CC 已本地 file/真页面验，线上一致性留业主看。

## 六、要业主亲眼看的（线上，收官推送后）
1. 中介端：详情弹窗开着时护照核对提醒出现在**弹窗内容顶部**、把下文顶下去，**不再压右下角**「提交/我已看到」控件。
2. 中介端/学生端：标签页**久开 1 小时后**重开详情，护照/学历/成绩单缩略图**仍在**（自动续签）。
3. 五端：线上版本一致时横幅**不出**；真出新版才出、点它才刷新、不遮页头按钮。
4. 五端控制台（推 22-01 后）：**不再有**黄色 `preloaded using link preload` 警告；响应头 Link 只出现在网页文档、`vendor/supabase.js` 不再带 Link。

## 七、积压图纸（22-06 交付，`jobs/JOB-22-06/`）
- `backlog-REJ-1.md`：**核后已实现**（student v229/partner v37，现役 v399 `_rejAsk`+真值 RPC 实证）→ 建议**摘除 backlog**。
- `backlog-quota-cloud.md`：请求/审批/账本**主链已云化**（admin v117/v191 + 迁移 0087/0138–0140），剩余仅「配额本体分配」窄口，**待主审按数据血缘三问精核**再定是否缩条/摘除。

## 八、第二十三轮建议包
1. **配额本体切云窄条**（若主审精核确认 allocated/等级/周期仍读本地）——低优先，见 backlog-quota-cloud §三。
2. **审核端 700 字重定案**（图纸冲突裁决）——一句话即可。
3. **横幅登录门(gate)阶段可见性**（可选优化）：现横幅在未登录 gate 页 body 未起来时零尺寸不显（久开登录页收不到新版提示）；业主 ④ 场景为登录态旧标签页、不受影响，故列低优先。
4. **拒因统计/管理端聚合视图**（可选，非 REJ-1 原范围）。
5. **历史观察项**（承 LEDGER-3）：vendor/tesseract 39M LFS 评估、withdraw_referral 线上 400 复现定性——非本轮范围，择期。

（本轮无 STOP：`~/mh-verify/r22-STOP.txt` 不存在。）
