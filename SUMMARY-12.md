# SUMMARY-12 · 第十二轮总账（2026-09-17）· 审核端「查看」真正秒开

> 大白话总账。本轮**不用手机**，目标=审核端命中缓存**真的秒开**。四件事全落：读侧不经云函数（直读桶）、预渲染件瘦身、预取节流、清桶重灌函数只建不跑。主仓库**只 commit 不推**；暗号零外泄（只在数据库 catalog 流转）。

## 1. 逐包结果
| 包 | 结果 | 一句话 |
|---|---|---|
| 12-00 开工核对 | ✅ | 五端 md5 对齐、HEAD=origin/main(988c9f5)、桶 100/待补 4 |
| 12-01 读侧去云函数（0196 + reviewer v35） | ✅ | 桶读策略+索引表+审计RPC；RLS实测 reviewer1=100/不相干=0/撤单不可读；v35 三级回落（直读→signed_url→现场渲染）闸8 14/14 |
| 12-02 预渲染瘦身+写索引（EF源码·**不部署**） | ✅ | prepare 改 1600/JPEG75 + 写索引；cleanup 删索引；view/signed_url 零改；结构自检过 |
| 12-03 预取节流（reviewer v35） | ✅ | 登录只预取第一组≤10（不再40）+查看中暂停预取；闸8 11/11 |
| 12-04 清桶重灌函数（0197 **只建不跑**） | ✅ | wm_cache_purge 建好、权限锁死、**绝未调用** |
| 12-05 收官 | ✅ | 本文件 |

## 2. 五端最终版本 + md5（本轮只 reviewer 变）
- admin **v209** `f12e994c60a4359a881575b5ce2f6abb`（未动）
- student **v391** `d62fa673478c458cfb9922a347c4630c`（未动）
- partner **v156** `a82f67fb371ac60ae3bddcf1675b950a`（未动）
- school **v231** `b4473f8906ff0a07735640209300677a`（未动）
- reviewer **v35** `4cecdc939f9cca3edf31a236a06fb170`（← v34；v34 `8a4b3f27…` 原样留盘可回滚）

## 3. 待推提交清单（主仓库 origin/main..HEAD，**约 5–6 笔**，业主原生终端挂代理推）
逐笔以推前 `git log origin/main..HEAD --oneline` 当场实测为准（含 12-00…12-04 各包 + 本 SUMMARY）。
推送四段式（铁律 P5）：①`git log origin/main..HEAD`（列出）②`git push origin main` ③再看应空 ④`git status` clean。

## 4. ⭐ 业主待办顺序（重要，按序做）
1. **推主仓库**：`git push origin main`。推后 **reviewer v35 上线** —— 但注意：v35 的"直读桶"依赖迁移 0196（**已在生产库应用**），所以推 v35 后直读即可用。
2. **部署 watermark-doc（12-02 瘦身版）**：
   ```
   cd /Volumes/Dev/MAXHOUSE
   supabase functions deploy watermark-doc --project-ref uexgzwfambanvhdhxome
   ```
   部署后**新**预渲染件才是 1600/75 小件（旧的还是大件，见下一步）。
3. **一句话触发清桶重灌**：部署完新 EF 后，**叫我一句话**，我跑 `wm_cache_purge(50)` 反复直到桶空 → 0195 的 cron 按新参数（1600/75）自动重灌成小件。**你部署前我绝不跑它**。
4. **审核端复测**：审核端 v35 打开材料，控制台看 `[v35] wm direct HIT <毫秒>` —— 毫秒数应**明显低于** v34 那次的 2.7–7.0 秒（直读省了云函数冷启动 + 瘦身后下载更小）。

> 变快分三层叠加：①直读省云函数冷启动（0196+v35，**推 v35 即生效**）②瘦身减体积（12-02，**需部署+重灌**）③预取节流不抢网络（12-03，**推 v35 即生效**）。

