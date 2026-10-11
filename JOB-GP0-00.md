# JOB-GP0-00 回执 —— 摸底与先红（**部分完成 · 闸未过 · 数据库仍不可达**）

状态：**闸3 仍未通过**。数据库（直连 Postgres，仅 IPv6、端口 5432）**连续第二趟连不上**——这台机器当前**没有可用的 IPv6 线路**，Supabase 直连数据库只有 IPv6 地址，所以 `bash jobs/db-run.sh` 这条唯一许可的数据库通道走不通（本趟两次实测均 Operation timed out，地址 2406:da18:1f7e:b101:...:5432）。凡是要读库或写库的步骤这趟还是做不了。走代理的 HTTPS（REST）是通的，单纯是裸 Postgres 端口不通。

## 本趟（第 2 趟）新进展：画面对照表 partner-map.json 已按源码建好（第2条）
上一趟把第2条整条留到「登录后标真见」。考虑到库连续不可达、再空等只会零进展，而这张对照表记录的三样东西（定位方式 / 四语文案键 / 出现条件）**全部源自源码、源码即权威**，登录「真见」只是给每条盖一个确认章、不改已记内容（零返工风险），且任务书 §2 第2条本就允许「源码对照·未真见」——故本趟先把它建出来：
- 产物 `jobs/JOB-GP0/partner-map.json`，md5 `da296235714ab6268299c65aa3d61bb9`，已原样复制到 `~/mh-jobs/JOB-GP0-partner-map.json`（两份 md5 一致）。
- 覆盖 §3 **十二章**（开场/1~10/片尾），**每章 ≥3 个定位项**（最少 4、最多 13，共 84 项），满足闸3 对本对照表的子判据「覆盖十二章且每章≥3」。
- 每项记：定位方式（id/class/text/函数）、四语文案键（语言中性点号键，或标 hardcoded 双语字面量）、出现条件（登录态/向导步/开关/数据依赖）、源码大致行号。
- 全部 84 项 `seen` 字段均标 **「源码对照·未真见」**；被荐生详情、offer、材料退回等需真数据才渲染的屏另标 **data-dependent**。
- 关键锚点本趟已逐个 grep 实证存在（gate 四件 / gateShowRegister / regInvite / 资质表单 onb* / 审核三态渲染函数 / 工作台 partner.stats.* 与 partner.students.* / 推荐向导 openReferralForm+wzBody / 委托 _dlLoadFlags+两级开关 / 付款 payment.title 实为 EN「Admission Letter Unlock Fee」· ZH「录取通知书解锁费」+ SCHOOL_PAYMENT_AMOUNT / 优惠码 couponInput / JW202+建档 _v173OpenFiling+get_agent_filing / 提额 qrTarget+request_quota_raise / 增值 partner.premium.* / 设置菜单 toggleSettingsMenu+settingsSignOut），非臆造。

**仍不改此判定：GP0-00 整包闸3 未过**——探针(第3条)、建 Demo Agency 账号(第5条)、四语裸键正式计数(第1条·登录走查)、手机宽度体检(第6条)四件仍全被数据库阻塞，故不能进入后续 GP0-01/02（三包须按序）。

下一趟（循环会再跑）等 IPv6 恢复后，从「待办」清单接着做，别重做已完成项（版本摸底、文案核对、注册入口核对、**partner-map.json 已建**）。

## 这趟确认到的事实（都是只看源码、不碰库，下一趟不用重做）

### 1. 中介端现役版本（第 1 条·版本部分 完成）
- 入口 `partner-portal/index.html` 指向 `maxhouse-partner-portal-v184`。
- 文件 `partner-portal/maxhouse-partner-portal-v184.html`，md5 `51bab4ae9b9c16586ed2163b804b6326`。
- `[VER]` 行在第 1835 行，写的是 `partner portal v184 (JOB-G8-03d)`。
- **达标**：业主要求 ≥ v184，现役正好 v184，**不红**。

### 4. 产品现状核对（文案与注册入口部分 完成）
- **付款单文案（四语核对）**：
  - 新文案「录取通知书解锁费」出现 8 次、「Admission Letter Unlock Fee」出现 3 次（≥1，**应有**✓）。
  - 旧文案「中介服务费」0 次、「Intermediary Service Fee」0 次（**应为 0**✓，不红）。
  - （注：中文计数里有 1 次来自第 1835 行的版本变更注释，不是界面文案；界面真键已另行确认，如 `payment.title`='录取通知书解锁费' / EN `payment.title`='Admission Letter Unlock Fee'。）
