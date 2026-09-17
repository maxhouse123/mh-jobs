# SUMMARY · 第九轮收官（2026-09-17）

本轮回到改代码：有版本推进、有迁移。**主仓库一律未推**（照规矩留业主原生终端带代理推）；**Edge Function 一律只改源码、未部署**（部署留业主）。三个迁移已应用生产库（均新增型/授权例外）。

## 一、逐包结果
| 包 | 结果 | 关键交付 |
|---|---|---|
| 9-00 开工核对 | ✅ | 五端 md5=基底、工作区干净、Playwright 起 Chrome OK |
| 9-01 上传体验三修 | ✅ | student v390/partner v155；学生①出卡前置②重试复用同卡③按钮锁 aria-disabled；中介按业主裁决只做①；stub 学生8/8+中介6/6 |
| 9-02 执行器白名单+get_my_offers round_id | ✅ | db-run.sh 白名单口子(三假迁移证 block/block/allow)+**0191** 迁移已应用(列34→35/权限还原)；前端已读 offer.round_id 免改 |
| 9-03 手机断点续传验证 | ⚠️ **未完成·跳过** | 自检通(手机/CDP/stuA登录/TUS加载/8MB走resumable)，但两障碍未取到断网续传断言；**需业主重启手机 Chrome**（详见 JOB-9-03.md） |
| 9-04 AI预检EF根治 | ✅ 源码·未部署 | precheck-ai：提示词英文材料名+落库前 humanizeIssue 净化(双保险)；node 单测 7/7 |
| 9-05 邀请邮件施工 | ✅ 源码·未部署；触发器已上生产 | 新 EF send-invite-email(四语内联)+**0192** 触发器已应用(0→1/0→1) |
| 9-06 水印预渲染缓存 | ✅ 源码·未部署；桶+触发器已上生产 | **0193** 桶wm-cache+3触发器已应用(0→1/+3/+3)；watermark-doc 加 prepare/cleanup/signed_url 三模式(原查看分支零改动)；reviewer v34 先桶后EF回落；stub 4/4 |
| 9-07 eruda 手机控制台 | ✅ | student v391：自托管 eruda v3.4.3，仅 ?debug=1/localStorage 懒加载，默认零加载；stub 4/4 |

## 二、五端最终版本 + md5
| 端 | 版本 | md5 | 本轮是否变 |
|---|---|---|---|
| admin | v209 | `f12e994c60a4359a881575b5ce2f6abb` | 未变 |
| student | **v391** | `d62fa673478c458cfb9922a347c4630c` | 变(9-01 v390→9-07 v391) |
| partner | **v155** | `5156d336fe13c5c70575d9f72b80e231` | 变(9-01) |
| school | v231 | `b4473f8906ff0a07735640209300677a` | 未变 |
| reviewer | **v34** | `8a4b3f27551569ddaca6460cb29b3009` | 变(9-06) |

## 三、本地待推提交清单（`git log 226c457..HEAD`）
> 全部**未推**。业主在原生终端 export 代理后 `git push origin main`；推后请按 P5「推后即验」核 `git log origin/main..HEAD` 为空。
```
3286d6f student v391 + eruda 自托管 (JOB-9-07)
1ed46de watermark-doc EF 三模式 + reviewer v34 + 0193_wm_cache (JOB-9-06)
f244342 迁移改号归位 0174→0191 / 0175→0192 (更正)
584ee7e send-invite-email EF + 0192 邀请邮件触发器 (JOB-9-05)
b2cedbe precheck-ai EF 代号根治 (JOB-9-04)
1bd66cd get_my_offers +round_id 归档→后改号 0191 (JOB-9-02)
6a437ee student v390 / partner v155 上传体验三修 (JOB-9-01)
5360b79 assets/icons 正式 PWA 图标覆盖占位图 —— ⚠️ 这条是【业主的图标卡】提交(非本轮 CC 施工), 也在本地未推之列; 若你已单独推过它, 忽略即可
```
（7 条为本轮 CC 施工 + 1 条 5360b79 为你的图标卡。`git status --untracked-files=no` 已 clean。）

## 四、业主待办清单
### ① 推主仓库
原生终端带代理 `git push origin main`（本轮 7 条 CC 提交 + 你的图标提交）。

### ② 部署 Edge Function ×3（本轮只改源码、未部署）
> 均在 Supabase 网页 Functions 编辑器整页粘贴对应 `index.ts` → Deploy。**部署前先在有 deno 的机器跑一次 `deno check`（本机无 deno + 不挂代理装不了，本轮以 node/结构自检替代）。**

