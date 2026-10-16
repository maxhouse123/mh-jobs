# JOB-F1-02 回执 · 学校端账户设置：联系信息"空" + 发 Offer 被"录取办理方式"拦住

**结论（四选一）：C —— 代码有病根**（school v245）。两个毛病同一个根：页面要用的 `state.settings` 这个"内存暂存盒"只有点右上角 ⚙设置 那条路才会装数据；而①发 Offer 的拦截闸、②拦截弹窗里的"去设置"按钮，都没装这个盒子就去读它，于是读到空。**按本卡只写修法方案、不动手。**

---

## 一、先回业主最关心的一句话
**联系信息既不是"库里本来就空"，也不是"被脚本改空"。**
- 数据库里 SCH-BFB599（武汉纺织大学）这行：**联系人姓名=李老师、办公电话=027-59367366、所在城市=武汉、校徽也在**，都是真实值；个人手机/微信号/学校官网 确实是空的，但那是**选填项、学校自己从没填过**。
- `school_action_log` 里这所学校 2026-10-04 起**只有"查看学生"记录，没有任何改资料动作**；`updated_at=2026-10-16 01:47` 对应的是**真实学校用户当天在线自己存了一次**（那个时间点日志里正好有他在翻看学生）。
- 所以页面上"六个字段全空"**不是数据没了，是代码在"去设置"这条路进设置页时没把库里的值读进来**，白屏一场空（显示 bug）。

> 补充事实：SCH-BFB599 的 `is_test=false`（**真实学校，非演示校**），本卡只读诊断、一字未改它。按迁移 0226，真实学校的候选/浏览池只会出现 `is_test=false` 的真实学生（F1-01 已证：没有任何 AI 脸泄漏到真实学校，红线=0）。它那 54 人池的逐条 is_test 需用它自己的登录态跑 RPC 才能枚举，CC 无其密码；但 0226 过滤 + 该校 is_test=false 已从数据层保证全是真实学生。

## 二、数据层体检（只读探针，全在 jobs/JOB-F1/）
| 查项 | 结果 |
|---|---|
| schools 联系列（contact_name/phone/mobile/wechat/website/city/logo_url） | **全部存在** |
| schools 办理方式列（filing_system/timing/url/account/note） | **全部存在**（迁移 0222 已贴） |
| 保存 RPC `update_school_profile` / `school_set_filing` | **两个都在、签名正常** |
| filing_tasks 表 | 存在 |
| SCH-BFB599.filing_system | **'none'（已设成"不用建档"，今天 01:47 存的）** |
| SCH-BFB599 联系值 | 姓名/电话/城市 有值；手机/微信/官网 空（选填未填） |

→ **数据层和 RPC 全是好的，排除 B（被改空）和 D（权限/RLS 挡）。**

## 三、代码层病根（只读 v245 源码，逐行定位）
**内存盒 `state.settings` 的生命周期出错**：全局 `state` 初始对象里**根本没有 `settings` 这个键**（第 8725 行起），它**只在点 ⚙设置 调用的 `openSettingsView()`（第 10073 行）里才被创建**并从 `state.account` 抄入联系字段。

由此两个真 bug：

### 病根① 发 Offer 闸永远拦不下来（"功能用不了"的真因）
- 闸函数 `_v242FilingGateBlocked()`（第 10357 行）读的是 `state.settings.filingSystem`。
- 可登录时 `_v242FetchFiling()`（第 10311 行，hydrate 第 5181 行调）虽然从库里查到了 `filing_system`，但它写回前有道门 `if(state.settings)`（第 10317 行）——**登录那一刻 `state.settings` 还不存在（undefined），这道门为假，查到的值被丢掉**。之后再没有任何地方把库里的 filing_system 补进 `state.settings`。
- 结果：学生详情页点"发送录取通知"→ 闸读 `state.settings.filingSystem` = undefined → **无论库里存没存、存的是不是 'none'，闸都弹"请先设置录取办理方式"**。学校就算存了，换个会话再来还是被拦 → **"用不了"**。
- （唯一能当场绕过的偶然：用户在设置页手动"改动"了下拉框触发 onchange 才会给 `state.settings.filingSystem` 赋值；但下拉框默认已显示"不用建档"，不动它就不触发 → 存了也白存。）