- **中介端有没有自助注册入口**：**有**，但**要邀请码，不是随便就能注册**。
  - 入口：登录页上的「新机构注册 →」链接（`gateShowRegister()`），注册就在中介端同一个页面 `partner-portal/`。
  - 流程：**先填邀请码**（提示格式 `MAXHOUSE-PARTNER-XXXX`）→ 云端 `check_invite_code` 校验（迁移 0089）→ 通过后 `auth.signUp` 建账号 → 过角色门 → 自动发验证邮件 → 填资质表 `submit_partner_application` → 邮箱硬闸验证。
  - **要紧结论①（片尾二维码）**：二维码不能指向「随便注册」的页面，因为注册必须有邀请码。这点 GP-1 设计二维码/招募动线时要业主拍板。
  - **要紧结论②（第 5 条建账号）**：想走自助注册建 Demo Agency，得先有一个有效的中介邀请码（多半要从库里 / admin 发），还要绕过邮箱验证、注册后改一堆标记位——**全都要连库**。备选的「照 guide_sch3 手工建号」也要连库（auth 管理接口 + 插表）。所以**第 5 条这趟无论如何都做不了**。

### 委托邀请开关的机制（为第 5 条做准备，已摸清）
- **两级开关**：①平台总开关 = RPC `mh_flag(p_key:'delegate_invite_enabled')`（**不许碰**，照 G-1b R6）；②每家中介自己的列 = `partners.delegate_invite_enabled`（布尔）。
- 「只给 guide_partner 开」= 下一趟把它那一行的 `partners.delegate_invite_enabled` 置 true，总开关和别家都不动。
- 装载逻辑 `_dlLoadFlags`（第 13655 行）：两级都为 true 才显示委托邀请入口。

### 1. 四语裸键（只做了静态预估，**正式计数待下趟登录走查**）
- 主词典**只有英文(en)和中文(zh)**，各 755 个键；另有 518 个 `t()` 取键点。
- **没有俄文/法文主词典**：按版本注释，俄法是「回退英文（零裸键）」——也就是俄/法用户界面上大多显示英文，不是显示裸键。
- 所以：真正「界面上出现的裸键按语言计数」还得用登录后的无头浏览器逐语言走一遍（这趟登不进去，待下趟）。这条**只能算预估、未过**。

## 红转绿清单（本趟）
- 🟢 版本摸底（第1条·版本）：v184 已记、md5 已记、不红。
- 🟢 付款单文案核对（第4条·文案）：新有旧无，不红。
- 🟢 自助注册入口核对（第4条·入口）：有，但邀请码门槛已查清。
- 🟡 四语裸键（第1条）：仅静态预估，正式计数待登录走查。
- 🟡 画面对照表 partner-map.json（第2条）：**本趟已按源码建好**（十二章×≥3项=84 项，md5 两份一致），每项标「源码对照·未真见」；登录后逐项盖「真见」章待下趟。
- 🔴 库只读探针（第3条）：阻塞（IPv6/直连库不可达，连续第二趟）。
- 🔴 建 Demo Agency 账号 + 开委托邀请开关（第5条）：阻塞（需邀请码 + 连库）。
- 🔴 手机宽度体检（第6条）：阻塞（需登录 guide_partner）。

## 下一趟待办（按顺序）
1. 先 `bash jobs/db-run.sh jobs/JOB-GP0/probe-00-schema.sql` 验证 IPv6/库恢复；没恢复就直接结束，再下趟。
2. 库恢复后：第3条探针（partners is_test 行 / mh_flag 总开关 / 三演示校 / is_test 学生数）→ 第5条建 guide_partner（拿/发邀请码或照 guide_sch3 手工建）+ 只开它的 `delegate_invite_enabled` → 登录。
3. 登录后：第1条四语裸键走查、第6条手机宽度体检（三档×六页截图打码）；**partner-map.json 已建**，只需登录后拿真界面逐项把 `seen` 从「源码对照·未真见」改为「真见」（发现与源码不符处再订正，预期极少）。
4. 过闸后三样成果副本齐备、把本回执改为「完成」。

## 产物（累计 + 本趟新增）
- 主仓库 `jobs/JOB-GP0/`：`probe-00-schema.sql`（备好待下趟跑）、`findings-00-partial.json`（已确认事实）、**本趟新增 `partner-map.json`**（画面对照表，md5 da296235714ab6268299c65aa3d61bb9）。点名提交到 main、**未推**（本轮不推主仓库）。
- `~/mh-jobs/JOB-GP0-partner-map.json`（对照表副本，与主仓库版 md5 一致）。
- 本回执 `~/mh-jobs/JOB-GP0-00.md`（仍为部分）。
- 本趟**无任何数据库写入**（库没连上），**未建任何账号**，`accounts.json` 未动；**未碰**五个产品端口 HTML、未碰 jobs/JOB-G*/JOB-GS* 任何文件、未跑 rebuild/状态/cleanup、未碰 R2/Cloudflare。
