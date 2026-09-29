PUSH_OK=yes

# SUMMARY-34 · 第三十四轮收官（笔记本）

本轮主题：教育经历三段全部必填 + 机器人中文提示已就位 + 表单⇄机器人契约测试常驻。全五包做完，标准未降。产品改动已在主仓库本地 commit（4 笔 JOB-34-xx，领先远端、工作树干净），**等业主用卡1254 推送**——CC 不推主仓库。

## 一、PUSH_OK=yes 的含义
主仓库 `main` 本地有 4 笔本轮提交（`3523c1f` 34-01 / `24d95b6` 34-02 / `1fbdd35` 34-03 / `1ea4b74` 34-04），全部领先 `origin/main`，工作树 clean。卡1254 推送后应满足推后闭环（`git log origin/main..HEAD` 空、`git diff origin/main --stat` 空、线上 [VER] 探针与本版一致）。回执已逐包推到 mh-jobs 仓库（JOB-34-00…04 + 本文件）。

## 二、版本 / md5 账
新增文件：
| 文件 | md5 |
|---|---|
| assets/mh-filing-form-v1-3.js | `47d860f51e6bea914a9e45c4064fc1bc` |
| student-portal/maxhouse_student_portal_v406.html | `32370123ebaa1ce98de14a640f57229b` |
| partner-portal/maxhouse-partner-portal-v176.html | `5e0bad79d1afbf4b3926feb53bf86db1` |
| admin-portal/maxhouse-admin-portal-v243.html | `0a4470fb28005b750f26f33d3ed72904` |
| tests/filing-contract.mjs（常驻契约测试） | `43fd225270ed6a8f098b30481e58892f` |

改动文件：三端 index.html（各指到新版）、三份 changelog（各追一行）、`tools/robot-launcher/README.md`（刷到现状）。

保持不变（实测 md5）：旧组件 v1 `fa84e12…` / v1.1 `ab42a27…` / v1.2 `c763ec60…`；学校端 v244、审核端 v46、启动器 `launcher.command.tmpl` `e237f33…`、`install.sh` `f6044bc5…`、`selftest.sh`；student i18n ru/fr/zh 三包、partner i18n ru/fr 两包；机器人 v3.3 `1a26ba4b…`、recon r5（只读未动）。

## 三、五包一句话
- **34-00 开工+旧态先红**：基线 md5 全对；R1（组件 v1.2 只填 1 段教育→missingFor 空+提交放行+edu2 不带 *）、R2（契约指 v1.2/v242→唯一不符=education needs 3 rows）、R3（admin v242 过时提示在源码）全红，零 pageerror。
- **34-01 组件 v1.3**：REQUIRED 43→55（三段教育各 6 项全必填、三段带 *）、段首四语提示 `hint.edu3`；`__selftest` 39/0、pageerror 0；R1 转绿；v1/v1.1/v1.2 md5 未变。
- **34-02 student v406 + partner v176**：两端组件引用换 v1.3，四件套齐；与前版逐行只差 3 行（组件 ref/[VER]/MH_PORTAL_VER，N1 零消失）；外部语言包 md5 不变；无头真渲染三段带 *、只填 1 段被拦；check 28/0。
- **34-03 admin v243**：导出组件换 v1.3（缺 N 项自动跟到 55+条件）、删那句授权的过时提示；契约测试默认 v1.3/v243=GREEN 4/4（两份桩包在华/不在华经 v243 真导出 PACK_OK）；R2/R3 转绿；static 17/0（N1 仅 5 行不同、内嵌脚本解析无回归）。
- **34-04 README 刷新**：写到 v2 + 机器人 v3.3 + 摸底 r5 现状；两份可执行文件 + selftest.sh 未动；README 与模板逐条对照全一致。

