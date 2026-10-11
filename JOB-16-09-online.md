# JOB-16-09 线上走查回执 (LIVE)

> 业主在卡1119 末尾跑; Chromium --no-proxy-server; 学生端/中介端不在 Cloudflare Access 后。

小结: 绿 10 / 红 2 —— 红项见下表, 业主逐条核。

| 步骤 | 期望 | 实际 | 红绿 |
|---|---|---|---|
| ① 学生端 index 指向新版 | maxhouse_student_portal_v396 | 已指向 (用时 4s) | 绿 |
| ① 中介端 index 指向新版 | maxhouse-partner-portal-v163 | 已指向 (用时 0s) | 绿 |
| ② [VER]=v396 | console 打印 [VER] … student portal v396 | 命中 | 绿 |
| ② CV 槽无 mh10-test | 整页无 mh10 死图残留 | 页面无 mh10 | 绿 |
| ② 上传成功+即判 | ai now 1 sent 1 got & precheck-ai=200 | ai:未见 | precheck:无 | 红 |
| ② 刷新后状态仍在 | 刷新后 recommendation 槽仍显示已上传件 | 刷新后未见 | 红 |
| ② 界面删除测试件 | 在界面删除刚上传的测试件 | 已点删除(业主复核界面已消失) | 绿 |
| ② 学生端 0 未捕获报错 | pageerror = 0 | pageerror ×0 | 绿 |
| ③ [VER]=v163 | console 打印 [VER] … partner portal v163 | 命中 | 绿 |
| ③ 「邀请学生自传」按钮 | 可见且点得开(不提交) | 可见:true 点开:true | 绿 |
| ③ 页面邀请数 = truth | = 库真值 truth(10) | 页面 10 | 绿 |
| ③ 中介端 0 未捕获报错 | pageerror = 0 | pageerror ×0 | 绿 |

## 全程日志
```
· === JOB-16-09 线上走查开始 (LIVE) ===
· 轮询 学生端 index: https://www.maxhouses.net/student-portal/ → 期待指向 maxhouse_student_portal_v396
· [绿] ① 学生端 index 指向新版 — 期望: maxhouse_student_portal_v396 | 实际: 已指向 (用时 4s)
· 轮询 中介端 index: https://www.maxhouses.net/partner-portal/ → 期待指向 maxhouse-partner-portal-v163
· [绿] ① 中介端 index 指向新版 — 期望: maxhouse-partner-portal-v163 | 实际: 已指向 (用时 0s)
· 学生A 已真登线上学生端主界面。
· [绿] ② [VER]=v396 — 期望: console 打印 [VER] … student portal v396 | 实际: 命中
· [绿] ② CV 槽无 mh10-test — 期望: 整页无 mh10 死图残留 | 实际: 页面无 mh10
· [红] ② 上传成功+即判 — 期望: ai now 1 sent 1 got & precheck-ai=200 | 实际: ai:未见 | precheck:无
· [红] ② 刷新后状态仍在 — 期望: 刷新后 recommendation 槽仍显示已上传件 | 实际: 刷新后未见
· [绿] ② 界面删除测试件 — 期望: 在界面删除刚上传的测试件 | 实际: 已点删除(业主复核界面已消失)
· [绿] ② 学生端 0 未捕获报错 — 期望: pageerror = 0 | 实际: pageerror ×0
· partner1 已真登线上中介端主界面。
· [绿] ③ [VER]=v163 — 期望: console 打印 [VER] … partner portal v163 | 实际: 命中
· [绿] ③ 「邀请学生自传」按钮 — 期望: 可见且点得开(不提交) | 实际: 可见:true 点开:true
· [绿] ③ 页面邀请数 = truth — 期望: = 库真值 truth(10) | 实际: 页面 10
· [绿] ③ 中介端 0 未捕获报错 — 期望: pageerror = 0 | 实际: pageerror ×0
```

_本回执由 online-walk.mjs 自动写出; 跑完一律 exit 0, 不中断业主的卡。_
