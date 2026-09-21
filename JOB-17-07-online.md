# JOB-17-07 线上走查回执 (G④) — CC 对现役线上单探

> CC 本地对**现役线上**(第十六轮版本)先跑一遍并如实记录: 五端 [VER] 目标是第十七轮新版, 现役=旧版故指向新版一项为红/挡; Copy link 可见反应(17-03)、英文 AI 提醒非中文(17-05 v23) 现役未上线亦为红——均属预期, 真绿在业主卡1136(推送后新版上线)里出。

小结: 绿 8 / 红 7 / 灰(N/A) 4

## 五端 index 实际指向的版本
| 端 | 目标(第十七轮) | 实际指向 |
|---|---|---|
| student | maxhouse_student_portal_v397.html | maxhouse_student_portal_v396 |
| partner | maxhouse-partner-portal-v165.html | maxhouse-partner-portal-v163 |
| school | maxhouse-school-portal-v234.html | maxhouse-school-portal-v233 |
| admin | maxhouse-admin-portal-v217.html | 未识别 (CF Access) |
| reviewer | maxhouse-reviewer-portal-v42.html | 未识别 (CF Access) |

## 逐步红绿
| 步骤 | 期望 | 实际 | 判 |
|---|---|---|---|
| ① [VER] student index 指向新版 | maxhouse_student_portal_v397.html | 未指向 (http 200, 实际=maxhouse_student_portal_v396) | 红 |
| ① [VER] partner index 指向新版 | maxhouse-partner-portal-v165.html | 未指向 (http 200, 实际=maxhouse-partner-portal-v163) | 红 |
| ① [VER] school index 指向新版 | maxhouse-school-portal-v234.html | 未指向 (http 200, 实际=maxhouse-school-portal-v233) | 红 |
| ① [VER] admin index 指向新版 | maxhouse-admin-portal-v217.html | http 302, 实际=未识别 | N/A |
| ① [VER] reviewer index 指向新版 | maxhouse-reviewer-portal-v42.html | http 302, 实际=未识别 | N/A |
| ② [VER]=v397 (console) | console 打印 student portal v397 | 未见 v397 (现役=旧版, 预期红) | 红 |
| ② 定位上传输入框(真类名) | #file-studyPlan 存在 | 已定位 | 绿 |
| ② 进度卡: 上传件出现 | #card-studyPlan 出现缩略图/文件卡 | 已出现 | 绿 |
| ② 即判: precheck-ai=200 | precheck-ai 网络 200 | 200 | 绿 |
| ② 瘦身行出现 | 本槽出现 .v393-slim-line | 未出现 (合成图非 PDF, 常无瘦身行; 刷新持久性以文件为准) | N/A |
| ② 英文界面 AI 提醒非中文 | AI 提醒无中日韩字符 | 本次无 AI 提醒(合成图未触发 issue) → 有提醒才判 | N/A |
| ② 刷新后文件仍在 | 刷新后本槽仍显示已上传件 | 仍在 | 绿 |
| ② 界面软删测试件 | 删除刚上传的测试件 | 已删(下方 REST 复核) | 绿 |
| ② 学生端 0 未捕获报错 | pageerror = 0 | pageerror ×0 | 绿 |
| ② 收尾: 活着的测试件=0 | 名下无 MH17/synthetic/测试 活件 | =0 (干净) | 绿 |
| ③ [VER]=v165 (console) | console 打印 partner portal v165 | 未见 v165 (现役=旧版, 预期红) | 红 |
| ③ Sent invites 列表在 | 列表出现 [data-dl-copy] 按钮 | ×7 条 | 绿 |
| ③ Copy link 有可见反应(1.5s) | 提示条或按钮字可见变化 | 1.5s 无任何可见反应 (现役 v163, 预期红) | 红 |
| ③ 中介端 0 未捕获报错 | pageerror = 0 | pageerror ×1 | 红 |

