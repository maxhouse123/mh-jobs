# SUMMARY-10 · 第十轮总账（2026-09-17）

> 大白话总账。本轮**以验为主，只修两处**：10-02 水印通电（结论=停在方案，未改库）、10-06 中介端重试（partner v156，已改已过闸）。EF 源码零改动；主仓库**只 commit 不推**（6 笔待业主推）；含学生资料的截图只在本机、不进日志仓库。手机线锁屏，10-03/10-04 跳过不影响其他包。

## 1. 逐包结果
| 包 | 结果 | 一句话 |
|---|---|---|
| 10-00 开工核对 | ✅ | 五端 md5 全对齐、git clean、HEAD=origin/main、mh-jobs 同步 |
| 10-01 stuA 残留清查 | ✅（零写） | 活文件 mh\*=0 无需软删；storage 孤儿 1 个（3MB mh8-test）只列→backlog；bank 槽 2 活文件未锁 |
| 10-02 水印通电 | ⏸ 停在方案 | 病根实锤：网关 401 无 Auth 头→预渲染白装。实测 publishable 公钥可作 Bearer 越网关→迁移 0194 即可通电（不用改 EF）。因与卡「必须 eyJ JWT」前提冲突+「必须停」，停在方案待业主一句话授权 |
| 10-03 TUS 断点续传（手机） | ⏭ 跳过 | 手机锁屏、Chrome 调试端口不可达（WAKEUP 一次仍锁，未试密码） |
| 10-04 线上真机烟测（手机） | ⏭ 部分 | 手机子项同 10-03 跳过；非手机子项：partner v155 线上 [VER] 对版 200、reviewer v34 CF Access 200 |
| 10-05 邀请邮件真发一封 | ✅ | 只发 maxhouseapp+invitetest@gmail.com 一封，Resend accepted/200/provider_id，发完即作废（不删行） |
| 10-06 中介端重试 | ✅ v156 | 三条上传线失败卡补「重试」按钮，复用同卡回进度态；闸8 jsdom 驱真 _v384 28/28；十道闸全过 |

## 2. 五端最终版本 + md5（本轮只有 partner 变）
- admin **v209** `f12e994c60a4359a881575b5ce2f6abb`（未动）
- student **v391** `d62fa673478c458cfb9922a347c4630c`（未动）
- partner **v156** `a82f67fb371ac60ae3bddcf1675b950a`（← v155，JOB-10-06）
- school **v231** `b4473f8906ff0a07735640209300677a`（未动）
- reviewer **v34** `8a4b3f27551569ddaca6460cb29b3009`（未动）

## 3. 待推提交清单（主仓库 origin/main..HEAD，6 笔，业主原生终端挂代理推）
```
e4c51e3 JOB-10-06 中介端上传失败卡补「重试」 partner v155→v156
907fc0d JOB-10-05 邀请邮件真发一封
e08a7f2 JOB-10-03/04 跳过 + 10-04 非手机子项补测
d8411a7 JOB-10-02 水印通电: 病根实锤 + 停在方案 0194
dccbb12 JOB-10-01 stuA残留清查
c53d7b5 JOB-10-00 开工核对
```
推送四段式（铁律 P5）：①`git log origin/main..HEAD --oneline`（应列这 6 笔）②`git push origin main` ③再 `git log origin/main..HEAD`（应空）④`git status`（应 clean）。
> 注：真正会改变线上行为的只有 **partner v156**（其余是 jobs/ 回执与探针/方案稿）。推后 partner v156 上线，中介端上传失败即有重试按钮。

## 4. 10-02 通电结论（要紧）
- **现状=不通**：0193 三个触发器只带 `x-mh-hook-secret`、无 `Authorization`；watermark-doc 部署 verify_jwt=ON → 网关在函数运行前 401（近 6h 实测 20 条 `UNAUTHORIZED_NO_AUTH_HEADER`）。预渲染从未发生，审核端一直走现场渲染回落（**功能不坏，缓存白装**）。
- **修法（推荐·纯迁移，不碰 EF/部署）**：迁移 0194 给三个 fanout 函数加 `Authorization: Bearer sb_publishable_…`（前端公开公钥）。**已实测该公钥能越过网关**（带它请求到达 EF，被假暗号以 `{"error":"unauthorized"}` 拒，证明网关放行）。方案稿（打码）在 `jobs/JOB-10-02/0194_wm_auth_PLAN_masked.sql`。
- **为何没动手**：卡把 0194 的 Bearer 限定为 `eyJ…` JWT，而五端已全改 `sb_publishable_` 新式公钥、库/归档无旧 anon JWT；卡令此时「停」，且启动指令 10-02 标「必须停」。→ **业主回一句「用选项①，应用 0194」CC 即照办**（跑前跑后函数数 3→3、含 Authorization 函数数 0→3，rollback 用 pg_get_functiondef 原样恢复）。
- 备选（不推荐）：改 watermark-doc 部署 `--no-verify-jwt` + EF 自己 `auth.getUser` 校验——改 EF+部署，面更大。

## 5. stuA 残留清零证据
- documents 表 stuA 名下 `mh8-*/mh9-*` 行：0（含软删）。活文件 mh\* 数 = **0**（卡收尾判据达成，无需任何软删/写操作）。
- bank 槽（非闸门槽）= 原有 2 个活文件（Screenshot_20260822…png / 1789537…jpg），未锁；四类闸门槽一字节未碰。

## 6. Backlog（交业主决定/后续块）
1. **storage 孤儿对象**：`student-documents/43668ae4…/bank/1789571102495_4vtz_mh8-test-3mb.jpg`（3MB，第八轮 mh8-test 残留，无 documents 行）。建议业主手工清（非真实学生资料）。
2. **邀请重发 RPC**：目前重发靠直插 named_invites+触发器；缺一个正式「重发邀请」RPC/入口（本轮只手工发一封验证链路通）。
3. **wm-cache 兜底 cron**：10-02 通电后，历史派单不会回填预渲染缓存；可加一个补渲染 cron（后续）。
4. **迁移账本双目录收敛**：`supabase/migrations/` 与 `docs/supabase 文件/` 双目录并存（历史债，编号已归位但目录未合）。
5. **`doc_slot_batches` 表不存在**：卡 10-01 步4 假设的槽「批次/锁」表在库中无实体；槽状态目前只能从 documents 派生。若要正式「批次锁+admin 审批」需另建表（后续）。
6. **手机线**：Pixel 锁屏导致 10-03/10-04 未跑；业主解锁 Chrome（确认 stuA 登录态 v391 前台）后可重跑这两包。

## 7. 环境/纪律
- 密钥零信任：暗号全程 DUMMY/未使用、未入任何回执/文件/日志；归档打码 `__MH_HOOK_SECRET__`；仅用公开 anon/publishable 公钥。
- EF 源码本轮零改动；主仓库零推送（6 笔待业主推）；每包回执 commit 后即 push 到 ~/mh-jobs 远端。
- 本机测试依赖（jsdom）装在 ~/mh-verify，不入 git。
