PUSH_OK=yes

# SUMMARY-37 · 第三十七轮收官 · 层次代码「显示」归一

> **一句话**：第三十六轮悬着的那件事（36-02）业主拍了板选 **b**——「语言生 / 短期 / 专科 / 预科」这些学校端的层次代码，在管理端和中介端屏幕上要显示成人话。本轮两包做完、全闸绿、无必须停，管理端出 v246、中介端出 v178，随时可推。只动「怎么显示」，学生填的、库里存的、匹配比对的一个字都没碰。

## 首行 PUSH_OK=yes 的含义
- 本轮两包（37-00 开工先红、37-01 施工转绿）**各闸全过、无必须停**，所以 `PUSH_OK=yes` = 业主可以推主仓库。
- CC 从不自己推主仓库——这跟 PUSH_OK 无关。推送由业主用卡1267 在原生终端挂代理做。
- 主仓库本地现领先远端 **2 笔**，全是本轮 JOB-37-00 / JOB-37-01（正常，不触发必须停）；工作树干净。

## 本轮无需手贴 SQL
- **零迁移、零 SQL、零云函数**。纯前端显示改动，推完即生效，无任何库操作。

## 版本 / md5 账
| 文件 | 版本 | md5 | 说明 |
|---|---|---|---|
| admin-portal/maxhouse-admin-portal-v246.html | v246(新) | `1d08cf42cf9ee1d604a55af19f024ac3` | 唯一权威表 `_v246ALevelLabel`；三标签函数统一委托；四件套齐；旧版 v245 保留 |
| partner-portal/maxhouse-partner-portal-v178.html | v178(新) | `804e0e197b9f2b4db1a48b5ead660e9f` | 词典补 prog.lang/prog.exchange + 别名卫兵；四件套齐；旧版 v177 保留 |
- 未动：student v407 / school v245 / reviewer v46 / 组件 v1.4 / 机器人 / 启动器 / 契约脚本。

## 两包一句话
- **37-00**：开工核对（七基线 md5 全对、HEAD=origin、验证环境齐）+ 旧态先红：Playwright 中英各一遍验到管理端 `_v227Level`/`_v233LevelLabel` 与中介端 offer 卡键名卫兵遇 `lang`/`exchange` 显代码原文（R1×4 / R2×2 全红，0 pageerror）。纯只读。
- **37-01**：管理端 v246（新增唯一权威表 `_v246ALevelLabel`，`_v227Level`/`_v231LevelLabel`/`_v233LevelLabel` 统一委托）+ 中介端 v178（词典补 `prog.lang`/`prog.exchange` 中英 + 别名表 `_v178LevelKey`，offer 卡卫兵先过别名表再查词典）。**只改显示**，存值 / target_programs / 比对 / 过滤 / RPC / 学校端 PROGRAMS / 推荐向导 progs 一概不动。

## 闸账
- **旧态红→绿**：37-00 的 R1×4 / R2×2 全红；37-01 无头真渲染对六种桩值（lang/exchange/associate/chinese_lang/short_term/bachelor）× 中英各一遍断言全部显人话、bachelor 逐字不变——**转绿**。
- **闸3（静态断言，P3 随卡）**：`jobs/JOB-37-01/green.mjs` **GREEN=21 / RED=0**。
- **闸8（无头真渲染，file:// only，sb/fetch 全 stub，中英各一遍）**：**PASS=52 / FAIL=0 / pageerror=0**。
- **N1 零移除**：admin 函数零删仅 +`_v246ALevelLabel`、handler 421=421、id 零删；partner 函数零删仅 +`_v178LevelKey`、handler 233=233、id 零删。
- **四件套**：admin（名/头注/[VER]/MH_PORTAL_VER=246/index）；partner（名/changelog版本史/[VER]/MH_PORTAL_VER=178/index）。
- **secret-scan**：两端新增行零密钥。
- **盲态**：新增**渲染文案**只有层次人话（汉语进修 / 短期学习 / 专科 / 预科 及英文），无校名 / 学校网址 / 中介账号名。

## 未证之事（本机未做，留业主或 Mac mini）
- **本机 file:// + stub 无头验收**已过；**线上肉眼验收**待推送后（卡1267 推完）由 Claude 代查，或业主自看。
- **中介端 `prog.*` 词典无俄法**：本轮按 §0.5 只补中英两份 `prog.lang`/`prog.exchange`；若日后 offer 卡要支持俄法界面的层次显示，需另补俄法词条（现役 `prog.chinese_lang`/`prog.short_term` 同样只有中英，故本轮不引入新缺口，只是沿用现状）。
- **真登 / 真库**：本轮纯显示改动，无需真库写，未做真登验证。

## 给业主的验收（推完 v246/v178 后）
1. 管理端派单台 / 任务详情 / 学校抽屉里，语言生任务显示「汉语进修」、短期任务显示「短期学习」、专科任务显示「专科」（英文界面分别显 Chinese language / Short-term study / Associate degree），不再漏出 `lang`/`exchange` 代码。
2. 中介端 offer 卡的层次同样显人话。
3. 本科 / 硕士 / 博士等老层次显示跟改前一模一样（没动）。

## 第三十八轮建议包（QUEUE-37 §37-02 必含项）
- **27-B**：管理员重置学生密码云函数 + 按钮（需 Mac mini 部署）。
- 历史欠验项由 CC 用测试账号**线上自验**（需 Mac mini 的 accounts.json）。
- **AI 预填**：先出图。
- **at0086**：等开放。