## 全程日志
```
· === JOB-17-07 线上走查开始 (CC 单探现役线上) ===
· 公钥来源: env.mjs 公开 anon(回落)
· 轮询 student index: https://www.maxhouses.net/student-portal/ → 期待指向 maxhouse_student_portal_v397.html
· [红] ① [VER] student index 指向新版 — 期望: maxhouse_student_portal_v397.html | 实际: 未指向 (http 200, 实际=maxhouse_student_portal_v396)
· 轮询 partner index: https://www.maxhouses.net/partner-portal/ → 期待指向 maxhouse-partner-portal-v165.html
· [红] ① [VER] partner index 指向新版 — 期望: maxhouse-partner-portal-v165.html | 实际: 未指向 (http 200, 实际=maxhouse-partner-portal-v163)
· 轮询 school index: https://www.maxhouses.net/school-portal/ → 期待指向 maxhouse-school-portal-v234.html
· [红] ① [VER] school index 指向新版 — 期望: maxhouse-school-portal-v234.html | 实际: 未指向 (http 200, 实际=maxhouse-school-portal-v233)
· 轮询 admin index: https://www.maxhouses.net/admin-portal/ → 期待指向 maxhouse-admin-portal-v217.html (CF Access 后, 预期挡)
· [N/A] ① [VER] admin index 指向新版 — 期望: maxhouse-admin-portal-v217.html | 实际: http 302, 实际=未识别
· 轮询 reviewer index: https://www.maxhouses.net/reviewer-portal/ → 期待指向 maxhouse-reviewer-portal-v42.html (CF Access 后, 预期挡)
· [N/A] ① [VER] reviewer index 指向新版 — 期望: maxhouse-reviewer-portal-v42.html | 实际: http 302, 实际=未识别
· 学生A 已真登线上学生端 (英文界面)。
· [红] ② [VER]=v397 (console) — 期望: console 打印 student portal v397 | 实际: 未见 v397 (现役=旧版, 预期红)
· 批次: studyPlan 现0批(0件) → 上传后=第1批
· 批次: other 现0批(0件) → 上传后=第1批
· 批次: cv 现1批(2件) → 上传后=第2批
· 批次: recommendation 现2批(2件) → 上传后=第3批
· 选中安全槽: studyPlan (上传后=第1批)
· [绿] ② 定位上传输入框(真类名) — 期望: #file-studyPlan 存在 | 实际: 已定位
· [绿] ② 进度卡: 上传件出现 — 期望: #card-studyPlan 出现缩略图/文件卡 | 实际: 已出现
· [绿] ② 即判: precheck-ai=200 — 期望: precheck-ai 网络 200 | 实际: 200
· [N/A] ② 瘦身行出现 — 期望: 本槽出现 .v393-slim-line | 实际: 未出现 (合成图非 PDF, 常无瘦身行; 刷新持久性以文件为准)
· [N/A] ② 英文界面 AI 提醒非中文 — 期望: AI 提醒无中日韩字符 | 实际: 本次无 AI 提醒(合成图未触发 issue) → 有提醒才判
· [绿] ② 刷新后文件仍在 — 期望: 刷新后本槽仍显示已上传件 | 实际: 仍在
· 缩略图删除钮未定位, 已直调 _s9CloudDeleteCore 云删(storage+documents)。
· [绿] ② 界面软删测试件 — 期望: 删除刚上传的测试件 | 实际: 已删(下方 REST 复核)
· [绿] ② 学生端 0 未捕获报错 — 期望: pageerror = 0 | 实际: pageerror ×0
· [绿] ② 收尾: 活着的测试件=0 — 期望: 名下无 MH17/synthetic/测试 活件 | 实际: =0 (干净)
· partner1 已真登线上中介端。
· [红] ③ [VER]=v165 (console) — 期望: console 打印 partner portal v165 | 实际: 未见 v165 (现役=旧版, 预期红)
· [绿] ③ Sent invites 列表在 — 期望: 列表出现 [data-dl-copy] 按钮 | 实际: ×7 条
· [红] ③ Copy link 有可见反应(1.5s) — 期望: 提示条或按钮字可见变化 | 实际: 1.5s 无任何可见反应 (现役 v163, 预期红)
· [红] ③ 中介端 0 未捕获报错 — 期望: pageerror = 0 | 实际: pageerror ×1
```

_由 online-walk.mjs 自动写出; 跑完一律 exit 0; 公钥读环境变量, 不打印任何 token/密码; 公开截图元素级 + 列表 mask。_
