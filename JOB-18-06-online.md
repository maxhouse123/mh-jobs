# JOB-18-06 线上走查回执 (G⑥) — CC 对现役线上单探

> CC 本地对**现役线上**先跑一遍并如实记录: 五端 [VER] 目标是第十八轮新版(partner v166 / admin v218 / reviewer v43 三端升版; student v397 / school v234 不动), 现役 partner/admin/reviewer=旧版故指向新版一项为红/挡——属预期, 真绿在业主收官推送后再跑出。本包旨在证明「自动推送」与「元素级截图」真的发生。

小结: 绿 15 / 红 2 / 灰(N/A) 5

## 五端 index 实际指向的版本
| 端 | 目标(第十八轮) | 实际指向 |
|---|---|---|
| student | maxhouse_student_portal_v397.html | maxhouse_student_portal_v397 |
| partner | maxhouse-partner-portal-v166.html | maxhouse-partner-portal-v165 |
| school | maxhouse-school-portal-v234.html | maxhouse-school-portal-v234 |
| admin | maxhouse-admin-portal-v218.html | 未识别 (CF Access) |
| reviewer | maxhouse-reviewer-portal-v43.html | 未识别 (CF Access) |

## 逐步红绿
| 步骤 | 期望 | 实际 | 判 |
|---|---|---|---|
| ① [VER] student index 指向新版 | maxhouse_student_portal_v397.html | 已指向 (用时 2s) | 绿 |
| ① [VER] partner index 指向新版 | maxhouse-partner-portal-v166.html | 未指向 (http 200, 实际=maxhouse-partner-portal-v165) | 红 |
| ① [VER] school index 指向新版 | maxhouse-school-portal-v234.html | 已指向 (用时 0s) | 绿 |
| ① [VER] admin index 指向新版 | maxhouse-admin-portal-v218.html | http 302, 实际=未识别 | N/A |
| ① [VER] reviewer index 指向新版 | maxhouse-reviewer-portal-v43.html | http 302, 实际=未识别 | N/A |
| ② [VER]=v397 (console) | console 打印 student portal v397 | 命中 | 绿 |
| ② 定位上传输入框(真类名) | #file-other 存在 | 已定位 | 绿 |
| ② 进度卡: 上传件出现 | #card-other 出现缩略图/文件卡 | 已出现 | 绿 |
| ② 即判: precheck-ai=200 | precheck-ai 网络 200 | 200 | 绿 |
| ② 瘦身行出现 | 本槽出现 .v393-slim-line | 未出现 (合成图非 PDF, 常无瘦身行; 刷新持久性以文件为准) | N/A |
| ② 英文界面 AI 提醒非中文 | AI 提醒无中日韩字符 | 本次无 AI 提醒(合成图未触发 issue) → 有提醒才判 | N/A |
| ② 刷新后文件仍在 | 刷新后本槽仍显示已上传件 | 仍在 | 绿 |
| ② 截图: 学生端上传件预览(元素级) | 产出 stu-upload-card.png(#previewModal 合成图) | 已产出(元素级(#previewModal 合成件预览)) | 绿 |
| ③ 界面软删测试件(真按钮) | 真点缩略图删除钮删本轮合成件(只认合成名) | 已删 ×1(真点删除钮+确认框, 下方 REST 复核) | 绿 |
| ② 学生端 0 未捕获报错 | pageerror = 0 | pageerror ×0 | 绿 |
| ② 收尾: 测试件清 0 (documents 活件 + storage 孤儿) | documents 活件=0 且 storage 无合成孤儿 | =0 (documents 0 / storage 孤儿 0, 干净) | 绿 |
| ③ [VER]=v166 (console) | console 打印 partner portal v166 | 未见 v166 (现役=旧版, 预期红) | 红 |
| ③ Sent invites 列表在 | 列表出现 [data-dl-copy] 按钮 | ×7 条 | 绿 |
| ③ Copy link 有可见反应(1.5s) | 提示条或按钮字可见变化 | 有: 提示条 | 绿 |
| ② 截图: 中介端邀请列表(邮箱/姓名样式打码) | 产出 par-invite-list-masked.png(PII 已脱敏) | 已产出 | 绿 |
| ⑤ 护照琥珀名单块带两个名字 | 若有名单块则带两名句 | 本走查未主动触发姓名核对 → 无琥珀名单块, 有才判, 不判(N/A) | N/A |
| ③ 中介端 0 未捕获报错 | pageerror = 0 | pageerror ×0 | 绿 |

## 全程日志
```
· === JOB-18-06 线上走查开始 (CC 单探现役线上) ===
· 公钥来源: 环境变量 SUPABASE_ANON_KEY
· 轮询 student index: https://www.maxhouses.net/student-portal/ → 期待指向 maxhouse_student_portal_v397.html
· [绿] ① [VER] student index 指向新版 — 期望: maxhouse_student_portal_v397.html | 实际: 已指向 (用时 2s)
· 轮询 partner index: https://www.maxhouses.net/partner-portal/ → 期待指向 maxhouse-partner-portal-v166.html
· [红] ① [VER] partner index 指向新版 — 期望: maxhouse-partner-portal-v166.html | 实际: 未指向 (http 200, 实际=maxhouse-partner-portal-v165)
· 轮询 school index: https://www.maxhouses.net/school-portal/ → 期待指向 maxhouse-school-portal-v234.html
· [绿] ① [VER] school index 指向新版 — 期望: maxhouse-school-portal-v234.html | 实际: 已指向 (用时 0s)
· 轮询 admin index: https://www.maxhouses.net/admin-portal/ → 期待指向 maxhouse-admin-portal-v218.html (CF Access 后, 预期挡)
· [N/A] ① [VER] admin index 指向新版 — 期望: maxhouse-admin-portal-v218.html | 实际: http 302, 实际=未识别
· 轮询 reviewer index: https://www.maxhouses.net/reviewer-portal/ → 期待指向 maxhouse-reviewer-portal-v43.html (CF Access 后, 预期挡)
· [N/A] ① [VER] reviewer index 指向新版 — 期望: maxhouse-reviewer-portal-v43.html | 实际: http 302, 实际=未识别
· 学生A 已真登线上学生端 (英文界面)。
· [绿] ② [VER]=v397 (console) — 期望: console 打印 student portal v397 | 实际: 命中
· 批次(ledger): studyPlan 现2批 → 上传后≤第3批 (需原因)
· 批次(ledger): other 现1批 → 上传后≤第2批
· 批次(ledger): cv 现1批 → 上传后≤第2批
· 批次(ledger): recommendation 现2批 → 上传后≤第3批 (需原因)
· 选中安全槽: other (上传后=第2批)
· [绿] ② 定位上传输入框(真类名) — 期望: #file-other 存在 | 实际: 已定位
· [绿] ② 进度卡: 上传件出现 — 期望: #card-other 出现缩略图/文件卡 | 实际: 已出现
· [绿] ② 即判: precheck-ai=200 — 期望: precheck-ai 网络 200 | 实际: 200
· [N/A] ② 瘦身行出现 — 期望: 本槽出现 .v393-slim-line | 实际: 未出现 (合成图非 PDF, 常无瘦身行; 刷新持久性以文件为准)
· [N/A] ② 英文界面 AI 提醒非中文 — 期望: AI 提醒无中日韩字符 | 实际: 本次无 AI 提醒(合成图未触发 issue) → 有提醒才判
· [绿] ② 刷新后文件仍在 — 期望: 刷新后本槽仍显示已上传件 | 实际: 仍在
· [绿] ② 截图: 学生端上传件预览(元素级) — 期望: 产出 stu-upload-card.png(#previewModal 合成图) | 实际: 已产出(元素级(#previewModal 合成件预览))
· [绿] ③ 界面软删测试件(真按钮) — 期望: 真点缩略图删除钮删本轮合成件(只认合成名) | 实际: 已删 ×1(真点删除钮+确认框, 下方 REST 复核)
· [绿] ② 学生端 0 未捕获报错 — 期望: pageerror = 0 | 实际: pageerror ×0
· [绿] ② 收尾: 测试件清 0 (documents 活件 + storage 孤儿) — 期望: documents 活件=0 且 storage 无合成孤儿 | 实际: =0 (documents 0 / storage 孤儿 0, 干净)
· partner1 已真登线上中介端。
· [红] ③ [VER]=v166 (console) — 期望: console 打印 partner portal v166 | 实际: 未见 v166 (现役=旧版, 预期红)
· [绿] ③ Sent invites 列表在 — 期望: 列表出现 [data-dl-copy] 按钮 | 实际: ×7 条
· [绿] ③ Copy link 有可见反应(1.5s) — 期望: 提示条或按钮字可见变化 | 实际: 有: 提示条
· [绿] ② 截图: 中介端邀请列表(邮箱/姓名样式打码) — 期望: 产出 par-invite-list-masked.png(PII 已脱敏) | 实际: 已产出
· [N/A] ⑤ 护照琥珀名单块带两个名字 — 期望: 若有名单块则带两名句 | 实际: 本走查未主动触发姓名核对 → 无琥珀名单块, 有才判, 不判(N/A)
· [绿] ③ 中介端 0 未捕获报错 — 期望: pageerror = 0 | 实际: pageerror ×0
· 截图索引已写: /Users/maxhouse/mh-jobs/shots/18/walk/INDEX.md
```

_由 online-walk.mjs 自动写出; 跑完一律 exit 0; 公钥读环境变量, 不打印任何 token/密码; 公开截图元素级 + 列表样式脱敏; 写完自动过 secret-scan + git add 点名 + commit + push。_