| EF | 源码路径 | 改了什么 | 部署注意 |
|---|---|---|---|
| **precheck-ai**（9-04） | `supabase/functions/precheck-ai/index.ts` | 提示词 doc_type 代号→英文材料名(DOC_NAMES)；模型输出落库前 humanizeIssue 净化带引号代号 | 沿用现有部署方式(关 Verify JWT) |
| **send-invite-email**（9-05·新函数） | `supabase/functions/send-invite-email/index.ts` | 全新：命名邀请四语信，收件人 named_invites.email，链接 ?invite=<token> | **带 `--no-verify-jwt`**；env 需 MH_HOOK_SECRET/SB_SECRET_KEY/RESEND_API_KEY/SUPABASE_URL |
| **watermark-doc**（9-06） | `supabase/functions/watermark-doc/index.ts` | 加 prepare/cleanup/signed_url 三模式；**原 POST {doc_id} 查看分支零改动** | env 需 MH_HOOK_SECRET；部署前审核端行为=现状 |

### ③ 各迁移 rollback 文件位置
| 迁移(已应用) | rollback | 能否走 db-run.sh |
|---|---|---|
| 0191 get_my_offers +round_id | `supabase/migrations/0191_get_my_offers_round_id_rollback.sql`（本机 `jobs/JOB-9-02/rollback.sql`） | ✅ 可(get_my_offers 在白名单) |
| 0192 invite 邮件触发器 | `supabase/migrations/0192_invite_email_trigger_rollback.sql`（`jobs/JOB-9-05/rollback.sql`） | ❌ **手跑**(含 drop function，非白名单) |
| 0193 wm-cache 桶+触发器 | `supabase/migrations/0193_wm_cache_rollback.sql`（`jobs/JOB-9-06/rollback.sql`） | ❌ **手跑**(含 drop function；删桶需先清空对象) |

### ④ 9-03 手机线复位
把手机 Chrome **彻底关掉重开**（清掉我上轮遗留的「模拟断网」卡死状态 + 让 PWA 重注册干净 Service Worker）。之后可重跑 9-03，或你手动传一个 >6MB 文件、传一半断一下 WiFi 再开、肉眼看是否「接着传」。顺手看一眼 stuA 的 bank 槽是否就是原来那 2 个文件（应是；若见 `mh9-` 开头文件删掉即可）。

## 五、backlog（记录待办）
1. **邀请「重发也发信」RPC**（9-05）：本版只首次 INSERT 发信；重发需单独 RPC。
2. **wm-cache 兜底 cron**（9-06）：pg_cron 每 5 分钟扫「有 assignment 但桶里没对象」补渲染 + 清孤儿缓存；本版只上触发器即时清。
3. **9-06 读取口 RPC 偏差**：设计原 `wm_cache_signed_url` RPC「返回签名 URL」——SQL 无法签发 storage 签名 URL，已改由 watermark-doc `signed_url` 模式(service_role 代签)实现，桶仍全闭。若你坚持 SQL 侧，需库内引 storage JWT 密钥手工签(风险高，不建议)。
4. **迁移账本双目录**：`docs/supabase 文件/`（停在 0173 的旧账本）与 `supabase/migrations/`（真账本，已到 0193）并存，本轮已把新迁移归入真账本。建议择期把旧目录标注/收敛，免再撞号。
5. **9-03 断点续传结论**：>6MB 真断点续传在 300KB/s 全程限速下，第一片 6MB 创建 POST 难提交、到不了 PATCH——续传只对「已提交的 6MB 之后」生效；改进思路见 JOB-9-03.md（先常速让首片提交、再对后续 PATCH 限速断网）。

## 六、红线自查
- 主仓库 CC 只 add+commit，**未 push**（等业主带代理推）。
- 三个 EF **只改源码、未部署**（部署另出卡/业主手动）。
- 破坏性操作仅 9-02 get_my_offers 一处（业主 2026-09-16 授权白名单例外）；rollback 可原样恢复旧函数+权限。三个 SQL 密钥在归档中一律打码（`__MH_HOOK_SECRET__`），未进 GitHub。
- 上传回落红线 + TUS 层：9-01 零改动。原件桶 student-documents：9-06 零改动，双盲不破。
- 9-03 只碰 stuA 的 bank 槽，四类闸门槽一字节未碰；测试件均离线失败几无孤儿（待业主重启后复核）。
