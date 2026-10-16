# JOB-F3-01 回执 · 学校端 v246 → v247：发 Offer 面板加「本校录取办理方式」一行

日期：2026-10-16

## 这一步干了啥（大白话）
学校在给学生发录取（发 Offer）时，面板顶上现在会多显示一行小字，告诉学校：
「本校录取办理方式：<用哪个系统> · <什么时候建档> · 修改」。
- 如果学校已经在设置里选好了办理方式，就显示出来，比如「本校录取办理方式：17gz · 出通知书前 · 修改」。
- 如果选了「不用建档」，就只显示「本校录取办理方式：不用建档 · 修改」（不显示时机，因为不建档就没有时机）。
- 如果还没设，就显示「本校录取办理方式：未设置 · 去设置」。
点右边的「修改 / 去设置」，会关掉当前弹窗、跳到设置页的办理方式区块并高亮，方便学校改。
这行只是**提示**，发 Offer 该拦还是拦（那套闸是上一版 v246 的事，这版没碰）。

## 一个要向业主说清的事实（图纸 vs 真源码）
图纸说「候选池内联表单」与「学生档案弹窗里的表单」两处面板顶部各加一行。
**真源码里这两处其实是同一个渲染函数** `_renderCloudOfferInline`——
无论从任务候选池打开学生、还是打开学生档案弹窗，发 Offer 表单都由它渲染（全仓只有这一个云端发 Offer 表单、
一个发送按钮 `cloudSendOfferBtn`→`_cloudSendOfferFromInline`）。
所以**在这一个函数的面板顶部插一次，就同时覆盖了图纸说的「两处」上下文**，无遗漏。
（另有老的 `sendOfferFromForm` 是纯本地演示路、不写云端，不在本卡范围，没碰。）

## 具体改了什么（都在 v247，一个新文件；v246 原样不动）
1. **新助手 `_v247FilingLine()`**：只读 `state.account.filingSystem / filingTiming`
   （登录时 `_v242FetchFiling` 已填、保存时 `_v242SaveFiling` 已同步，所以存完不刷新再开面板就能显新值），
   拼出那行小字。系统/时机的显示名**复用设置页已有的 `filing.*` 词条**：
   gz17→「17gz」、at0086→「at0086」、none→`filing.sysNone`（不用建档）、own→`filing.sysOwn`、form→`filing.sysForm`；
   时机→`filing.timingBefore`/`filing.timingAfter`；「去设置」→复用 `filing.gateGo`。
2. **插入点**：`_renderCloudOfferInline` 面板顶（通过面试闸绿条之后、「🎯 决定录取专业」标题之前）加 `${_v247FilingLine()}`。
3. **「修改 / 去设置」点击**：走现有 `_v242GoSetFiling()`（关弹窗 → `openSettingsView()` → 滚到 `v242FilingSection` 并高亮）。
4. **新增词条三个（四语齐：中/英/俄/法）**：`filing.inlineLabel`（本校录取办理方式）、`filing.inlineEdit`（修改）、`filing.inlineUnset`（未设置）。
   - 其中 `filing.inlineUnset`（未设置）是**图纸两键之外多加的第三个**：全仓没有可复用的「未设置」键，
     而借用 `filing.sysNone`（「不用建档」）语义是错的（「不用建档」是一种已选定的办理方式，不等于「还没设」），故只能新建。
     已登记在此，供业主过目。
5. **零新 CSS 规则**：行用行内小字样式（`font-size:12.5px;color:var(--ink-mid)`，与面板现有小字行一致），
   链接复用现有 `auth-link` 类（图纸允许「最多一条行内 class 复用」）。
6. **版本四件套**：文件名 `maxhouse-school-portal-v247.html`、头注、`[VER] school portal v247` 控制台探针、
   `MH_PORTAL_VER = 247`、`school-portal/index.html` 四处无扩展名引用全改 v247；v246 原样保留。

## 闸门结果（全过）
- **闸①（语法 node --check 全量）**：抽出页面 2 个内联 `<script>` 块逐一 `node --check` → **0 错**。
- **闸②（N1 差集：v246→v247 只增不减）**：`id=` 209→209、`<button>` 400→400、`<input>` 104→104、`<select>` 33→33 **全不变**；
  `onclick=` 447→448（**仅 +1**，就是新行那个 `<a onclick="_v242GoSetFiling()">`）；id 集合完全一致、onclick 处理函数集合一致（`_v242GoSetFiling` 本已存在）。**无任何移除**。✅
- **闸③（无头 file:// + 假后端走查，中英各一遍）**：`CONSOLE_ERRS=[]`（零控制台错误），逐场景：

  | 场景 | 中文结果 | 英文结果 | 裸键 |
  |---|---|---|---|
  | a gz17/before_letter | 本校录取办理方式：17gz · 出通知书前 · 修改 | This school’s admission filing：17gz · Before the letter · Edit | 无 |
  | b none（不显时机） | 本校录取办理方式：不用建档 · 修改 | …：No filing needed · Edit | 无 |
  | c 未设 | 本校录取办理方式：未设置 · 去设置 | …：Not set · Go to Settings | 无 |
  | at0086/after_payment | 本校录取办理方式：at0086 · 付款后 · 修改 | …：at0086 · After payment · Edit | 无 |

  - **d 点「修改」**：`_v242GoSetFiling()` 后 `state.view==='settings'`、`#v242FilingSection` 出现、
    高亮 `outline='2px solid var(--purple-deep)'` 已打上。✅
  - **e 设置页改 at0086 保存后再开面板**：`_v242SaveFiling()`（假后端 rpc 成功）后 `state.account.filingSystem==='at0086'`，
    重取面板该行显示「本校录取办理方式：at0086 · 出通知书前 · 修改」。✅
  - **面板顶部放置**：调 `_renderCloudOfferInline('S1','T1')`，该行出现且位置在「决定录取专业」标题**之前**（iLine 102 < iTitle 255）。✅
  - **零裸键**：所有场景 `rawKey=false`（输出里无 `filing.xxx` 一类原始键名）。✅
  - 红线遵守：**只开本地 `file://`**，`window.sb`/`window.fetch` 全 stub 受控数据，绝不碰生产网址/连库；测试账号未使用（本走查不需登录）。
- **闸④（390 宽不横溢）**：干净空白页 390 视口、内容区 360px，8 个场景（a/b/c/at × 中英）行宽均 360、
  文档 `scrollWidth==390==视口`、`overflow=false`。✅

## 证据
- 截图：`~/mh-jobs/shots/F3/f3-01-line-zh-390.png`、`f3-01-line-en-390.png`（390 宽，四场景行渲染）。
- diff：`~/mh-jobs/JOB-F3-01-diff.patch`（v246→v247，117 行，纯增量）。
- 走查脚本（本地、不入 git）：`~/mh-verify/f3-01-walk.mjs`。

四层闸全过。本包只改 school 端 v247 + index.html，未动库/桶/其它四端。
