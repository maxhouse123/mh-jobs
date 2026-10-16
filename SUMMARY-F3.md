PUSH_OK=yes

# SUMMARY-F3 · 收官（2026-10-16）

> PUSH_OK=yes：三笔提交业主已在原生终端推上 main（含学校端 v247），线上 Cloudflare 已部署到 v247，
> CC 已用真浏览器真账号在线上把本轮新功能真验过（下「线上真验」节）。三样断言全过，无阻塞。
>
> （历史记：早先 CC 自推被本机权限闸拦，故一度 PUSH_OK=no；现由业主自推完成，CC 接手做完 F3-02 线上真验收官。）

## 线上真验（JOB-F3-02，2026-10-16）—— ✅ LIVE_V247_OK=yes

- **推送核对**：`git fetch` 后 `git log origin/main..HEAD` 空（本地＝线上）；main 上 `school-portal/index.html` 指向 v247、文件在。推了三笔：`64a5d9e`（F3-01 v247）/ `ce69d8f`（F3-00 脚本摘照片步）/ `9bab93c`（F2-05 建档复原）。
- **部署**：真浏览器读 `/school-portal/` 控制台 `[VER]`，**第 1 次就是 v247**（没等满 15 分钟）。
- **真验（schX 真账号，不改设置、不真发 Offer）**：
  1. 路①候选池：进 **ADM-100005** 候选池开一名可发录取学生档案 → 发 Offer 面板顶出现整行「**本校录取办理方式：17gz · 出通知书前 · 修改**」（schX 库里办理方式＝gz17/出通知书前，显示一致）。截图 `shots/F3/live-01-line.png`。
  2. 点「修改」→ 关弹窗、跳**设置页**、办理方式区块 `v242FilingSection` **紫色描边高亮**。截图 `shots/F3/live-02-edit-jump.png`。
  3. 路②档案弹窗那条路再开同一学生发 Offer 面板 → **同一行也在**。截图 `shots/F3/live-03-modal-line.png`。
  - （源码里候选池与档案弹窗共用同一段渲染代码 `_renderCloudOfferInline`，故这行从哪条路进都出；线上两路各走一遍印证。）
- **机器判定**：`F3_02_LIVE_PASS = true`。
- **控制台红字全抄**：仅一条 `Failed to load resource: the server responded with a status of 400 ()`（无网址）。另跑两次干净复现（登录路 + 进任务开档案路）**均 0 个 400**，判为偶发、与 v247 无关（v247 零新 RPC/零新网络请求），未拦任何一步。详见 `JOB-F3-02.md`。
- **v247 本地 md5**：`98557ed0f85dfd4313bbf97f261343d3`（线上裸 md5 受 CF 边缘改写不作判据，判据＝fetch 差集空 + 线上 [VER]=247）。

## 两包结论

### F3-00 种子脚本摘照片占位步 —— ✅ 完成
- 改了 **6 个文件、6 处**，把"脚本直接塞照片占位行"全摘掉（护照/学历/成绩单照旧）：
  `JOB-G0/g0-04-backstage.sql`、`JOB-GS2/gs2-03-students.sql`、`JOB-GP1/states/build-core.sql`、
  `JOB-GP1/states/pt04-reg.gen.sql`、`JOB-G1b/seed-amal.sql`、`JOB-GP1/rec/mk-accounts.mjs`。
- 统一旁注「照片只许学生自己上传（业主 2026-10-16 裁决），本步已摘」；文件不删。
- 闸：node --check（mjs）0 错；非注释行 `'photo'`+doc_type 插入 = 0（6 文件全 0）。
- 装脸脚本族（F2-00 已 exit1 停用）、只读校验、本地 stub 不在范围，已登记。详见 `JOB-F3-00.md`。

### F3-01 school v246→v247 发 Offer 面板加「本校录取办理方式」行 —— ✅ 完成（四闸全过）
- 新助手 `_v247FilingLine()` 读 `state.account.filingSystem/filingTiming`，插在 `_renderCloudOfferInline` 面板顶。
  **图纸说「两处面板」，真源码里两处共用这一个渲染函数，一处插入即覆盖两上下文**（详见 `JOB-F3-01.md`）。
- 系统/时机显示名复用 `filing.*` 词条；「去设置」复用 `filing.gateGo`；
  新增三键 `filing.inlineLabel/inlineEdit/inlineUnset`（四语；`inlineUnset`=「未设置」是图纸两键之外多加的第三个，
  因全仓无可复用「未设置」键，借 `filing.sysNone`「不用建档」语义错，故新建——醒目登记供业主过目）。
- 「修改/去设置」走现有 `_v242GoSetFiling()`；零新 CSS 规则（行内小字 + auth-link 类复用）。
- 版本四件套齐：文件名 v247 / 头注 / `[VER] school portal v247` / `MH_PORTAL_VER=247` / index.html 四处；v246 原样保留。
- 四闸：① node --check 0 错；② N1 只增不减（id/button/input/select 全不变，onclick 447→448 仅那一行，无移除）；
  ③ 无头 file://+假后端 中英各一遍：a/b/c/d/e + at0086 全对、零裸键、零控制台错、「修改」落设置页并高亮、存 at0086 后当场显新值、面板顶部放置正确；
  ④ 390 宽 8 场景零横溢。截图 `~/mh-jobs/shots/F3/f3-01-line-{zh,en}-390.png`；diff `~/mh-jobs/JOB-F3-01-diff.patch`。

## v247 md5（本地）
`98557ed0f85dfd4313bbf97f261343d3`
（提醒：Cloudflare 边缘会改写 HTML，线上裸 md5 与本地必然不符，不作判据；核验按铁律15修订走 git fetch 空差 + 线上 [VER] 探针。）

## 推了哪些提交
**尚未推**（本地 HEAD 领先 origin/main 三笔，等授权）：
- `64a5d9e` JOB-F3-01（school v247 + index + 回执）
- `ce69d8f` JOB-F3-00（6 种子脚本 + 回执）
- `9bab93c` JOB-F2-05（此前未推的 F2 收尾：SCH-BFB599 建档复原探针+restore+裁决原件）
（F3-02 §要求"本轮提交连同此前未推的 F-1/F-2 jobs 回执提交一起推"，上述三笔即全部。）

## 线上真验 —— ✅ 已完成（见本文件顶「线上真验」节 + `JOB-F3-02.md`）
推送由业主完成、线上到 v247、CC 已真验三样全过（候选池那行 / 点修改跳设置页高亮 / 档案弹窗那行），
截图 `shots/F3/live-01-line.png`·`live-02-edit-jump.png`·`live-03-modal-line.png`。F3 全块收官。
