# SUMMARY-10 · 第十轮总账（2026-09-17）

> 大白话总账。本轮**以验为主，修两处**：10-02 水印通电（**已通电**：迁移 0194 应用+端到端自验通过，卡1072 授权后）、10-06 中介端重试（partner v156，已改已过闸）。EF 源码零改动；主仓库**只 commit 不推**（9 笔待业主推）；含学生资料的截图只在本机、不进日志仓库。手机后解锁但 stuA 未登录且无密码 → 10-03 跳过、10-04 非登录子项真机过、登录子项延后。
>
> **更新（卡1072）**：10-02 已应用 0194 通电。
> **更新（卡1074）**：stuA 登录（密码只走内存）后手机线全跑通——10-04 全过、10-03 断网续传核心过；10-02 追加真触发器路径已验（插派单→桶出对象）。**新发现**：bank 槽被 DB 规则 `reason_required_unreviewed` 锁在第3批（这就是"批次锁"真身）；`get_my_offers` 真实签名是 `({uid})` 非无参。

## 1. 逐包结果
| 包 | 结果 | 一句话 |
|---|---|---|
| 10-00 开工核对 | ✅ | 五端 md5 全对齐、git clean、HEAD=origin/main、mh-jobs 同步 |
| 10-01 stuA 残留清查 | ✅（零写） | 活文件 mh\*=0 无需软删；storage 孤儿 1 个（3MB mh8-test）只列→backlog；bank 槽 2 活文件未锁 |
| 10-02 水印通电 | ✅ **已通电 + 触发器路径已验**（卡1072/1074） | 迁移 0194 加 Authorization:Bearer<publishable 公钥>（自改写型读 catalog 注入，暗号零外泄）；含 Auth 0→3；直接自验 prepare/cleanup 全绿；**卡1074 追加真触发器路径**：插派单→AFTER INSERT 触发器→桶出 `80c62372…/259f456a….jpg`(355KB)。读侧（无 reviewer1 密码）留业主看 v34 console `[v34] wm cache HIT`；该测试派单+对象留着待业主验完再撤 |
| 10-03 TUS 断点续传（手机） | ✅ 核心过（卡1074） | stuA 登录后真机：8MB 传一半**断网 3 秒仍续传完成**、无红卡；创建 POST 打到 /upload/resumable、PATCH 从 6MB 断点续传。HEAD 未观测（tus 会话内重试直接续 PATCH，正常）。测试件软删+清储零残留 |
| 10-04 线上真机烟测（手机） | ✅ 全过（卡1074） | ①v391 对版；②注入2MB→**出卡1.6ms**+aria=true→拦500→红卡重试按钮(卡=1)→重试到100%+真建档→软删清储；③`get_my_offers({uid})` 每行 round_id、已录取那条=**MH-6KG2JN 第1轮**；④eruda 参数开关。⑤partner/reviewer 上轮 curl 已核 |
| 10-05 邀请邮件真发一封 | ✅ | 只发 maxhouseapp+invitetest@gmail.com 一封，Resend accepted/200/provider_id，发完即作废（不删行） |
| 10-06 中介端重试 | ✅ v156 | 三条上传线失败卡补「重试」按钮，复用同卡回进度态；闸8 jsdom 驱真 _v384 28/28；十道闸全过 |

## 2. 五端最终版本 + md5（本轮只有 partner 变）
- admin **v209** `f12e994c60a4359a881575b5ce2f6abb`（未动）
- student **v391** `d62fa673478c458cfb9922a347c4630c`（未动）
- partner **v156** `a82f67fb371ac60ae3bddcf1675b950a`（← v155，JOB-10-06）
- school **v231** `b4473f8906ff0a07735640209300677a`（未动）
- reviewer **v34** `8a4b3f27551569ddaca6460cb29b3009`（未动）

## 3. 待推提交清单（主仓库 origin/main..HEAD，**约 12 笔**，业主原生终端挂代理推）
> 逐笔以推前 `git log origin/main..HEAD --oneline` 当场实测为准（本节写作后又有新提交，实数以终端为准）。含 10-00…10-07 各包、10-02 应用/自验/触发器、10-03/04 三次重跑、SUMMARY 多次更新。
推送四段式（铁律 P5）：①`git log origin/main..HEAD --oneline`（列出全部待推）②`git push origin main` ③再 `git log origin/main..HEAD`（应空）④`git status`（应 clean）。
> 注：会改变线上行为的只有 **partner v156**（推后上线，中介端上传失败即有重试按钮）。**迁移 0194 已在生产库应用**（无需推送，push 只是把归档 `supabase/migrations/0194_*` 入远端账本）。其余是 jobs/ 回执与探针。

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
5. **「批次锁」真身找到**：卡 10-01 步4 找的 `doc_slot_batches` 表不存在；实测 bank 槽新传被 DB 规则 `reason_required_unreviewed`（P0001，doc_type=bank batch=3）挡住——**"批次锁"是一条数据库规则：槽内有未复审的旧件时，再传需带 `replace_reason`**。前端换版流程会带 reason，普通直传不带→被拒。若要正式「批次锁+admin 审批」台，围绕这条规则建即可。
6. **读侧待业主验 + 撤测试派单**：10-02 卡1074 留了一条测试派单 `cd7389f7…`（stuA doc `259f456a` → reviewer1@maxhouse.test）+ wm-cache 对象 `80c62372…/259f456a….jpg`(355KB)，供业主在审核端以 reviewer1 打开这份材料、看 console `[v34] wm cache HIT`。**验完请撤单**（`update public.reviewer_assignments set revoked_at=now() where id='cd7389f7-0300-4431-aa98-3e5d2612c95f';`）——撤单会触发 cleanup 自动清桶（顺带验撤单-清理触发器），或让 CC 下轮代做。
7. **get_my_offers/get_my_rounds 签名**：真实签名是 `rpc('get_my_offers',{uid})`/`rpc('get_my_rounds',{uid})`（前端如此调）；QUEUE 里写的无参调用会报 "without parameters not found"。记此以免下轮再踩。

## 7. 环境/纪律
- 密钥零信任：暗号全程只在 catalog / 探针用 DUMMY，未入任何回执/文件/日志；归档只见占位符 `__MH_HOOK_SECRET__` 与公开 publishable 公钥。
- EF 源码本轮零改动；**迁移 0194 已应用生产**（新增型，卡1072 授权）；主仓库零推送（约 12 笔待业主推，实数以终端为准）；每包回执 commit 后即 push 到 ~/mh-jobs 远端。
- 卡1074：stuA 密码只走内存（env→CDP evaluate），未落任何文件/回执；手机测试件全软删（deleted_at）+清储零残留；只碰 stuA 空非闸门槽 cv，四类闸门槽未碰。
- 本机测试依赖（jsdom）装在 ~/mh-verify，不入 git。手机截图只在本机 ~/mh-android/shots/JOB-10/，不入日志仓库。
