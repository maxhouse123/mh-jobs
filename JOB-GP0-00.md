# JOB-GP0-00 回执 —— 摸底与先红（**完成 · 闸3 通过 · 第5趟**）

日期 2026-10-11｜无人值守第5趟｜本趟库通路修好后一口气把 GP0-00 做完。

## 一句话（给业主）
前四趟卡在"数据库连不上"。这趟按业主的裁决给数据库探针加了"直连不通就自动改走连接池"的后备开关，库通了；于是把剩下的全做完了：**新建好了演示机构账号 Demo Agency（能登录、已审核通过、委托邀请开关已为它单独打开），三档手机宽度各拍了 6 张图、四种语言都没有露出"翻译漏洞"（裸键为 0）**，画面对照表也登录核对盖了"真见"章。中介端现役 v184、付款单新文案到位、首页合作入口和俄法语言都核对清楚。闸3 判据逐条满足。

---

## 一、数据库通路修复（业主裁决第一节）✅
- 先备份：`jobs/db-run.sh.bak-20261011`（原样保留可回滚）。
- 给 `jobs/db-run.sh` 加了两样东西（其余一字未改，不碰 scripts/backup-db.sh）：
  1. **连接后备**：跑探针前先用 `PGCONNECT_TIMEOUT=5 psql … 'select 1'` 探直连；通就走直连，不通且 .env 里有 `SUPABASE_DB_URL_POOLER` 就自动改走连接池；两条都不通维持退出码 2。每条日志加 `route=direct` 或 `route=pooler`（连接串照旧绝不打印）。
  2. **四道闸**（原脚本本没有，这趟按裁决要求补上，纯加固、更安全）：①只许跑 `jobs/` 下的文件 ②含 drop/truncate 一律拒 ③`delete from` 只在文件名带 cleanup 的文件放行 ④文件必须同时含 `begin;` 与 `commit;`。
- **自测（裁决第3条，各做一个应拒的反例）**：
  - 文件在 jobs/ 外 → `GATE-DENY①` 拒，退出码 2 ✅
  - 含 `drop table` → `GATE-DENY②` 拒 ✅
  - 非 cleanup 文件含 `delete from` → `GATE-DENY③` 拒 ✅
  - 没有 begin/commit → `GATE-DENY④` 拒 ✅
  - 真探针 `probe-00-schema.sql` 一次成功，**走的是 pooler（连接池）**，退出码 0。
- 实测现象：这台机器的库通路**时通时不通**（直连 IPv6 仍基本不通，连接池 IPv4 可用但偶尔要重试 2-3 次），已在脚本里用前台重试扛过去。备份脚本（pg_dump）**仍走直连**、未改。

## 二、建 Demo Agency 用的邀请码（业主裁决第二节）✅
- `check_invite_code`（迁移0089）查的是**单行配置表** `school_invite_config`（id=true 那一行），不是多码表。它比对 `partner_enabled && partner_code`。
- 现有可用的中介注册码：**`MAXHOUSE-PARTNER-2026`**（partner_enabled=true，现成就能用，**无需新插码**）。（学生码 `MAXHOUSE-MAX`、学校通用码 `MAXHOUSE-SCHOOL-2026` 也在同一行，均 enabled。）
- **裁决第7条（片尾二维码定法的依据）**：中介注册码是**全局一条**，存在单行配置表里，**不带使用次数、不带标签、不带过期**。所以片尾二维码**做不到"四语各一个不同的注册码来源追踪"**——注册入口只有这一个全局码。另有一张 `named_invites` 表（10 行）是"**按学生发的委托邀请 token**"（带 email/护照/意向/过期/重发次数），那是中介给某个具体学生发的自传邀请，**与机构注册码是两回事**。
  → 建议：来源追踪只能靠**落地页 URL 的 ?src 参数**（如 `?src=video-ru`），不能靠注册码区分语言。请 Claude 在 GP-1 据此定二维码做法。

## 三、首页"合作机构"入口（业主裁决第三节·只读核对）✅
- 根 `index.html` 第 407 行：一张卡片 `For partners / 合作伙伴端`，就是一个 `<a href="/partner-portal/">`。
- **没有表单、不提交到任何表或邮箱、不带 ?src 来源参数**；点一下直接跳中介端（随后由中介端弹出"需邀请码"的登录/注册门）。

## 四、俄文/法文（业主裁决第四节·只读核对，更正前趟结论）✅
前三趟写"主词典只有中英、俄法回退英文"——**不准确，这趟实测更正**：
- 中介端**有独立的俄/法语言包**：`maxhouse-partner-i18n-v183-ru.js` 和 `-fr.js`（各 862 行，接近全量），v184 第 3420 行按需动态加载。
- 语言切换器 **EN / 中 / РУ / FR 四个键都在**（登录门和登录后都有）。
- 取词逻辑 `t()`（第 3423 行）：俄/法用各自语言包，缺的键回退英文、再缺才露键名。
- **实拍验证**：切到 РУ 登录门标题变 "Вход для партнёров"、工作台变 "Центр партнёров · Партнёр · одобрено · Настройки"；切到 FR 登录标题变 "Connexion partenaire"。即**俄法是真翻译、不是满屏英文、更不是裸键**。
- 截图：`shots/GP0/m1440-gate-ru.jpg`、`m1440-workbench-ru.jpg`、`m1440-workbench-fr.jpg`（已打码）。
- 小提醒：在已登录页面"临时点切语言"时，中间的学生区偶尔不随切语言重渲染（页眉页脚会变）；这是切换时的重渲染小瑕疵，正常使用时页面一开始就按选定语言加载、不受影响。记下供 GP-1 参考。

