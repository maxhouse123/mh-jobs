# JOB-20-04 线上走查回执 (第二十轮) — CC 对现役线上单探

> CC 本地对**现役线上**跑一遍并如实记录。现役=第十九轮(已上线并验收 09-23): student v398 / partner v167 / school v234 / admin v218 / reviewer v45, 故五端 [VER] 三项直读绿、admin/reviewer 在 CF Access 后为 N/A(挡); schX 登中介端被拒走 v167 角色门→绿。本包(20-04)的实际改点仅**卡片选择器对齐 v167/v168 真类名 #_v167CardStack ._v167-card**; 该项须有现成 Q1 告警场景才量, 本次登入后无现成告警卡→如实记 N/A(不主动触发上传避免写库)。第二十轮新版(student v399 / partner v168 / watermark-doc v35)未推送, 本走查不覆盖。

小结: 绿 8 / 红 0 / 灰(N/A) 4

## 五端 index 实际指向的版本
| 端 | 目标(第十九轮) | 实际指向 |
|---|---|---|
| student | maxhouse_student_portal_v398.html | maxhouse_student_portal_v398 |
| partner | maxhouse-partner-portal-v167.html | maxhouse-partner-portal-v167 |
| school | maxhouse-school-portal-v234.html | maxhouse-school-portal-v234 |
| admin | maxhouse-admin-portal-v218.html | 未识别 (CF Access) |
| reviewer | maxhouse-reviewer-portal-v45.html | 未识别 (CF Access) |

## 逐步红绿
| 步骤 | 期望 | 实际 | 判 |
|---|---|---|---|
| ① [VER] student index 指向新版 | maxhouse_student_portal_v398.html | 已指向 (用时 2s) | 绿 |
| ① [VER] partner index 指向新版 | maxhouse-partner-portal-v167.html | 已指向 (用时 0s) | 绿 |
| ① [VER] school index 指向新版 | maxhouse-school-portal-v234.html | 已指向 (用时 0s) | 绿 |
| ① [VER] admin index 指向新版 | maxhouse-admin-portal-v218.html | http 302, 实际=未识别 | N/A |
| ① [VER] reviewer index 指向新版 | maxhouse-reviewer-portal-v45.html | http 302, 实际=未识别 | N/A |
| ② schX 登中介端被拒(v167 判据) | body 仍锁 + 会话为空 + 无机构内容 | 被拒(locked=true, session=false, 机构内容=false, 见拒绝文案) | 绿 |
| ② schX 登入后无 partner_bootstrap 请求 | v167 下 hydratePartner/bootstrap 请求=0 | 0 次 | 绿 |
| ② schX 走查 0 未捕获报错 | pageerror = 0 | pageerror ×0 | 绿 |
| ③ [VER]=v167 (console) | console 打印 partner portal v167 | 命中 | 绿 |
| ③ Q1 提醒卡片(有现成场景) | 有现成 Q1 场景才量卡片样式 | 登入后页面无现成 Q1 告警卡/条 → 有才判, 本次不判(N/A); 不主动触发上传避免写库 | N/A |
| ③ 中介端仪表盘公开截图 | 不外泄机构身份/被推荐学生 PII | 按零信任红线不产出公开截图(证据在红绿表) — 见回执 | N/A |
| ③ 中介端 0 未捕获报错 | pageerror = 0 | pageerror ×0 | 绿 |

## 全程日志
```
· === JOB-20-04 线上走查开始 (CC 单探现役线上) ===
· 公钥来源: env.mjs 公开 anon(回落)
· 轮询 student index: https://www.maxhouses.net/student-portal/ → 期待指向 maxhouse_student_portal_v398.html
· [绿] ① [VER] student index 指向新版 — 期望: maxhouse_student_portal_v398.html | 实际: 已指向 (用时 2s)
· 轮询 partner index: https://www.maxhouses.net/partner-portal/ → 期待指向 maxhouse-partner-portal-v167.html
· [绿] ① [VER] partner index 指向新版 — 期望: maxhouse-partner-portal-v167.html | 实际: 已指向 (用时 0s)
· 轮询 school index: https://www.maxhouses.net/school-portal/ → 期待指向 maxhouse-school-portal-v234.html
· [绿] ① [VER] school index 指向新版 — 期望: maxhouse-school-portal-v234.html | 实际: 已指向 (用时 0s)
· 轮询 admin index: https://www.maxhouses.net/admin-portal/ → 期待指向 maxhouse-admin-portal-v218.html (CF Access 后, 预期挡)
· [N/A] ① [VER] admin index 指向新版 — 期望: maxhouse-admin-portal-v218.html | 实际: http 302, 实际=未识别
· 轮询 reviewer index: https://www.maxhouses.net/reviewer-portal/ → 期待指向 maxhouse-reviewer-portal-v45.html (CF Access 后, 预期挡)
· [N/A] ① [VER] reviewer index 指向新版 — 期望: maxhouse-reviewer-portal-v45.html | 实际: http 302, 实际=未识别
· [绿] ② schX 登中介端被拒(v167 判据) — 期望: body 仍锁 + 会话为空 + 无机构内容 | 实际: 被拒(locked=true, session=false, 机构内容=false, 见拒绝文案)
· [绿] ② schX 登入后无 partner_bootstrap 请求 — 期望: v167 下 hydratePartner/bootstrap 请求=0 | 实际: 0 次
· [绿] ② schX 走查 0 未捕获报错 — 期望: pageerror = 0 | 实际: pageerror ×0
· partner1 已真登线上中介端。
· [绿] ③ [VER]=v167 (console) — 期望: console 打印 partner portal v167 | 实际: 命中
· [N/A] ③ Q1 提醒卡片(有现成场景) — 期望: 有现成 Q1 场景才量卡片样式 | 实际: 登入后页面无现成 Q1 告警卡/条 → 有才判, 本次不判(N/A); 不主动触发上传避免写库
· [N/A] ③ 中介端仪表盘公开截图 — 期望: 不外泄机构身份/被推荐学生 PII | 实际: 按零信任红线不产出公开截图(证据在红绿表) — 见回执
· [绿] ③ 中介端 0 未捕获报错 — 期望: pageerror = 0 | 实际: pageerror ×0
· 截图索引已写: /Users/maxhouse/mh-jobs/shots/20/walk/INDEX.md
```

_由 online-walk.mjs 自动写出; 跑完一律 exit 0; 公钥读环境变量, 不打印任何 token/密码; 公开截图文本样式脱敏; 写完自动过 secret-scan + git add 点名 + commit + push。_
