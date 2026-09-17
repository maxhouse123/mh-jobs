# SUMMARY-11 · 第十一轮总账（2026-09-17）

> 大白话总账。本轮**不用手机**，主题=把水印预渲染缓存的**存量补齐**并收尾。EF 源码只在 11-02 缺审计处改了一次、**未部署**；主仓库**只 commit 不推**（业主推）；每包回执已 push ~/mh-jobs。暗号零外泄（只在数据库 catalog 流转，文件里只见占位符/公开公钥）。五端本地 md5 开工=收官，一字未动。

## 1. 逐包结果
| 包 | 结果 | 一句话 |
|---|---|---|
| 11-00 开工核对 | ✅ | 五端 md5 对齐、git clean、HEAD=origin/main（业主已推平第十轮）、mh-jobs 同步 |
| 11-01 水印缓存存量回填+cron（0195） | ✅ | 新增 `wm_cache_backfill` 函数（anon/authenticated 不可执行）+ 每 5 分钟 cron；暗号运行时读 catalog；实测在补（见下数字），cron 真自动跑 |
| 11-02 signed_url 审计核查 | ✅ 补源码·**未部署** | 命中缓存"秒下"这条路原本**不写审计**→已补 `logAccess(outcome=served_cached)`，只动这一分支；deno 未装做结构自检；部署卡见 JOB-11-02.md |
| 11-03 撤第十轮测试派单 | ✅ | 撤单 cd7389f7（不删行）→ 清理触发器 35s 内删桶对象（1→0），cleanup `200{cleaned}` |
| 11-04 收官 | ✅ | 本文件 |

## 2. 水印缓存桶对象数（前后）
| 时点 | 桶对象数 | 待补条数 |
|---|---|---|
| 开工 | 1 | 104 |
| 手动调 1 次 `wm_cache_backfill(20)` | 21 | 84 |
| cron 05:05 自动跑后 | 41 | 64 |
| cron 05:10 自动跑后 + 11-03 撤单删 1 | 60 | 44 |
> 趋势：每 5 分钟稳定补 20，约再过 ~11 分钟（2–3 个 cron 周期）补完到 0，之后基本空转。含真实学生派单的回填是本包目的（卡明确允许；wm-cache 桶私有、仅 service_role 可读，双盲不破）。

## 3. cron 证据
- `cron.job` 有 `wm-cache-backfill`，`*/5 * * * *`，active=t（唯一 1 条）。
- `cron.job_run_details`：已 2 次运行（05:05、05:10），status=succeeded。
- 权限：anon / authenticated / public 均**不可**执行 `wm_cache_backfill`（has_function_privilege=f）。

## 4. 待推提交清单（主仓库 origin/main..HEAD，**5 笔**，业主原生终端挂代理推）
```
（11-04 SUMMARY 提交后为 5 笔；逐笔以推前 git log 当场实测为准）
a14ea90 JOB-11-03 撤第十轮测试派单
f5e3f4e JOB-11-02 signed_url 缺审计→补源码(未部署)
8ce956f JOB-11-01 水印缓存存量回填+cron(0195)
77c56d2 JOB-11-00 开工核对
+ 本 SUMMARY-11 提交
```
推送四段式（铁律 P5）：①`git log origin/main..HEAD --oneline` ②`git push origin main` ③再看应空 ④`git status` clean。
> **本轮无线上前端改动**（五端 md5 未变）。会影响后端的：迁移 0195 **已在生产库应用**（回填函数+cron 已在跑，push 只是把归档 `supabase/migrations/0195_*` 入账本）；watermark-doc 的 signed_url 审计**改了源码但未部署**——线上缓存命中查看**暂仍无审计**，等业主用 11-02 的部署卡 `supabase functions deploy watermark-doc` 部署后才生效。

## 5. 两处事实修正（本轮起沿用，已并入操作）
- 正式域名 `www.maxhouses.net`（裸域 301→www，保留路径与 `?`）。
- 无 `doc_slot_batches` 表；「第3批填理由」是 DB 规则 `reason_required_unreviewed`（P0001）。`get_my_offers`/`get_my_rounds` 要带 `{uid}`。

## 6. Backlog（交业主）
1. **watermark-doc 待部署**：11-02 的 signed_url 审计补丁在源码里、未部署；部署卡见 JOB-11-02.md。部署后线上缓存命中查看才有审计。
2. **storage 3MB 孤儿对象**：`student-documents/43668ae4…/bank/1789571102495_4vtz_mh8-test-3mb.jpg`（第八轮 mh8-test 残留，无 documents 行）→ 业主在 Supabase 后台 Storage 里手删。
3. **stuA 测试账号密码**曾在 CC 屏幕上出现（卡1074）→ 建议业主择日在 Supabase Auth 里重置 stuA 密码。
4. **邀请重发 RPC**：仍缺正式「重发邀请」入口（目前靠直插 named_invites+触发器）。
5. **迁移账本双目录收敛**：`supabase/migrations/` 与 `docs/supabase 文件/` 并存（历史债）。
6. **wm-cache 回填收尾观察**：cron 应在本轮后约 11 分钟把 pending 补到 0；业主可隔天扫一眼 `cron.job_run_details` 确认无失败堆积（正常应基本空转）。

## 7. 环境/纪律
- 密钥零信任：暗号只在 catalog；0195 归档 secret-free（运行时读，文件无暗号）；只出现公开 publishable 公钥。
- EF 只改 signed_url 一处、未部署；不改三个 fanout 函数、不改 prepare/view/cleanup、不改触发器。
- 五端本地 md5 开工=收官（未动任何前端）。回填补的是真实业务缓存（正常动作）。
