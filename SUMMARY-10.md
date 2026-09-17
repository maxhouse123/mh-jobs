# SUMMARY-10 · 第十轮总账（2026-09-17）

> 大白话总账。本轮**以验为主，修两处**：10-02 水印通电（**已通电**：迁移 0194 应用+端到端自验通过，卡1072 授权后）、10-06 中介端重试（partner v156，已改已过闸）。EF 源码零改动；主仓库**只 commit 不推**（9 笔待业主推）；含学生资料的截图只在本机、不进日志仓库。手机后解锁但 stuA 未登录且无密码 → 10-03 跳过、10-04 非登录子项真机过、登录子项延后。
>
> **更新（卡1072 完成后）**：10-02 已应用 0194 通电；10-03/10-04 手机重跑（stuA 未登录 → 部分）。

## 1. 逐包结果
| 包 | 结果 | 一句话 |
|---|---|---|
| 10-00 开工核对 | ✅ | 五端 md5 全对齐、git clean、HEAD=origin/main、mh-jobs 同步 |
| 10-01 stuA 残留清查 | ✅（零写） | 活文件 mh\*=0 无需软删；storage 孤儿 1 个（3MB mh8-test）只列→backlog；bank 槽 2 活文件未锁 |
| 10-02 水印通电 | ✅ **已通电**（卡1072） | 迁移 0194 给三个 fanout 函数加 Authorization:Bearer<publishable 公钥>（自改写型读 catalog 注入，暗号零外泄）；函数数 3→3、含 Auth 0→3；端到端自验：prepare `200{ok,cached}`→桶出对象→cleanup `200{cleaned}`→对象消失（测试学生 stuA）。读侧待业主看 v34 console `[v34] wm cache HIT` |
| 10-03 TUS 断点续传（手机） | ⏭ 跳过 | 手机已解锁、DevTools 通，但 **stuA 未登录且无密码**（上传需登录）→ 跳过，未试密码 |
| 10-04 线上真机烟测（手机） | ⏭ 部分 | **不需登录子项真机过**：①v391 对版（url+[VER]）、④eruda（?debug=1 出 #eruda / 无参不出 + 0 请求）。**需登录子项延后**：②上传进度卡、③get_my_offers round_id（stuA 未登录）。⑤partner/reviewer 对版上轮 curl 已核 |
| 10-05 邀请邮件真发一封 | ✅ | 只发 maxhouseapp+invitetest@gmail.com 一封，Resend accepted/200/provider_id，发完即作废（不删行） |
| 10-06 中介端重试 | ✅ v156 | 三条上传线失败卡补「重试」按钮，复用同卡回进度态；闸8 jsdom 驱真 _v384 28/28；十道闸全过 |

## 2. 五端最终版本 + md5（本轮只有 partner 变）
- admin **v209** `f12e994c60a4359a881575b5ce2f6abb`（未动）
- student **v391** `d62fa673478c458cfb9922a347c4630c`（未动）
- partner **v156** `a82f67fb371ac60ae3bddcf1675b950a`（← v155，JOB-10-06）
- school **v231** `b4473f8906ff0a07735640209300677a`（未动）
- reviewer **v34** `8a4b3f27551569ddaca6460cb29b3009`（未动）

## 3. 待推提交清单（主仓库 origin/main..HEAD，**9 笔**，业主原生终端挂代理推）
```
f8066d1 JOB-10-03/04 重跑(卡1072): 手机解锁但stuA未登录→10-03跳过/10-04非登录子项过
cfbdd00 JOB-10-02 选项① 应用: 迁移0194 通电+端到端自验
f45d092 JOB-10-07 收官 SUMMARY-10
e4c51e3 JOB-10-06 中介端上传失败卡补「重试」 partner v155→v156
907fc0d JOB-10-05 邀请邮件真发一封
e08a7f2 JOB-10-03/04 首轮跳过 + 10-04 非手机子项补测
d8411a7 JOB-10-02 水印通电: 病根实锤 + 停在方案(后被卡1072授权应用)
dccbb12 JOB-10-01 stuA残留清查
c53d7b5 JOB-10-00 开工核对
```
推送四段式（铁律 P5）：①`git log origin/main..HEAD --oneline`（应列这 9 笔）②`git push origin main` ③再 `git log origin/main..HEAD`（应空）④`git status`（应 clean）。
> 注：会改变线上行为的有两处 —— **partner v156**（推后上线，中介端上传失败即有重试按钮）与 **迁移 0194**（**已在生产库应用**，无需推送，push 只是把归档 `supabase/migrations/0194_*` 入远端账本）。其余是 jobs/ 回执与探针。