### 病根② 走"去设置"进设置页，六个联系字段全显示空
- 拦截弹窗的"去设置"按钮 `_v242GoSetFiling()`（第 10372 行）只做 `state.view='settings'; renderCurrentView()`，**没调 `openSettingsView()`**，所以 `state.settings` 仍是 undefined。
- 设置页渲染 `renderSettingsView()`（第 10153 行）里 `const s = state.settings || {}`，各字段 `value="${escapeHtml(s.contactName)}"`；`escapeHtml(undefined)` 返回空串（第 8966 行）→ **姓名/电话/手机/微信/官网全渲染成空白**，哪怕库里有"李老师/027..."。
- （同类旁路还有"我的操作记录"的返回链接第 10136 行；但它只在你已从 ⚙ 进过设置、盒子还在时才无碍。）
- **附带风险**：若用户在这个"空盒子"状态下误点设置页主"保存"按钮（`saveSettings` 第 10388 行，读 `state.settings` 全空）→ 会把库里真实的 李老师/027... **覆盖成 NULL（真清空）**。（这次没发生，联系值还在，但隐患在。）

业主看到的现象完全对得上：发 Offer → 弹"请先设置录取办理方式"（病根①）→ 点"去设置" → 落到设置页、联系字段一片空白（病根②）。

## 四、修法方案（school v245 → v246；本卡不动手，仅方案）
三处小改，全是前端、复用现有函数、零新样式、零新 RPC：

1. **让办理方式的值有个靠谱落脚点**（治病根①）：
   - 把 `_v242FetchFiling()` 的写回从 `if(state.settings){…}` 改为写进**登录后必然存在的 `state.account`**（如 `state.account.filingSystem = r.filing_system||''` 等五项）。
   - `_v242FilingGateBlocked()` 改读 `state.account && state.account.filingSystem`（兼容 'none' 放行）。
   - `openSettingsView()` 建 `state.settings` 时，一并从 `state.account` 抄入 filingSystem/Timing/Url/Account/Note，使设置页下拉框如实回显已存的办理方式。
2. **"去设置"按钮走正道**（治病根②+清覆盖隐患）：`_v242GoSetFiling()` 把 `state.view='settings';renderCurrentView()` 换成 **`openSettingsView()`**，再执行原来的滚动到 `v242FilingSection`。
3. **防御性兜底**（可选）：`renderSettingsView()` 开头若发现 `state.settings` 为空，就地按 `openSettingsView` 的逻辑从 `state.account` 补齐，确保**任何入口**进设置页都不白屏、不误清。

> 改完按铁律11/12 跑三层自验 + 功能宪法对照 + 随卡 tests 断言（state.settings 未初始化时：闸按库值放行/拦下正确、去设置后联系字段非空、主保存不把真值写 NULL）。学校端属 student/school 审计范围，需过功能宪法比对。

## 五、真浏览器复现说明（诚实交代）
- 病根是**纯前端内存状态时序问题**，上面已逐行定位、因果闭合，源码即铁证。
- 本卡要求"用 schX 演示校真浏览器复现并截图"：**CC 无 schX 登录密码，且铁律11 禁止 CC 碰生产网址/连真库**（只许 file:// + stub）。故未做线上真登录截图。
- 给业主的**手动复现步骤**（可照做验证病根①②）：
  1. 用 schX（或任一演示校）登录学校端，**不要点右上角 ⚙设置**。
  2. 直接进一个任务/候选池，挑一名可发录取的学生，点"发送录取通知" → 应弹"请先设置录取办理方式"（病根①：即便该校库里已设过办理方式也会弹）。
  3. 点弹窗"去设置" → 落到账户设置页 → 看联系人姓名/办公电话等是否**一片空白**（病根②）。
  4. 对照：改从右上角 **⚙设置** 进同一页 → 联系字段应**正常显示**。两条路结果不同 = 实锤病根②。
  5. 控制台无需红字即可复现（纯逻辑 bug，不报错）。

## 六、本回执产出的只读探针
`_probe-sch-bfb599.sql` / `_probe-sch-bfb599b.sql` / `_probe-sch-logs.sql` / `_probe-bootstrap.sql`（走 db-run.sh，全只读 begin/commit）。

**本块零写入、零改 HTML。等业主决定要不要排 v246 修复卡。**