## 四、闸账
- **旧态先红→绿**：R1 对 v1.2 红、对 v1.3 绿；R2 契约对 v1.2/v242 红（education needs 3 rows）、对 v1.3/v243 绿；R3 对 v242 红（提示在）、对 v243 绿（可执行调用删）。
- **N1 授权移除**：清单只有一项——admin v243 删 `showToast('该生在华：建档第 1 步需人工填')` 的可执行调用（§0.3 授权）。逐行实证：v243 vs v242 仅 5 行不同（头注/组件ref/MH_PORTAL_VER/toast→注释/[VER]），无其它 id/handler/function 消失；student/partner 各仅 3 行不同；组件 v1.3 相对 v1.2 只增不删（四函数/导出/词典全留）。
- **P3 静态断言**：admin `jobs/JOB-34-03/static.mjs` 17/17；两端 `jobs/JOB-34-02/check.mjs` 28/28；契约 `tests/filing-contract.mjs` 4/4。随卡入仓。
- **闸8 无头真渲染**：组件 `__selftest` 39/0（Playwright + Chromium，四语零裸键/零 undefined、三段 starred、只填 1 段被拦点名「教育经历 2」、hint 四语）；两端按引用路径真渲染三段带 * + 拦截；均零 pageerror。中英（组件四语）覆盖。管理端整端 boot 走查依赖 `JOB-30-00/filingfake` 桩（本机缺），以契约测试端到端真链（走 v243 真导出→机器人 checkPack）+ 内嵌脚本解析零回归替代，已在 34-03 回执写明。
- **契约测试（常驻）**：组件 REQUIRED 填齐 → admin `_v239BuildProfile` 导出 → 机器人 `checkPack` 除文件零问题；v1.2+v242 红、v1.3+v243 绿。以后任一端改表单/导出都跑它。
- **机器人 PACK_OK**：机器人 v3.3 `samplePack(false)/samplePack(true)` 经 checkPack 除文件零问题（在华/不在华）；机器人只读未动。
- **shell-lint**：本轮无 shell 文件改动（启动器两份可执行 + selftest.sh md5 未变），无适用项。
- **secret-scan**：新增/改动文件零 service_role/JWT/私钥/密码/token（`eyJ` 命中仅为既有 base64 LOGO，误报）。
- **盲态**：student/partner 新增内容（仅组件 v1.3 的 hint.edu3「本科、高中、初中」等）零校名/网址/中介账号名。

## 五、本轮无需手贴 SQL
零迁移、零 SQL、零云函数、零 `_headers`、零共用查看器改动、零数据库操作。铁律16「SQL 即归档」本轮无适用项。

## 六、未放行清单（没做 / 留后续）
1. **主仓库 4 笔待推 → 卡1254**：`3523c1f`/`24d95b6`/`1fbdd35`/`1ea4b74` 已 commit 未推；CC 不推主仓库。
2. **管理端整端无头 boot 走查缺桩**：`JOB-30-00/stub/filingfake.mjs`（假 sb + 本地服）这台笔记本上没有；34-03 以契约端到端真链 + 解析零回归替代。若后续要整端 boot 走查，需先把该桩带到本机（非本轮必须停）。
3. **at0086 机器人**：等武昌理工开放报名后做（当前未开放）。
4. **AI 预填补充信息表**：第 35 轮先出图再施工。
5. **平台常量真值**：导出兜底的 `_v239PLATFORM`（推荐人/在华担保人/通知书接收人/联系方式）仍是占位，`_v240PlatformBanner` 琥珀条仍提醒运营核对——待接真值。

## 七、⚠ 对已提交过、但教育经历不满三段的学生的提醒
换 v1.3 后，管理端「学校建档」列表对**线上已提交过补充信息表、但只填了 1–2 段教育经历**的学生，会显示「缺 N 项」（因为第 2、3 段现在必填）。**这是预期，不是故障**。这些学生需要回学生端（或由中介/管理端代填）把第 2、3 段教育经历补齐后，「缺 N 项」才会消、才能导出建档包。建议业主对存量学生做一次排查提醒。

## 八、给业主的 3 条验收（卡1254 推完后，Claude 代查；业主按卡1251 把复查包拖回即可）
1. **学生端补充信息表**：三段教育经历都带 *，段首有一行灰字「学校报名系统要求填满三段，按时间倒序（最近的在前），例如：本科、高中、初中。」；只填一段点提交会被拦并点名到具体那一段那一栏。
2. **管理端「学校建档」**：教育经历不满三段的学生显示「缺 N 项」；在华学生导出建档包时，**不再**弹那句「该生在华：建档第 1 步需人工填」的旧提示。
3. **桌面启动器**（卡1249 真装后）遇到不合格的包时，提示是**中文**（机器人 v3.3 逐条说明缺项，如「教育经历第 2 段：学校、国家、学历、专业没填」）。

## 九、第三十五轮建议包（QUEUE-34 §34-05 必含项）
- **AI 预填补充信息表**：用已有材料自动预填减少人工——**先出图**再施工。
- **at0086 机器人**：等武昌理工开放报名后做。
- **平台常量真值**：接通 `_v239PLATFORM` 等导出兜底的平台联系信息真值。
- **历轮挂账**：存量「教育经历不满三段」学生的补齐提醒落地；管理端整端 boot 走查桩（filingfake）带到本机；REJ-1（拒绝弹窗类别选择器）；admin LS 桥收敛；配额云化；quota 视图 mock；withdraw_referral 线上 400 复现定性；vendor/tesseract LFS 评估；机器人自调用改 realpath 判定。
