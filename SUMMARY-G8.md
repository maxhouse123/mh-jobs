PUSH_OK=yes

# SUMMARY-G8 —— G-8 轮收官总结（2026-10-10）

含义（首行 PUSH_OK=yes）：两次代码推送都已推（cycle=1 产品三件事 + cycle=1b 第10章修表 + cycle=2 成片/页面双档），
Cloudflare Pages 已部署（线上构建串 student `g8-2026-10-10` / school `gs8-20261010` 实证），线上真验全过（A1~A13），
前后对照表已出（compare-table.md 全 84 行）。清理两段（R2 460 个 + Supabase 照片 81 个）已执行并复验。

本轮无人值守续跑，大白话写给看不懂代码的业主。

---

## ① 前后对照表（两线·两路·三档，TTFF / 卡顿 / 首帧前字节 / cf-cache）
完整 84 行见 `jobs/JOB-G8/compare-table.md`（同一份 measure.mjs、每格 3 次取中位、直连与代理分开）。头条摘录：

**不限速 高清→流畅（首帧耗时 / 首帧前字节）**
| 格子 | 高清(前) | 流畅(后) |
|---|---|---|
| 学生·中·整片·直连 | 1036ms / 1360KB | **387ms / 73KB** |
| 学生·英·整片·4G | 1791ms / 706KB | **399ms / 66KB** |
| 学校·中·速览·4G | 3475ms | **455ms**（学校走私有桶，脚本未计字节显 0KB） |

**弱网整片 前(高清 g7b)→后(自动切流畅)**
| 格子 | 前 | 后 |
|---|---|---|
| 学生·中·整片·3G | 4780ms | **838ms**（播 c01-lite-g8） |
| 学校·中·整片·3G | 11593ms | **663ms**（播 intro-lite-g8） |

**缓存**：页面 HTML 与媒体对象第 2 次 `cf-cache-status=HIT`（直连 + 代理）。
**卡顿**：不限速/4G 高清整片 0 次；慢 3G 章节仍有缓冲（如实记录在对照表）。
**仍偏慢（如实标红）**：速览(quick)是单条约 175 秒长片、非分段串播，极端网仍 >5s（学生·中·速览·慢3G 7758→**6398ms**、学校·中·速览·慢3G 17401→**13512ms**）；比前改善但未达 6s 线。整片与章节在弱网已大幅转好。

## ② 文件规格前后（高清不变、流畅新增，moov 位置）
- **高清一字未动**：学生线沿用各章 g6/g6b/g7/g7b 成片 + full-g8/quick-g8；学校线沿用 full-g7/quick-g7（本轮只加流畅档，高清档不碰）。所有高清对象 `moovInHead=true`（moov 在文件头，首帧前只需下几十 KB），复核通过（见 `media-specs.log`）。
- **流畅档全新增**（`lite-manifest.json`）：学生 **60 个**（540×960 竖版，码率 77–256kbps，pass 60/60、playOk）；学校 **17 个**（960×540 横版，145–221kbps，pass 17/17）。流畅文件首帧前字节比高清小一个量级（如学生整片 1360KB→73KB）。

## ③ 产品侧三件事落地 + 版本号（线上实证）
五端线上版本（index 重定向 == committed == 线上）：**student v413 / admin v250 / school v245 / reviewer v46 / partner v184**。
1. **付款单改名**（§3.1）：四语新名线上实证——EN `Admission Letter Unlock Fee`、中「录取通知书解锁费」、俄「Плата за разблокировку письма о зачислении」、法「Frais de déverrouillage de la lettre d'admission」；金额标签/说明句四语齐全。**旧词线上 = 0**（中介服务费 / intermediary service fee 等在主 HTML 与四语词典全 0，仅 zh 词典一处开发者注释含 "Intermediary"，非用户可见）。改了学生/中介/管理/学校/审核端（有费名处）。
2. **三个演示校接口按 is_test 过滤**（§3.2）：search_students_blind / match_task_candidates / get_task_candidates 线上 `has_is_test_filter` 全 t；测试校 ADM-100000 返回非测试生泄漏 0、真校 ADM-100006 返回测试生泄漏 0，**全 0 串台**（事务内 rollback，未改数据）。
3. **第 10 章「补充信息表」排版**（§3.3 + 业主裁决 A 修表）：四语标题横排（fr 词折两行为正常横向折行，非逐字竖排 bug）；橙色「N 项由平台预填」提示在标题下方靠左；字段全部可见可填（姓/名/国籍/护照号/出生日期/HSK/邮箱/电话 + 个人信息 + 存草稿/提交）。student v413 修表落地，线上四语抽帧实证。