## 5. ⚠️ 一处 DB 约束限制（backlog·业主授权）
`reviewer_access_log` 的 `outcome` CHECK **只允许 `served` / `denied_not_assigned`**。
- 卡要的 `served_cached_direct` 被拒 → 12-01 的 log_wm_view **落 `served`**（"谁看了哪份"照样留痕）。
- **顺带发现**：watermark-doc 自己写的 `prepared` / `served_cached` 等 outcome **一直被这条约束静默拒**（EF 的 logAccess 吞错），即这些审计从没真正写进去。
- 放宽约束需改约束语句（被 db-run.sh 红线挡 + 铁律9），**留业主授权**。现成 SQL（SQL Editor 跑）：
  ```sql
  alter table public.reviewer_access_log drop constraint reviewer_access_log_outcome_check;
  alter table public.reviewer_access_log add  constraint reviewer_access_log_outcome_check
    check (outcome in ('served','denied_not_assigned','prepared','served_cached',
                       'served_original','served_video_url','served_cached_direct'));
  ```
  放宽后我一行 `create or replace log_wm_view` 把落地值改回 `served_cached_direct`。

## 6. Backlog
1. **watermark-doc 待部署**（12-02 瘦身版）+ **清桶重灌待触发**（12-04，部署后叫我）。
2. **reviewer_access_log outcome 约束放宽**（见 §5，业主授权）。
3. **审核台无收合开关** → 12-03 的"其余组展开时再取"落为"点查看按需取"；若将来加收合 UI，一行接 `_wmPrefetchGroup(studentCode)` 即可。
4. **storage 3MB 孤儿对象**（`43668ae4…/bank/1789571102495_4vtz_mh8-test-3mb.jpg`）业主后台手删。
5. **stuA 测试密码**曾上屏（卡1074），建议 Auth 里重置。
6. 邀请重发 RPC / 迁移账本双目录收敛（历史债）。

## 7. 环境/纪律
- 密钥零信任：0196/0197 归档 secret-free（暗号运行时读 catalog）；只出现公开 publishable 公钥。
- EF 只改源码未部署（12-02）；0197 只建不跑（12-04）；桶只加一条 select 策略，原件桶 student-documents 一字节未动。
- reviewer 三级回落顺序：直读→signed_url→现场渲染；`_wmFetchEF` 逐字保留（闸8 静态断言 v34==v35）。四端未动 md5 开工=收官；本机测试(vm)不入 git。

## 8. 收尾（卡1084 / 1085，2026-09-17 傍晚 · 业主已推主仓库+部署 v30+放宽约束后）
- **EF v30 已核**：`supabase functions list` → watermark-doc version **30**（部署前 v29）、verify_jwt=true；outcome 约束已含 `served_cached_direct`。两条都对才往下。
- **清桶 100→0**：`wm_cache_purge(50)` 调 3 次（返回 50/50/20，40s 间隔），桶 100→50→1→0。
- **cron 重灌回稳**：0195 cron 每 5 分钟补 20，约半小时补齐；末态 95 objs / 待补 4（连续两次一致）。
- **0198 已应用+验证**：`log_wm_view` 落地 outcome 改回 `served_cached_direct`（函数数 1→1）；模拟 reviewer1 调用写入正确、返回 RV-D09E；测试审计行 `f8f5eeb4…` 已删（DELETE 1）。
- **瘦身前后大小**：重灌前 100 objs / 平均 398.6 KB / 38.93 MB → 重灌后 95 objs / 平均 340.9 KB / 31.63 MB（−19%）。**分类**：图片 jpg 69 个 **平均 202.2 KB**（瘦身主力、审核最常看）；PDF 25 个 701.1 KB（本轮不瘦，占桶一半多）；PNG 1 个 910.4 KB。→ **审核端看图片明显变快**；PDF 待下轮另瘦。
- **收尾发现（非致命）**：`wm_cache_index` 重灌后仍 0 行 —— service_role 无 insert 授权，v30 EF upsert 静默失败；但 `log_wm_view` 兜底自算 rv、直读不依赖索引 → 功能全正常。修法一行 grant，列入第十三轮建议包 A（详见 JOB-12-06.md）。
- **第十三轮建议包**：A 索引通电(grant service_role) / B PDF 瘦身(源码不部署) / C 审计完整性核对 / D outcome 约束归档进账本 / E 历史 backlog 收口 —— 判据+边界见 `JOB-12-06.md` 末节。
- **待推清单**：卡1084/1085 本地已 commit（0198 归档 + 回执 + reflow 日志 + 本节），主仓库照旧只 commit 不推；逐笔以推前 `git log origin/main..HEAD` 实测为准。桶只碰 wm-cache、原件桶未动、EF 未改。
