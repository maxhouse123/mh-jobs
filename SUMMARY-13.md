# SUMMARY-13 · 第十三轮收官（水印缓存收口 + 大材料瘦身 + 失败件处置 + 审计核对 + backlog 收口）

生成于 2026-09-18 · CC 自主执行 9 包（13-00～13-08）全部完成 · 主仓库未推（待业主原生终端挂代理推）

## 🔴 头号发现（业主最优先）
项目自 **2026-09-17 22:50(UTC) 起被 Supabase 服务限制**：错误码 402，`exceed_cached_egress_quota`（免费额度里的 CDN 缓存流量本月超额，Supabase 把项目边缘服务掐了）。凡走网关/云函数/存储外发的调用现在都返回 402。**请先登录 Supabase 控制台 → Billing/Usage → 升级套餐或移除 spend cap 恢复服务**，否则本轮五项业主验收都做不了（材料访问、云函数、缓存重灌、邀请邮件全被掐）。

## 五端版本 + md5（命令：md5 -q）
| 端 | 版本 | md5 | 本轮是否改 |
|---|---|---|---|
| admin | v210 | 8159c9d60f6deae9774b1bce3c8157d1 | 改（13-02 水印缓存失败件区）|
| student | v392 | 7ad49fc113337dd48c0eeac0a8a8e380 | 改（13-04 上传 PDF 瘦身）|
| partner | v158 | 7f275b677ee5899057f74369318a3366 | 改（13-04 瘦身 + 13-07 重发邀请）|
| school | v231 | b4473f8906ff0a07735640209300677a | 未改 |
| reviewer | v36 | 35d3333de7be57ab17c4dd07019ce887 | 改（13-03 一键退回）|

共享件：`assets/mh-pdf-slim-v1.js`（新）、`assets/vendor/pdf-lib.min.js`（新，pdf-lib@1.17.1，md5 dec481b1abd5119d3fbbd2695bdaebb1）。

## 迁移清单
| 编号 | 内容 | 状态 |
|---|---|---|
| 0199 | reviewer_access_log.outcome CHECK（7 值）归档 | **仅入账本，未执行**（卡1083 已在 SQL Editor 应用）|
| 0200 | wm_cache_index 授权 + 存量回填 95 行 | **已应用**（db-run.sh）|
| 0201 | wm_cache 试3次放弃 + 失败件 RPC | **已应用** |
| 0202 | 命名邀请重发（列+触发器+RPC）| **已应用** |
- 账本两目录已合一（正本 supabase/migrations + 镜像 docs/supabase 文件，`bash jobs/ledger-check.sh` 差集为空）。

## 云函数（EF）
- `watermark-doc/index.ts`：**改了源码**（13-02：prepare 各失败分支 upsert 索引 status='failed'+错误文本，成功 status='cached'），**未部署**。新 md5 = `9c291689af6ea604274500bdb2466e7d`。
- send-invite-email：**未改**（0192 起就未部署，邀请邮件实际未送达——见第十四轮建议 F）。

## 每包一句话结果
- **13-00**：起点核对全过；探针查出待补 4 件（2 张 6MB 大 jpg=IMAGE_TOO_LARGE、坏 pdf=PDF_UNREADABLE，本就渲不出）+ 头号发现 402 限流。
- **13-01**：0200 应用——service_role 授权修好、索引从 0 补到 95 行；单件重灌因 402 未跑（脚本留盘）。
- **13-02**：0201 应用——4 件待补连打 4 次后全部 gave_up（待补清零，candidate=0）；EF 源码加 failed 标记（未部署）；admin v210 派单台「水印缓存失败件」区，双闸 GATE3-PASS。
- **13-03**：reviewer v36——打不开的材料（415/422/546）错误框下出「退回·让学生重传」，预填英文、走原 review_verdicts，401/403 不出按钮，GATE3-PASS。
- **13-04**：student v392 / partner v157——上传 PDF>600KB 自动瘦身（单页→JPG2600、多页→2200 重组≤70%采用，坏件 fail-open），pdf-lib 自托管，双闸 GATE3-PASS，主文件 gzip 增量 ≤1.2KB。
- **13-05**：存量瘦身工具（run.sh/slim-stock.mjs/slim.html/list.sql）只造+`--selftest` 过；清单 24 大 PDF + 1 个 3MB 孤儿对象（referenced=false）；--list/--apply 留业主跑。
- **13-06**：审计核对——served_cached_direct 近 24h 有 30 条真落地、约束归档、log_wm_view anon 禁用；「我的操作历史」是 localStorage 非 DB（P2 点名）。
- **13-07**：账本合一（差集 0）+ 0202 重发（ok/too_soon/count=1 已证，扇出触发 402）+ partner v158「重发邀请」GATE3-PASS。
- **13-08**：本收官——五端/迁移/EF 清点、ledger 差集为空、SUMMARY 归档。