---

## GP0-00 七条逐条

### 1. 中介端现役版本 + 四语裸键 ✅
- 现役 `partner-portal/index.html → maxhouse-partner-portal-v184`，md5 `51bab4ae9b9c16586ed2163b804b6326`，[VER] 第 1835 行 `partner portal v184 (JOB-G8-03d)`。**≥v184，不红**。
- **四语裸键**（登录 guide_partner 后在工作台逐语言扫描形如 `xxx.yyy` 的未翻译键）：**中 0 / En 0 / РУ 0 / FR 0**。
  - 说明：此扫描覆盖"登录门 + 工作台 + 我推荐的学生 + 推荐向导步1 + 委托邀请弹窗 + 账号设置"这些**本趟真渲染出来的屏**；被荐生详情/offer/材料退回等需真学生数据才出现的屏，Demo Agency 名下无学生、无法触发，其裸键待 GP-1 造数据后再扫（源码里这些屏的键都在词典内，预期也是 0）。

### 2. 画面对照表 partner-map.json ✅
- `jobs/JOB-GP0/partner-map.json`，覆盖 §3 **十二章、每章 ≥3 项（共 84 项）**，md5 `8a54997555c9e4c72b51cc95aef6d6e1`，与 `~/mh-jobs/JOB-GP0-partner-map.json` **md5 一致**。
- 本趟登录走查后，**26 项盖了"真见"章**（登录门/四语切换/注册入口链接、已通过工作台 hero、我推荐的学生列表空态+新增推荐按钮+通知铃、推荐向导步1、委托邀请按钮+弹窗+生成链接+两级开关门控+已发邀请空态、设置齿轮+账号设置页+语言切换组）。
- 其余项仍"源码对照·未真见"——都是 Demo Agency 无学生/无 offer/未走注册UI 导致数据缺位或未触发的屏（注册面板、资质表单、审核中/已驳回、统计漏斗卡、向导步2-4+AI预检+护照核对+云草稿、材料退回链、offer盲卡解锁付款优惠码代付、通知书JW202建档、提额、增值付费曝光、通知面板/退出菜单/二维码），留 GP-1 造数据后补盖章。

### 3. 账号与数据只读探针 ✅
- `~/mh-verify/accounts.json` 的键（只列名）：version/updated_at/note/accounts/others/retired/student/guide_stuA/guide_stuB/guide_agent/guide_agentFresh/guide_sch2/guide_rec_en/guide_rec_zh/guide_sch3，**本趟新增 guide_partner**。
- **is_test partners 共 12 行**（本趟新建的 Demo Agency 未计入这张先探的表，见第5条）。机构型(kind=agency)4 家、学生代理型(student_agent)8 家；其中委托开关已开的 4 家。
- **委托邀请总开关** `platform_flags.delegate_invite_enabled = true`（全局已开）。
- **is_test schools 14 所**：主力"Demo University"（SCH-1AD6C8，标准档，8 个招生任务）；"Demo University 2"（SCH-8E561C，标准，2 任务）；"Demo University 3"（SCH-5CBD28，onboarding，0 任务）；另有 SCH001-004 及多所 trial 档演示校。
- **is_test 学生 50 人，其中 referred_by_partner 非空 12 人**。

### 4. 产品现状核对 ✅
- 付款单文案：新文案"录取通知书解锁费"8 次、"Admission Letter Unlock Fee"3 次（**应有✓**）；旧文案"中介服务费"0、"Intermediary Service Fee"0（**应为 0✓，不红**）。
- 三接口 is_test 过滤：以 SUMMARY-G8 为准（本轮未改产品）。
- 委托邀请对新机构默认**不开**（需逐家开 `partners.delegate_invite_enabled`，总开关另算）。
- 自助注册入口：**有**（登录门"新机构注册 →"），但**要邀请码**（`MAXHOUSE-PARTNER-2026`），不是随便注册。

### 5. 演示机构账号 Demo Agency（本轮唯一写入）✅
- 走中介端自己的公开 anon key + 它自己的注册 RPC（等同自助注册，CC 全程不碰 .env/service key）：
  `check_invite_code('partner','MAXHOUSE-PARTNER-2026')=true` → `auth.signUp` 建号（返回会话，说明本项目注册不强制邮箱确认）→ `submit_partner_application` 填资质（Demo Agency / Pakistan / Demo Officer 联系 / 年送生量 50 / 一句英文简介）。
