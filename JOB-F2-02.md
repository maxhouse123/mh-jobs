# JOB-F2-02 回执 · 学校端账户设置两 bug 修复（v245 → v246，只 commit 不推）

## 一句话结论
学校端两个毛病（①发 Offer 老弹「请先设置录取办理方式」怎么都过不去；②点「去设置」进设置页，
联系人/电话/城市等一片空白）**都修好了**，出新版 **v246**，v245 原封不动留着能回滚。
本包按规矩**只提交、没推、没上线**，等业主卡。

## 病根（照 JOB-F1-02 第四节，一句话）
页面用的「内存暂存盒」`state.settings` 只有点右上角 ⚙设置 那条路才会装数据；而发 Offer 的拦截闸、
拦截弹窗里的「去设置」按钮都没装这个盒子就去读它，于是：闸永远读到空→永远拦；「去设置」进设置页→
盒子空→联系字段全渲染成空白。

## 改了哪几处（全前端、复用现有函数、零新样式、零新 RPC、零新文案键）
| # | 位置 | 改法 |
|---|---|---|
| 1 | `_v242FetchFiling` | 登录后把库里办理方式五项写进**登录后必然存在的 `state.account`**（原先只写「可能还不存在的」`state.settings` 被丢），同时镜像一份到 settings |
| 2 | `_v242FilingGateBlocked` / `_v242FilingRow` | 改从 `state.account.filingSystem` 读（兜底再读 settings）；`'none'`（不用建档）= 已设置 → 放行 |
| 3 | 新助手 `_v246BuildSettingsFromAccount` + `openSettingsView` | 建设置盒时从 `state.account` 一并抄入联系字段 + 办理方式五项，设置页如实回显 |
| 4 | `_v242GoSetFiling`（去设置按钮）+ 「我的操作记录」返回链接 | 改走 `openSettingsView()`（先建盒再进页），不再白屏 |
| 5 | `renderSettingsView` 开头 | 兜底：`state.settings` 为空就按 account 补齐，任何入口都不白屏/不误清 |
| 6 | `saveSettings` | 加守卫：盒未初始化时**拒绝保存并提示**，绝不把库里真值覆盖成 NULL |
| 7 | `_v242SaveFiling` | 存完同步进 `state.account`，当场再发 Offer 立即放行（不必刷新/重登） |

版本四件套齐：文件名 v246 / 头注 / `[VER] school portal v246` 探针 / `MH_PORTAL_VER=246` /
`school-portal/index.html` 四处引用改 v246。

## 闸（全过）
- **① node 语法检查**：v246 两段 `<script>` 编译 0 错。
- **② N1 差集**：v245→v246 `id` 差集 = 0（179↔179），button/input/select/textarea 计数一字不差（400/104/33/16）→ **无 UI 移除、不改皮**。
- **③ 无头走查**（file:// + stub window.sb，zh/en 各一遍，截图在 `~/mh-jobs/shots/F2/`）：

| 态 | 场景 | 结果(zh/en) |
|---|---|---|
| a | 库里办理方式 'none'，不点⚙直接发 Offer | **不被拦** ✅ |
| b | 库里为空，发 Offer | **被拦 + 弹窗出现** ✅ |
| c | 点「去设置」落到设置页 | 落在设置页、联系人= 「李老师」**非空** ✅ |
| d | 从 ⚙ 进设置页 | 值与 c 一样（李老师）✅ |
| e | 设置页改办理方式(gz17)保存后当场发 Offer | **不被拦**（account.filingSystem=gz17）✅ |
| f | 盒子为空时点主「保存」 | **被拒 + 假后端收到 0 次 update_school_profile** ✅ |
| g | 中英两语设置页 | **零裸 i18n 键、无 undefined** ✅ |

- **④ 390 宽**：设置页 scrollWidth=390 ≤ innerWidth=390 → **不横溢** ✅（zh/en 同）。
- **随卡回归（铁律P3）**：`tests/cardV246.test.js` 共 **28 项全绿**（md5 钉死 + 结构不变 + 七处改点判据 + vm 实跑两函数）。

## 产出
- `school-portal/maxhouse-school-portal-v246.html`（md5 `d823d074…`）+ `school-portal/index.html`（指向 v246）
- `tests/cardV246.test.js`（随卡回归，28 项全绿）
- diff：`~/mh-jobs/JOB-F2-02-diff.patch`（`diff -u v245 v246`，仅改动，给 Claude 审）
- 无头/登录自验脚本（本地 ~/mh-verify，不入 git·铁律11）：`f2-school-gate.mjs`
- 截图：`~/mh-jobs/shots/F2/gate3-settings-zh.png`、`gate3-settings-en.png`

## 状态
**本包只 commit，未推、未上线**；v245 原样保留可回滚。上线与线上真验（含 SCH-BFB599 真校复验）等业主卡。