## 业主验收表（恢复服务 + 推送 + 部署 EF 后回填）
| # | 验收项 | 结果 |
|---|---|---|
| 1 | admin v210 → 派单台 →「水印缓存失败件」列出 N 件带原因 | ☐ |
| 2 | reviewer v36 打开一份打不开的材料 → 出「退回·让学生重传」→ 点 → 理由已填 → 确认 → 该材料从队列消失 | ☐ |
| 3 | student v392 传 >600KB PDF → 出「已瘦身 X→Y」提示，控制台有 `[v392] pdf slimmed` | ☐ |
| 4 | 存量瘦身：卡1092 `run.sh --list` 看清单、卡1093 `run.sh --apply` 执行（需备份卷已挂载）| ☐ |
| 5 | partner v158 待接受邀请卡有「重发邀请」，点后 maxhouseapp+invitetest 邮箱再收到一封 | ☐ |

## 业主待办顺序（建议）
1. **恢复 Supabase 服务**（升级 / 去 spend cap，解 402）。
2. 原生终端挂代理 **推主仓库**（本轮 8 个包提交 aa5d7f8→afdabc2，见下）。
3. **部署 watermark-doc EF**（新 md5 9c291689…）。
4. 跑存量瘦身（`run.sh --list` → `--apply`）。
5. 逐项做上面验收表。

## 本轮提交（git log c6c2081..HEAD）
```
afdabc2 JOB-13-07 账本合一+0202邀请重发+partner v158
ee55ef7 JOB-13-06 0199约束归档+audit-check只读5项
fad28b1 JOB-13-05 存量PDF瘦身工具(只造+selftest)
61a55a8 JOB-13-04 上传PDF瘦身 student v392/partner v157
8f8a1cc JOB-13-03 reviewer v36 文件问题一键退回
3068aec JOB-13-02 迁移0201+watermark-doc failed标记+admin v210失败件区
1b956e1 JOB-13-01 迁移0200 wm_cache_index授权+回填95行
aa5d7f8 JOB-13-00 开工检查探针
（667e35c = 上轮 12-06 收尾，业主已推）
```

---

## 第十四轮建议包（按本轮发现，Claude 拍板）

**包 A · 恢复服务后收尾（最高优先，依赖业主先解 402）**
业主升级/去 spend cap 后，CC：① 跑 13-01c 单件重灌证明缓存能回；② 部署 watermark-doc EF 后触发 `wm_cache_backfill` 让失败件带真实 500 原因；③ 跑 13-05 存量瘦身 --apply（业主执行、CC 复核 apply.log）；④ 复测 reviewer 打开大 PDF 的时延，量化提速。

**包 B · 402 egress 根因治理**
查明「cached egress 超额」的流量来源——是不是水印缓存桶 wm-cache 的直读（0196）把每次查看都从 CDN 拉全量放大了出流量？给出「省流量」方案（缓存件更小 / 命中率 / TTL / 是否该关直读走签名 URL）+ 用量监控告警，避免再被限流。**这是本轮暴露的系统性风险，建议列为第十四轮头号。**

**包 C · send-invite-email 部署 + 邀请链路端到端打通**
0192 起邀请邮件扇出触发器一直在，但 send-invite-email 云函数**从未部署**（net.http_post 一路 404/402）——意味着**至今没有一封邀请邮件真正送达过**。部署它 + 用 0202 的重发按钮端到端验一次真收信。

**包 D · reviewer「我的操作历史」上云**
现为 localStorage（换机/换浏览器即丢，且无法与 reviewer_access_log 对账，见 13-06 ③）。建一张 reviewer_activity 表或直接把「我的操作历史」改读 reviewer_access_log，使操作留痕可审计、跨设备一致。

**包 E · 失败件主动通知**
wm_cache_index 里 gave_up 的件现在只在 admin 台被动可见（13-02）。加：gave_up 时通知 admin，并（可选）通过 reviewer v36 的退回把「文件本身坏」的件推回学生重传，形成闭环（重传后走 13-04 瘦身，多半就能渲染了）。

**包 F · 历史 backlog 清扫**
REJ-1（拒绝弹窗缺类别选择器，双端恒传 null）、admin LS 桥收敛、quota 视图 mock 云化、withdraw_referral 线上 400 复现定性、vendor/tesseract 39M 评估 LFS —— 挑 1-2 个收口。