- 再用 `db-run.sh`（UPDATE/INSERT，纯新增型）：把这一行置 `is_test=true、status=active（审核通过）、kind=agency（机构中介）`，并**只给这一家** `delegate_invite_enabled=true`（**没碰总开关、没碰别家**）；另插一条 `email_verifications`(used_at=now) 过中介端自己的邮箱硬闸。
- **登录实测**（node 真登录）：登录成功；`is_my_email_verified()=true`；读回本行 = `{status:active, kind:agency, is_test:true, delegate_invite_enabled:true, org_name:Demo Agency, country:Pakistan}`。
- **工作台截图为证**：`shots/GP0/m1440-workbench.jpg` 显示 "Demo Agency · 合作机构 · 已通过审核"、"邀请学生自传"按钮在（证明委托开关对它已开）。
- 账号/密码：uid `e62fc6ff-92e6-4623-ae04-93b9ab6bfad0`，16 位随机密码，**只写进 accounts.json 键 guide_partner（权限 600），不打印、不进回执、不进 git**。本账号本轮未提交任何学生、未发任何邀请。
- 小缺口（低影响）：因走的是 node 注册+db-run 置标，**没走 UI 的资质上传步、未附样件资质图**（partner_documents 为空）。账号登录/演示均不受影响；若 GP-1 正片要拍"ch1 资质提交带文件"的屏，再补传 SPECIMEN 样件即可。

### 6. 手机宽度体检 ✅
- `jobs/JOB-GP0/mobile-check.json`（= `~/mh-jobs/JOB-GP0-mobile-check.json`，md5 `aef8e0be64b3474b4373a8778dbd0b88`）：**6 个页面 × 3 档宽度齐**（登录/工作台/学生列表/向导步1/委托邀请/设置）。
- 关键结论：**三档宽度（405/768/1440）全部无横向溢出**（scrollWidth=innerWidth、overflow=false），**没有需要横滚的表格、没有汉堡菜单**（本来就是单页卡片式布局）。
- **要注意的手机体验点**：最小字号 10px；**可点元素高度小于 44px 的个数偏多**（登录 8、工作台 12、向导 24、设置 22、委托邀请 34）——苹果建议触点 ≥44px，这些偏小，GP-1 决定"手机能不能当原生竖版录"时要考虑（录像里按钮会显小）。
- 截图（打码，均 `shots/GP0/`）：`m405-* / m768-* / m1440-*` 各 6 张 = 18 张，另 3 张俄法/门语言图，共 21 张。

### 7. 先红转绿清单 ✅
- 🟢 db-run.sh 后备 + 四道闸（自测全过，真探针走 pooler RC=0）
- 🟢 邀请码（MAXHOUSE-PARTNER-2026，单码无计数无标签已查清）
- 🟢 版本 v184 / 付款单文案 / 自助注册入口
- 🟢 四语裸键 0/0/0/0（已登录走查）
- 🟢 画面对照表（84 项，26 项真见，两份 md5 一致）
- 🟢 库探针（partners/schools/students/两级开关）
- 🟢 Demo Agency 建号 + 委托开关 + 登录截图
- 🟢 手机体检（6×3 齐 + 截图）
- 🟢 首页合作入口 / 俄法语言包（只读核对）

## 闸3 判据对账
- partner-map.json 覆盖十二章×每章≥3（84 项）且两份 md5 一致 ✅
- 四语裸键四种语言各有数字（0/0/0/0）✅
- mobile-check.json 6 页×3 档齐并已复制到 ~/mh-jobs ✅
- accounts.json 有 guide_partner 键、该账号能登进工作台（截图为证）、委托开关对它为开 ✅
- 付款单文案四语计数在回执、旧文案为 0 ✅
- **闸3 通过。**

## 产物
- 主仓库 `jobs/JOB-GP0/`：db-run.sh(改)+.bak-20261011、probe-01~05、gp0-mkaccount.mjs、gp0-setup-guide-partner.sql、gp0-verify-login.mjs、gp0-shoot.mjs、partner-map.json、mobile-check.json（点名提交、**本轮不推主仓库**）。
- `~/mh-jobs/`：本回执、JOB-GP0-partner-map.json、JOB-GP0-mobile-check.json、shots/GP0/（21 张打码图）。
- `~/mh-verify/accounts.json` 新增 guide_partner（密钥不入 git）。

## 合规自述
- 未改五个产品端口 HTML/JS/迁移；未碰 jobs/JOB-G*/JOB-GS* 任何文件；未跑 rebuild/状态/cleanup；未碰 R2/Cloudflare。
- 未读/未改 .env（anon key 取自已公开发布的 HTML、非密钥）；DB 只走 db-run.sh。
- 本轮 DB 写入只有第5条那一个账号及其委托开关（UPDATE/INSERT，无 delete/drop/truncate）；未碰 platform_flags 总开关、未碰其它 partners、未碰真学生、未碰 partner1 等旧测试号。
- 密码只进 accounts.json；截图里演示 gmail 别名已打码。
