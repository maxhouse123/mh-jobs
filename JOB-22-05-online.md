# JOB-21-05 线上走查回执 (版本表自动化) — CC 对现役线上单探

> 期望版本 = **主仓库 <portal>/index.html 当前指向**(自动读, 不再手写)。线上 index 与主仓库不一致才判红。
> 主仓库领先线上(本轮已提交未推的版本, 如 partner v169)时该端判红属预期——正是本自动化要暴露的「仓库改了、线上还没上」信号。
> admin/reviewer 在 CF Access 后, index 探不到版本 → 记 N/A(挡)。

小结: 绿 14 / 红 7 / 灰(N/A) 12

## 五端 index：主仓库指向 vs 线上实际
| 端 | 主仓库 index 指向(期望) | 线上实际指向 |
|---|---|---|
| student | maxhouse_student_portal_v400 | maxhouse_student_portal_v399 |
| partner | maxhouse-partner-portal-v170 | maxhouse-partner-portal-v169 |
| school | maxhouse-school-portal-v235 | maxhouse-school-portal-v234 |
| admin | maxhouse-admin-portal-v219 | 未识别 (CF Access) |
| reviewer | maxhouse-reviewer-portal-v46 | 未识别 (CF Access) |

## 逐步红绿
| 步骤 | 期望 | 实际 | 判 |
|---|---|---|---|
| ① [VER] student index 指向主仓库版本 | maxhouse_student_portal_v400.html | 线上≠主仓库 (http 200, 实际=maxhouse_student_portal_v399) — 主仓库领先线上(未推/未部署)时预期红 | 红 |
| ① [VER] partner index 指向主仓库版本 | maxhouse-partner-portal-v170.html | 线上≠主仓库 (http 200, 实际=maxhouse-partner-portal-v169) — 主仓库领先线上(未推/未部署)时预期红 | 红 |
| ① [VER] school index 指向主仓库版本 | maxhouse-school-portal-v235.html | 线上≠主仓库 (http 200, 实际=maxhouse-school-portal-v234) — 主仓库领先线上(未推/未部署)时预期红 | 红 |
| ① [VER] admin index 指向主仓库版本 | maxhouse-admin-portal-v219.html | http 302, 实际=未识别 | N/A |
| ① [VER] reviewer index 指向主仓库版本 | maxhouse-reviewer-portal-v46.html | http 302, 实际=未识别 | N/A |
| ④ 字体 assets/fonts/manrope-400.woff2 无 Link | 无 Link 头 | status 200, 无 Link | 绿 |
| ④ student 根地址有 Link | Link 头存在 | status 200, 有 Link=<https://uexgzwfambanvhdhxome.supabase.co>; re… | 绿 |
| ④ student 版本文件有 Link | Link 头存在 | status 404, 有 Link=<https://uexgzwfambanvhdhxome.supabase.co>; re… | 绿 |
| ④ student vendor/supabase.js 无 Link | 无 Link 头 | status 200, 有 Link=<https://uexgzwfambanvhdhxome.supabase.co>; re… — 22-01 未部署前 vendor/字体 仍带 Link 属预期红(部署后转绿) | 红 |
| ④ partner 根地址有 Link | Link 头存在 | status 200, 有 Link=<https://uexgzwfambanvhdhxome.supabase.co>; re… | 绿 |
| ④ partner 版本文件有 Link | Link 头存在 | status 404, 有 Link=<https://uexgzwfambanvhdhxome.supabase.co>; re… | 绿 |
| ④ partner vendor/supabase.js 无 Link | 无 Link 头 | status 200, 有 Link=<https://uexgzwfambanvhdhxome.supabase.co>; re… — 22-01 未部署前 vendor/字体 仍带 Link 属预期红(部署后转绿) | 红 |
| ④ school 根地址有 Link | Link 头存在 | status 200, 有 Link=<https://uexgzwfambanvhdhxome.supabase.co>; re… | 绿 |
| ④ school 版本文件有 Link | Link 头存在 | status 404, 有 Link=<https://uexgzwfambanvhdhxome.supabase.co>; re… | 绿 |
| ④ school vendor/supabase.js 无 Link | 无 Link 头 | status 200, 有 Link=<https://uexgzwfambanvhdhxome.supabase.co>; re… — 22-01 未部署前 vendor/字体 仍带 Link 属预期红(部署后转绿) | 红 |
| ④ admin 根地址有 Link | 有 Link | CF Access 挡(status 302, →https://maxhouseapp.cloudflareaccess.com) → N/A | N/A |
| ④ admin 版本文件有 Link | 有 Link | CF Access 挡(status 302, →https://maxhouseapp.cloudflareaccess.com) → N/A | N/A |
| ④ admin vendor/supabase.js 无 Link | 无 Link | CF Access 挡(status 302, →https://maxhouseapp.cloudflareaccess.com) → N/A | N/A |
| ④ reviewer 根地址有 Link | 有 Link | CF Access 挡(status 302, →https://maxhouseapp.cloudflareaccess.com) → N/A | N/A |
| ④ reviewer 版本文件有 Link | 有 Link | CF Access 挡(status 302, →https://maxhouseapp.cloudflareaccess.com) → N/A | N/A |
| ④ reviewer vendor/supabase.js 无 Link | 无 Link | CF Access 挡(status 302, →https://maxhouseapp.cloudflareaccess.com) → N/A | N/A |
| ⑤ student 无 preload 告警 | 控制台 0 条 preloaded-but-not-used | 0 条 | 绿 |
| ⑤ partner 无 preload 告警 | 控制台 0 条 preloaded-but-not-used | 0 条 | 绿 |
| ⑤ school 无 preload 告警 | 控制台 0 条 preloaded-but-not-used | 0 条 | 绿 |
| ⑤ admin 无 preload 告警 | 控制台无 preloaded-but-not-used | CF Access 后无头进不去 → N/A | N/A |
| ⑤ reviewer 无 preload 告警 | 控制台无 preloaded-but-not-used | CF Access 后无头进不去 → N/A | N/A |
| ② schX 登中介端被拒(v167 判据) | body 仍锁 + 会话为空 + 无机构内容 | 被拒(locked=true, session=false, 机构内容=false, 见拒绝文案) | 绿 |
| ② schX 登入后无 partner_bootstrap 请求 | v167 下 hydratePartner/bootstrap 请求=0 | 0 次 | 绿 |
| ② schX 走查 0 未捕获报错 | pageerror = 0 | pageerror ×0 | 绿 |
| ③ [VER] partner console == 主仓库版本 (maxhouse-partner-portal-v170) | console 打印与主仓库 index 同版 | 未见该版 (线上落后主仓库时预期红) | 红 |
| ③ Q1 提醒卡片(有现成场景) | 有现成 Q1 场景才量卡片样式 | 登入后页面无现成 Q1 告警卡/条 → 有才判, 本次不判(N/A); 不主动触发上传避免写库 | N/A |
| ③ 中介端仪表盘公开截图 | 不外泄机构身份/被推荐学生 PII | 按零信任红线不产出公开截图(证据在红绿表) — 见回执 | N/A |
| ③ 中介端 0 未捕获报错 | pageerror = 0 | pageerror ×0 | 绿 |

## 全程日志
```
· === JOB-22-05 线上走查开始 (CC 单探现役线上) ===
· 公钥来源: env.mjs 公开 anon(回落)
· 轮询 student index: https://www.maxhouses.net/student-portal/ → 期待指向主仓库当前版本 maxhouse_student_portal_v400.html
· [红] ① [VER] student index 指向主仓库版本 — 期望: maxhouse_student_portal_v400.html | 实际: 线上≠主仓库 (http 200, 实际=maxhouse_student_portal_v399) — 主仓库领先线上(未推/未部署)时预期红
· 轮询 partner index: https://www.maxhouses.net/partner-portal/ → 期待指向主仓库当前版本 maxhouse-partner-portal-v170.html
· [红] ① [VER] partner index 指向主仓库版本 — 期望: maxhouse-partner-portal-v170.html | 实际: 线上≠主仓库 (http 200, 实际=maxhouse-partner-portal-v169) — 主仓库领先线上(未推/未部署)时预期红
· 轮询 school index: https://www.maxhouses.net/school-portal/ → 期待指向主仓库当前版本 maxhouse-school-portal-v235.html
· [红] ① [VER] school index 指向主仓库版本 — 期望: maxhouse-school-portal-v235.html | 实际: 线上≠主仓库 (http 200, 实际=maxhouse-school-portal-v234) — 主仓库领先线上(未推/未部署)时预期红
· 轮询 admin index: https://www.maxhouses.net/admin-portal/ → 期待指向主仓库当前版本 maxhouse-admin-portal-v219.html (CF Access 后, 预期挡)
· [N/A] ① [VER] admin index 指向主仓库版本 — 期望: maxhouse-admin-portal-v219.html | 实际: http 302, 实际=未识别
· 轮询 reviewer index: https://www.maxhouses.net/reviewer-portal/ → 期待指向主仓库当前版本 maxhouse-reviewer-portal-v46.html (CF Access 后, 预期挡)
· [N/A] ① [VER] reviewer index 指向主仓库版本 — 期望: maxhouse-reviewer-portal-v46.html | 实际: http 302, 实际=未识别
· ④ _headers Link 归属检查(网页文档应有 Link; vendor/supabase.js 与 assets/fonts 应无 Link)
· [绿] ④ 字体 assets/fonts/manrope-400.woff2 无 Link — 期望: 无 Link 头 | 实际: status 200, 无 Link
· [绿] ④ student 根地址有 Link — 期望: Link 头存在 | 实际: status 200, 有 Link=<https://uexgzwfambanvhdhxome.supabase.co>; re…
· [绿] ④ student 版本文件有 Link — 期望: Link 头存在 | 实际: status 404, 有 Link=<https://uexgzwfambanvhdhxome.supabase.co>; re…
· [红] ④ student vendor/supabase.js 无 Link — 期望: 无 Link 头 | 实际: status 200, 有 Link=<https://uexgzwfambanvhdhxome.supabase.co>; re… — 22-01 未部署前 vendor/字体 仍带 Link 属预期红(部署后转绿)
· [绿] ④ partner 根地址有 Link — 期望: Link 头存在 | 实际: status 200, 有 Link=<https://uexgzwfambanvhdhxome.supabase.co>; re…
· [绿] ④ partner 版本文件有 Link — 期望: Link 头存在 | 实际: status 404, 有 Link=<https://uexgzwfambanvhdhxome.supabase.co>; re…
· [红] ④ partner vendor/supabase.js 无 Link — 期望: 无 Link 头 | 实际: status 200, 有 Link=<https://uexgzwfambanvhdhxome.supabase.co>; re… — 22-01 未部署前 vendor/字体 仍带 Link 属预期红(部署后转绿)
· [绿] ④ school 根地址有 Link — 期望: Link 头存在 | 实际: status 200, 有 Link=<https://uexgzwfambanvhdhxome.supabase.co>; re…
· [绿] ④ school 版本文件有 Link — 期望: Link 头存在 | 实际: status 404, 有 Link=<https://uexgzwfambanvhdhxome.supabase.co>; re…
· [红] ④ school vendor/supabase.js 无 Link — 期望: 无 Link 头 | 实际: status 200, 有 Link=<https://uexgzwfambanvhdhxome.supabase.co>; re… — 22-01 未部署前 vendor/字体 仍带 Link 属预期红(部署后转绿)
· [N/A] ④ admin 根地址有 Link — 期望: 有 Link | 实际: CF Access 挡(status 302, →https://maxhouseapp.cloudflareaccess.com) → N/A
· [N/A] ④ admin 版本文件有 Link — 期望: 有 Link | 实际: CF Access 挡(status 302, →https://maxhouseapp.cloudflareaccess.com) → N/A
· [N/A] ④ admin vendor/supabase.js 无 Link — 期望: 无 Link | 实际: CF Access 挡(status 302, →https://maxhouseapp.cloudflareaccess.com) → N/A
· [N/A] ④ reviewer 根地址有 Link — 期望: 有 Link | 实际: CF Access 挡(status 302, →https://maxhouseapp.cloudflareaccess.com) → N/A
· [N/A] ④ reviewer 版本文件有 Link — 期望: 有 Link | 实际: CF Access 挡(status 302, →https://maxhouseapp.cloudflareaccess.com) → N/A
· [N/A] ④ reviewer vendor/supabase.js 无 Link — 期望: 无 Link | 实际: CF Access 挡(status 302, →https://maxhouseapp.cloudflareaccess.com) → N/A
· ⑤ 控制台预加载告警检查(五端真页面无头启动)
· [绿] ⑤ student 无 preload 告警 — 期望: 控制台 0 条 preloaded-but-not-used | 实际: 0 条
· [绿] ⑤ partner 无 preload 告警 — 期望: 控制台 0 条 preloaded-but-not-used | 实际: 0 条
· [绿] ⑤ school 无 preload 告警 — 期望: 控制台 0 条 preloaded-but-not-used | 实际: 0 条
· [N/A] ⑤ admin 无 preload 告警 — 期望: 控制台无 preloaded-but-not-used | 实际: CF Access 后无头进不去 → N/A
· [N/A] ⑤ reviewer 无 preload 告警 — 期望: 控制台无 preloaded-but-not-used | 实际: CF Access 后无头进不去 → N/A
· [绿] ② schX 登中介端被拒(v167 判据) — 期望: body 仍锁 + 会话为空 + 无机构内容 | 实际: 被拒(locked=true, session=false, 机构内容=false, 见拒绝文案)
· [绿] ② schX 登入后无 partner_bootstrap 请求 — 期望: v167 下 hydratePartner/bootstrap 请求=0 | 实际: 0 次
· [绿] ② schX 走查 0 未捕获报错 — 期望: pageerror = 0 | 实际: pageerror ×0
· partner1 已真登线上中介端。
· [红] ③ [VER] partner console == 主仓库版本 (maxhouse-partner-portal-v170) — 期望: console 打印与主仓库 index 同版 | 实际: 未见该版 (线上落后主仓库时预期红)
· [N/A] ③ Q1 提醒卡片(有现成场景) — 期望: 有现成 Q1 场景才量卡片样式 | 实际: 登入后页面无现成 Q1 告警卡/条 → 有才判, 本次不判(N/A); 不主动触发上传避免写库
· [N/A] ③ 中介端仪表盘公开截图 — 期望: 不外泄机构身份/被推荐学生 PII | 实际: 按零信任红线不产出公开截图(证据在红绿表) — 见回执
· [绿] ③ 中介端 0 未捕获报错 — 期望: pageerror = 0 | 实际: pageerror ×0
· 截图索引已写: /Users/maxhouse/mh-jobs/shots/22/walk/INDEX.md
```

_由 online-walk.mjs 自动写出; 跑完一律 exit 0; 公钥读环境变量, 不打印任何 token/密码; 公开截图文本样式脱敏; 写完自动过 secret-scan + git add 点名 + commit + push。_
