PUSH_OK=no

# SUMMARY-F3 · 收官（2026-10-16）

> PUSH_OK=no 的原因：两包代码全部做完、四层闸全过、文件清单核对通过，但**推主仓库这一步被权限闸拦住了**
> （CC 两次执行 `git push origin HEAD:main` 都返回「权限未授予」）。主仓库是生产仓（铁律4 默认 CC 不推），
> 本轮虽授权 CC 自推，但本机权限系统仍要业主点头。**因此线上尚未更新，线上真验（本应到 v247 后做）也还没做。**
> 需要业主授权这一次推送，或业主自己在原生终端推（命令见文末）。推成功后 CC 可一条命令跑完线上真验。

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

## 线上真验 —— 待办（推成功后才能做）
推成功、线上 [VER] 到 v247 后，CC 可跑 `~/mh-verify/f3-02-live.mjs`（登 schX，不改设置、不真发 Offer）：
进 ADM-100005 候选池打开一名可发录取学生 → 验面板顶部「本校录取办理方式：17gz · 出通知书前 · 修改」→
点「修改」落到设置页办理方式区块 → 两张截图推 `~/mh-jobs/shots/F3/` → 控制台红字全抄。

## 业主要做的（二选一）
1. **授权 CC 推**：允许这次 `git push origin HEAD:main`，CC 推完等线上 v247 再跑线上真验、把 PUSH_OK 改 yes。
2. **自己推**（原生终端、先挂代理）：
   ```
   cd /Volumes/Dev/MAXHOUSE
   export https_proxy=http://127.0.0.1:10808 http_proxy=http://127.0.0.1:10808
   git log origin/main..HEAD --oneline      # 推前过目：应是上面三笔
   git push origin main
   git log origin/main..HEAD --oneline      # 推后应空
   git status                               # 应 clean
   ```
   推完告诉 CC，CC 跑线上真验收官。
