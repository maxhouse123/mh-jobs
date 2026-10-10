# JOB-G8-03c —— 第 3 趟（真重录 c07/c12 完成；c10 卡在 §3.3，停等业主）

日期 2026-10-10　机器 Mac mini　本趟代号 G8-03c

## 一句话（大白话）
这趟真把视频录起来了。**第 7 章（付款单改名）和第 12 章（中介代付单改名）四种语言全部重录好、画面对、全是新费名**。
中途发现一个重录工具的坑（录登录走的地址还写着旧版 v411，害得一开始录出来是旧费名），修好了。
**唯一卡住的是第 10 章「补充信息表」**——真机手机宽度下这张表排版是坏的（标题竖着排一个字母一行、字段看不见），
这和上一轮「离线看着没 bug」的结论相反。修这张表要改产品代码、要您定病根+肉眼验收，无人值守我不能自己改，
所以写了 `jobs/JOB-G8/NEEDS_OWNER_DECISION.md` 给您三个选项，**本趟停在这里等您拍板**。

## 一、重录工具的坑（已找出病根并修，已 commit 未推）
- 现象：第一次录 c07，付款单画面还是旧名「Intermediary Service Fee」，顶上还有紫色「有新版本可用—请刷新」横幅。
- 病根：上一轮前置只把 `harness.mjs` 的学生地址升到了 v412，但**真正导航去登录的是 `JOB-G0/flows/lib.mjs`**，
  它里面还写着旧版 **v411**（旧费名）。所以录制登录后页面落在 v411，录到旧名。
- 修：`lib.mjs` STUDENT_URL v411→**v412**、PARTNER_URL v182→**v183**；`c12.mjs` 自带的 PARTNER_URL v182→**v183**
  （12-12 委托邀请那镜用合伙人门户，升到 v183 免得也弹旧版横幅）。
- 验证（真录重跑后看帧）：
  - c07 7-3 四语都是新名 + ¥0（`shots/G8/g8-03c-fee07-{en,zh,ru,fr}.jpg`）。
  - 另写了只读探针 `jobs/JOB-G8/_probe-fee.mjs`，直连 v412 用 Playwright 查：版本=v412、付款单标题=「Admission Letter Unlock Fee」、旧名 0 处。确认线上 v412 本身没问题，问题只在录制工具用了旧地址。
- 主仓库 commit：`e0861c2 JOB-G8-03c(重录工具修)`（**仅 commit，未推**；主仓库 CC 从不推）。

## 二、真重录（闸的真实命令输出）
录制要先把演示账号摆回起点，用的是本就有的、只碰演示号 guide-stua/ref2 的重置 SQL（铁律9 新增/演示态、非真实用户）：
- c07：每语先 `reset-lina-payorder.sql`（清 Lina 付款 scratch + 优惠码核销，否则 7-4 的 ¥0 报 already_redeemed）
  再 `state-ch7.sql`（把第一份 offer 摆回待付款）。四语全 **shots=6 ok=6**。
  - 真实输出：`cleared lina payment scratch + 1 coupon redemption(s)` → `staged schX offer … awaiting-payment` → `[c07/en]…ok=6 / [c07/zh]…ok=6 / [c07/ru]…ok=6 / [c07/fr]…ok=6`。
  - 画面核验：zh 7-4 = 「录取通知书解锁费 / 付款成功 / 优惠立减·MAXHOUSE −¥3,000 / 支付金额 ¥0.00」；fr 7-3 = 「Frais de déverrouillage… / ¥0 / Service: Frais de déverrouillage」。
- c10：直接录（纯高亮/只读，不改状态）。四语全 **shots=6 ok=6**（10-1~10-6 都录到了）。
- c12：每语先 `reset-ref2-coupon.sql`（清 Nour 优惠码核销；实测本就 0 行，代付只预览不核销）。四语全 **shots=11 ok=11**。
  - 画面核验：en 12-10 = 「Admission Letter Unlock Fee / ¥0 / Paid by agent.demo / Partner Agent PA-A2D3EB01」。

所有重录帧都在本机 `jobs/JOB-G1/rec/<lang>/c07|c12|c10/frames/`（构建产物，不入 git）。

## 三、第 10 章为什么卡住（§3.3 其实没修好）——详见 NEEDS_OWNER_DECISION.md
- 真机手机宽度（390 px、真登录 Omar、真线上 v412）下，「补充信息表」标题「Supplementary Information」被挤成**一个字母一行竖排**，右侧空白、**字段看不见**。证据：`shots/G8/g8-03c-ch10-brokenform-en.jpg`。
- 这和上一轮 G8-02「离线去门闸看着排版正常、疑似无真 bug」的结论**相反**——当初那个结论是错的（离线环境不一样）。
- c10 的录制脚本里本就留着一句 `F4：表单在手机宽度下排版坏`，说明 G7 之前这张表就坏，当年是「停在表单上只高亮不操作」录的。
- 修这张表 = 改产品代码出 v413，按铁律14 要您读源码定病根、铁律15 要您肉眼验收 → **无人值守不能自改**。
- 任务书 §0.6 虽有「修不进组件就剪掉 10-4/5/6、不算停」的退路，但「修不进组件」这个判断本身按铁律14 得您定；
  且您这轮初衷是「修好表 + 把三镜录回来亮相」，直接剪掉与初衷相反 → 所以写决策卡请您三选一（A 修 / B 剪 / C 照录坏的）。

## 四、还差什么 + 下一步（下趟从这接着，不重做）
- **等业主回 NEEDS_OWNER_DECISION.md**：
  - 回 A（建议）：业主给第 10 章补充信息表组件的排版病根/落点 → CC 出学生端 v413 修表 → 业主本地肉眼验收 → CC 重录 c10 四语 → 接 G8-03 重拼。
  - 回 B：c10 只留 10-1/2/3（剪掉 10-4/5/6）→ 直接重拼 → 往下 G8-04。
  - 回 C：c10 照现在录好的（含坏表单）用 → 重拼 → G8-04。
- c07/c12 已录好，下趟不重录；c10 按业主选择处理。
- 之后：`assemble.mjs --all` 四语重拼（c 章 + full + quick）+ `gates.mjs` 全过 + 片尾二维码解码==官网 → 证据帧 → G8-03 收尾 → G8-04（流畅版 + 页面双档 + 传桶，cycle=2 推送）。

## 五、本趟写入 / 推送
- 主仓库（仅 commit，未推）：`e0861c2`（lib.mjs/c12.mjs/_probe-fee.mjs）、`378d590`（NEEDS_OWNER_DECISION.md）。
- ~/mh-jobs：本回执 + `shots/G8/g8-03c-*.jpg`（9 张），push。
- **触发停等**：§3.3 第 10 章排版需业主定病根（铁律14）+肉眼验收（铁律15），属必须停等业主的情形。

## 六、安全
- 所有重置只碰演示号 guide-stua(Lina)/guide-ref2(Nour) 的本轮录制 scratch（付款订单 + 优惠码核销），真实用户一行不碰；idempotent。
- 画面无 @gmail.com 真邮箱（演示用 lina.demo@example.com / nour.demo@example.com / agent.demo@example.com）、无名单外真学生。
- 产品 HTML 本趟一行未改（只改录制工具 lib.mjs/c12.mjs）；无钥匙/密码进回执或仓库；accounts.json 只读未读内容；.env 未读（DB 走 db-run.sh）。