## 4. 10-02 通电结论（要紧）· **已通电**
- **病根**（曾）：0193 三个触发器只带 `x-mh-hook-secret`、无 `Authorization`；watermark-doc 部署 verify_jwt=ON → 网关在函数运行前 401（`UNAUTHORIZED_NO_AUTH_HEADER`）。预渲染从未发生，审核端一直走现场渲染回落（功能不坏，缓存白装）。
- **已修（卡1072 授权，选项①）**：迁移 0194 给三个 fanout 函数加 `Authorization: Bearer sb_publishable_…`（前端公开公钥）。做法=**自改写型**：用 `pg_get_functiondef` 读库内现役函数体（含暗号），就地在 headers 插入 Authorization 键、再 `execute` 重建——**暗号全程只在 catalog、零落文件/日志/回执**；全 create or replace、无 drop。
- **端到端自验通过**（测试学生 stuA 的 doc × 测试审核员）：prepare → `200 {"ok":true,"cached":true}` + wm-cache 桶出现 `<reviewer_uid>/<doc_id>.jpg`（392941B）；cleanup → `200 {"ok":true,"cleaned":true}` + 该对象消失（0 残留）。函数数 3→3、含 Authorization 0→3。
- **归档**：`supabase/migrations/0194_wm_auth.sql` + `0194_wm_auth_rollback.sql`（均 secret-free；rollback 同法反向剥离 Authorization → 3→0）。
- **读侧待业主**：审核端 v34 打开一份已派单材料，看 console 出 `[v34] wm cache HIT`（命中即秒下）。

## 5. stuA 残留清零证据
- documents 表 stuA 名下 `mh8-*/mh9-*` 行：0（含软删）。活文件 mh\* 数 = **0**（卡收尾判据达成，无需任何软删/写操作）。
- bank 槽（非闸门槽）= 原有 2 个活文件（Screenshot_20260822…png / 1789537…jpg），未锁；四类闸门槽一字节未碰。

## 6. Backlog（交业主决定/后续块）
1. **storage 孤儿对象**：`student-documents/43668ae4…/bank/1789571102495_4vtz_mh8-test-3mb.jpg`（3MB，第八轮 mh8-test 残留，无 documents 行）。建议业主手工清（非真实学生资料）。
2. **邀请重发 RPC**：目前重发靠直插 named_invites+触发器；缺一个正式「重发邀请」RPC/入口（本轮只手工发一封验证链路通）。
3. **wm-cache 回填 cron**：10-02 现已通电，但只对**新派单/新软删**生效；**历史存量派单**不会自动回填预渲染缓存（首次打开仍走现场渲染回落，正常）。可选后续：加一个补渲染 cron 或让审核端首访即触发 prepare 回填。
4. **迁移账本双目录收敛**：`supabase/migrations/` 与 `docs/supabase 文件/` 双目录并存（历史债，编号已归位但目录未合）。
5. **`doc_slot_batches` 表不存在**：卡 10-01 步4 假设的槽「批次/锁」表在库中无实体；槽状态目前只能从 documents 派生。若要正式「批次锁+admin 审批」需另建表（后续）。
6. **手机线待重跑**：Pixel 已解锁、DevTools 通，但 **stuA 未登录**（会话空、无 auth 键）且卡未给密码 → 10-03（断点续传）+ 10-04 的 ②上传/③get_my_offers 延后。业主在手机 Chrome v391 登录 stuA 后，让 CC 重跑即可（另有一个旧 v389 标签页开着，可顺手关）。

## 7. 环境/纪律
- 密钥零信任：暗号全程只在 catalog / 探针用 DUMMY，未入任何回执/文件/日志；归档只见占位符 `__MH_HOOK_SECRET__` 与公开 publishable 公钥。
- EF 源码本轮零改动；**迁移 0194 已应用生产**（新增型，卡1072 授权）；主仓库零推送（9 笔待业主推）；每包回执 commit 后即 push 到 ~/mh-jobs 远端。
- 本机测试依赖（jsdom）装在 ~/mh-verify，不入 git。手机截图只在本机 ~/mh-android/shots/JOB-10/，不入日志仓库。
