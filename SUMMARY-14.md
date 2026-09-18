# SUMMARY-14 · 第十四轮收官（流量止血 + 打开提速 + 视频播放 + 放大缩小 + 瘦身收尾）

生成于 2026-09-19 · CC 自主执行 8 包（14-00～14-07）全部完成 · 主仓库未推、两只云函数未部署、重灌开关未翻

## 🔴 头号结论（流量账单谁烧的）
**主凶 = precheck-ai 每 5 分钟重下「出错的大文件」**（14-00 源码实证）：它先整份下载原件、再检查体积（顺序反了），且凡上一轮出错的 doc 每一跳都重新下载、永不封顶——单张 6MB 坏图 × 288 次/天 ≈ 1.7 GB/天，正好对上业主看到的「每天 1.5 GB」。**14-01 已堵死这个循环**（下载前先看体积 >3000KB 直接判 error 永不重试；出错件重试封顶 3 次），部署 precheck-ai 后账单即止。

## 五端版本 + md5（命令：md5 -q）
| 端 | 版本 | md5 | 本轮改动 |
|---|---|---|---|
| admin | v211 | 30b6e79d8ca22f4ecf07a40e345025b8 | 14-04 放大缩小 + 失败件原因扩充 |
| student | v393 | d3f266183cb86e854bbc316172dfb579 | 14-05 瘦身常驻行 + Q1 误报修复 |
| partner | v159 | 1fd5d1ae424510b968199b35223fbfec | 14-05 同上 + 邀请无邮箱态 |
| school | v232 | 26bf7160eb07c83bf53e0b37065084c3 | 14-04 放大缩小 |
| reviewer | v37 | c32bbcb96e027c7780d818191900f7c8 | 14-01止血/14-02预取并行/14-03视频/14-04放大 |

新增共享件：`assets/mh-viewer-v1.js`（放大缩小组件，6059 字节）。

## 迁移清单
| 编号 | 内容 | 状态 |
|---|---|---|
| 0203 | 止血: 索引加 render_v/状态 unsupported·too_large + 重写 backfill(下载前 SQL 过滤) + 队列带 wm_status + 失败件 RPC 扩充 | **已应用**（db-run.sh）|
| 0204 | reviewer_access_log.outcome 加 served_video_signed | **业主跑**（需重建 CHECK 约束、被 db-run.sh 红线挡，SQL Editor 手贴）|
- 账本两目录已 cp 一致（`bash jobs/ledger-check.sh` 差集为空）。
- 重灌开关 SQL `jobs/JOB-14-04/rerender-flag.sql`/`rerender-off.sql`（CC 交付未执行）。

## 云函数（两只都改源码、都未部署）
- **watermark-doc v31→v32**，md5 `8c98e64c398e982b84ae7917244e325b`：①下载前读索引拦已判死件（止血）；②prepare 下载前扩展名/体积闸；③signed_video 视频签名模式；④图片渲染 1600/75→2200/82 + render_v=2。
- **precheck-ai v19→v20**，md5 `da52fad0b760a250c81f36ec8c657416`：下载前看体积 >3000KB 直接 error 永不重试 + 出错件重试封顶 3 次。部署脚本 `jobs/JOB-14-01/deploy-precheck.sh`（带 `--no-verify-jwt`）。

## 每包一句话
- **14-00**：流量根因坐实 = precheck-ai 重下坏大图（288 次/天）；82KB 瘦身件核为「合理」；precheck-ai 关 JWT 自校验 key。
- **14-01**：0203 应用后跑 backfill **发 0 条请求**——2 张 6MB 图→too_large、6 个 docx/mp4→unsupported、2 份坏 PDF→gave_up，全零下载；两只 EF 改源码未部署；reviewer v37 打不开卡直显+退回（GATE3-PASS）。
- **14-02**：预取并行 3 路（峰值 3、169ms<串行半、刷新 0 重复、点在途件复用）（GATE3-PASS）。
- **14-03**：视频签名播放（EF signed_video + reviewer 播放器 controlsList=nodownload + 软水印）（GATE3-PASS）。
- **14-04**：放大缩小组件（6059B）装审核/学校/管理三端图片预览 + EF 图片升 2200/82 + 重灌 SQL 交付（GATE3-PASS）。
- **14-05**：瘦身结果常驻行 + Q1 页数三级来源（pdf-lib 输出不再误报）+ 中介邀请无邮箱态（GATE3-PASS）。
- **14-06**：存量大图压缩工具（30MP→2600/520KB selftest 过；候选 5 张 jpg>1500KB、2 张 png 不动；CC 未跑 apply）。
- **14-07**：收官——五端/迁移/EF 清点、ledger 差集为空。