## ④ 重录了哪些章 + 换了谁的脸
- **重录**（只录受影响的）：学生线 × 四语 **c07**（付款单新名）、**c12**（代付单新名）、**c10**（10-4~10-6 字幕从 git 历史恢复四语三句 + 章名改回 G-7 前名字 + 页面章名同步）。c07/c12 本轮之前已重录好，本续跑未重录（任务书第 13 条口径）。其它章不动。
- **换脸**：**未换**（A13）。来源 A 累计抓 580 张，0 张可用的深肤非洲男青年脸（C-M，18–30 不戴眼镜）；加纳(046)/赤道几内亚(049)两名 near_group 测试生维持 D 顶替脸；尼日利亚 Chidi（C 组但 31–35 岁）不换。faces-map/catalog 本轮一字未改。依 QUEUE-G8 §0.6「不算停」。

## ⑤ 清理数字（业主已授权 §7）
| 桶 | 删除 | 释放 | 复验 |
|---|---|---|---|
| R2 公开桶 maxhouse-media（guide/student/v2/） | 413 个 | ~1089.5 MB | 删后列桶 643→**230** 恰等引用集；230/230 公网 HEAD 200/206 |
| R2 私有桶 maxhouse-media-private（guide/school/v1/zh/） | 47 个 | ~206.1 MB | 删后列桶 96→**49** 恰等引用集；抽验 6/6 OK |
| Supabase student-documents（is_test 学生孤儿 photo） | 81 个 | ~8.8 MB | DB 重查孤儿=**0**；被引用测试照 52 个未动；**真学生照片 11 张零碰** |
| **合计** | **541 个** | **~1304 MB** | 引用集零断链，守卫全过，删的全是被新版顶替的旧片/孤儿 |

## ⑥ 业主只需看什么（三条，手机即可）
1. **付款单新名**：打开学生页，点开关切「流畅」，看第 7 章——付款单标题应是「录取通知书解锁费 / Admission Letter Unlock Fee」，不再有「中介服务费」。
2. **流畅整片串播**：打开学校页，选「流畅」看整片——应从 intro 一路自动串到片尾卡（第 N/14 章小标、上/下章可点），片尾二维码扫出 `https://www.maxhouses.net/`。
3. **弱网自动提示**：手机关 Wi-Fi 用慢网打开学生页看高清整片——卡两次后应自动切「流畅版」并弹 2 秒小提示「网络较慢，已切换到流畅版」，进度不倒退。

## ⑦ 没做到的项与原因
- **Cloudflare Zone 设置（§2.3：http3 / 0rtt / early_hints / tiered cache smart topology）未改**：本轮 `cf-api.sh` 令牌缺 `Zone.Zone Settings:Read/Edit` 与 Tiered Cache 编辑权，http3 的 GET 至今回 9109 Unauthorized，smart topology 仍 off。依 QUEUE-G8 §2.3「令牌没权限就写出权限名继续」+ 本趟规则「仍没权限就跳过不停工」处理。前后留底 `cf-settings-before.json`/`-after.json`。
- **速览(quick)弱网仍 >5s**：speed 一节已标红，因速览为整段单片、非分段串播，本轮未拆分。
- **R2 的 S3 直连钥匙失效**：`.env` 里那把 R2 S3 token 现已 403（列桶/删文件本轮改走 CF REST API + wrangler，不受影响）；非阻塞，建议业主有空重发。

## ⑧ 下一轮建议
1. **业主在 Cloudflare 后台补令牌权限**（`Zone.Zone Settings:Edit`、Tiered Cache 编辑权），补后一张卡即可把 §2.3 的 http3/0rtt/early_hints/smart-topology 该开的开上（前后留底）。
2. **重发一把 R2 S3 API token** 更新进 `.env`，恢复 S3 直连口径（日后列桶/核验更快）。
3. **速览(quick)弱网提速**：考虑把速览也做成分段串播，或单独出更低码率的 quick-lite。
4. **国内访问彻底提速需 ICP 备案 + 国内 CDN**：当前全链路在 Cloudflare 海外边缘，国内用户经 GFW 仍有物理延迟；要再上一个台阶必须在国内放一份 CDN，而**国内 CDN 服务一律要求域名完成 ICP 备案**（需国内主体、约数周审批）。这是产品级决策，本轮技术侧已把海外边缘 + 双档 + 弱网降档做到位；是否走备案由业主定。

---
**账本**：G8-00~G8-07 全部完成。代码两次推送已上线并线上真验；清理两段已执行并复验；本总结即 §8 收官件。

---
## 补记（卡1360）· JOB-G8-08 Cloudflare zone 设置收尾
本轮令牌权限已够，maxhouses.net 五项 zone 设置全部读到。http3 / 0rtt / early_hints / brotli 四项本来就是 on（按要求一个没改）；唯一是 off 的 tiered_cache_smart_topology_enable（智能分层缓存）已 PATCH 成 on 并复读确认。验证：带浏览器 UA 的 `curl -sI https://www.maxhouses.net/guide/student/` 响应头含 `alt-svc: h3=":443"; ma=86400`，即 HTTP/3 已开。全程无 9109/10000 无权限报错，未碰缓存规则、未清缓存。原始前后 JSON + 回执见 JOB-G8-08.md / JOB-G8-08-cf-settings-{before,after}.json。
