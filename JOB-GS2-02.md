# JOB-GS2-02 回执 · 第三所演示校 guide_sch3

日期 2026-10-06 ｜ 无人值守会话 ｜ 只新建并操作 guide_sch3 一所演示校

## 一句话
新开了第三所演示学校「演示大学三号 / Demo University 3」（测试校），用来录第 1 章「新校注册→完善资料→审核中→已通过」和第 3 章「从零建任务」。给它写了两个一键切换的状态脚本：一个把它恢复到「刚注册、资料没填」，另一个把它切到「资料齐全、平台已审核通过、标准等级、还没任务」。两个脚本各跑两遍结果都一样。

## 具体做了什么
1. **真注册账号**：在学校端真注册页用演示邀请码注册了 `maxhouseapp+guide-sch3@gmail.com`，校名「Demo University 3」，系统自动给了编号 SCH-5CBD28。密码只写进本机 `~/mh-verify/accounts.json` 的 guide_sch3 键（不进截图、回执、仓库）。
2. **两个状态脚本**（都幂等、跑完自检打印 OK）：
   - `st-sch3-fresh.sh` → 「已注册·未完善资料」：onboarding 状态、资料未提交、无等级、0 任务、清掉旧通知横幅、打开邮箱门。登录后看到的是**「完善学校资料」表单页**（填学校中英文名/官网/城市/Logo/联系人 + 上传验证材料），顶上「资料未完成」角标。
   - `st-sch3-approved.sh` → 「已审核通过」：补齐资料（SPECIMEN 演示值）+ 提交 + 管理员审核通过(active) + 等级标准(20) + 0 任务。登录后看到的是**正常首页**，角标 APPROVED、名额「标准 20 / 已发 0 / 剩 20」、「暂无录取任务」。
3. **幂等验证**：fresh 连跑两遍都是 onboarding/资料未完成/0任务；approved 连跑两遍都是 active/标准/0任务。

## 截图（shots/GS2/，横版 1920×1080）
- `05-sch3-approved-home-zh.jpg` — 已通过首页（APPROVED + 标准20 + 暂无任务）。
- `06-sch3-fresh-onboarding-zh.jpg` — 完善资料表单页（资料未完成 + 完善学校资料表单）。

## 闸判据对账
- 两个状态脚本各跑两遍结果一致 ✅
- 截图 2 张 ✅
- 资质文件用 SPECIMEN/演示值，未用真人材料 ✅

## 做法与落点
- 注册器：`~/mh-verify/gs2-02-reg.mjs`（本机跑，不入 git；GS2-04 重建会先调它建号）。
- 状态 SQL：`jobs/JOB-GS2/states/_sch3.sql.fresh` / `_sch3.sql.approved`；包装脚本 `states/st-sch3-fresh.sh` / `st-sch3-approved.sh`。
- 没触红线：只建/只动 guide_sch3；删除只限本校自建任务与通知；无迁移、无云函数、未改五端代码。