## 业主验收表（部署 + 推送 + 恢复服务后回填）
| # | 验收项 | 结果 |
|---|---|---|
| 1 | 审核端 v37 翻材料点开即显（并行预取）；坏件卡直显「打不开·原因」+「退回·让学生重传」，点看不转圈 | ☐ |
| 2 | 审核端 v37 打开一份 mp4 自我介绍 → 在线播放、带禁下载 + 软水印（审核员编号+时间） | ☐ |
| 3 | 审核端 v37 打不开的材料（Word/大图/坏PDF）一键退回学生重传 | ☐ |
| 4 | 三端（审核/学校/管理）打开图片材料 → 右上角 ＋－1:1⤢ 工具条，滚轮/双指放大看清成绩单数字 | ☐ |
| 5 | 部署新 EF 后新水印件为 2200/82（放大不糊）；跑 rerender-flag.sql 可把旧件也重灌清晰 | ☐ |
| 6 | 学生/中介端传 >600KB 多页 PDF → 文件卡下常驻「已瘦身 X→Y·N页」，不再弹「could not be read」黄框 | ☐ |

## 业主待办顺序（建议）
1. **恢复 Supabase 服务**（升级/去 spend cap，解 402——第十三轮遗留）。
2. **部署 precheck-ai**（`jobs/JOB-14-01/deploy-precheck.sh` 或控制台，关 Verify JWT）→ **账单主凶即止**。
3. SQL Editor 跑 `0204_outcome_video_signed.sql`，再**部署 watermark-doc v32**（md5 8c98e64c…）。
4. 原生终端挂代理**推主仓库**（本轮 7 笔 c241aac→fa8ee16）。
5. 跑 `jobs/JOB-14-06/run.sh --list` → `--apply` 压 5 张大图。
6. 流量稳定后跑 `jobs/JOB-14-04/rerender-flag.sql` 重灌旧版水印件到 2200/82，重灌完 `rerender-off.sql` 关掉。
7. 逐项做验收表。

## 本轮提交（git log afdabc2..HEAD）
```
fa8ee16 JOB-14-06 存量大图压缩工具
1b30d24 JOB-14-05 瘦身常驻行+Q1误报修复+邀请无邮箱态
c251791 JOB-14-04 放大缩小组件+三端+EF 2200/82+重灌SQL
296a2c9 JOB-14-03 视频签名播放
6da51dd JOB-14-02 预取并行3路
9b09e86 JOB-14-01 止血: 0203+两EF+reviewer v37打不开卡
c241aac JOB-14-00 流量根因探针
```

---

## 第十五轮建议包（按本轮发现，Claude 拍板）

**包 A · 恢复服务后收尾（最高优先）**
业主解 402 后，CC 复核：部署两只 EF 是否生效（precheck-ai 不再重下大图、watermark-doc 拦坏件 + 视频签名 + 2200/82）；跑 14-06 --apply 压 5 张大图后复测审核端打开时延；跑 14-04 rerender-flag 重灌旧版水印件并核对 render_v=2。

**包 B · 账单复测 + 监控告警**
部署 precheck-ai 后连续观察 cached egress 是否从 1.5GB/天降回正常；给 net._http_response / cron 用量加一个每日巡检探针（超阈值提醒），避免再次被限流。**这是本轮止血的验证闭环，建议列头号。**

**包 C · send-invite-email 部署（第十三轮 C 沿用）**
0192 起邀请邮件扇出触发器一直在但 send-invite-email 从未部署——至今没有一封邀请邮件真送达。部署 + 用 14-05 的无邮箱/有邮箱两态端到端验一次。

**包 D · reviewer「我的操作历史」上云（第十三轮 D 沿用）**
现为 localStorage，换机/换浏览器即丢、无法与 reviewer_access_log 对账。建表或改读 reviewer_access_log。

**包 E · png/webp 大图压缩**
14-06 只压 jpg；库里还有 2 张 >1500KB 的 png（IMG_8353/8354）未动。扩展工具支持 png/webp（压缩或转 jpg），或在上传线也拦 png/webp。

**包 F · MHViewer 铺到学生/中介端预览 + 视频强水印评估**
本轮放大缩小只装了审核/学校/管理三端（学生/中介预览是边界未动）；可评估铺到学生/中介端。视频软水印是前端叠加可绕过，若合规要求强水印需服务端转码烧录（成本高，先评估再定 YAGNI）。
