# JOB-F3-00 回执 · 种子脚本摘掉「脚本直接塞照片占位行」

日期：2026-10-16

## 这一步干了啥（大白话）
以前我们"造演示学生"的那些脚本，会顺手帮演示学生塞一张假照片（占位图）进材料库。
业主 2026-10-16 拍板：照片从今往后**只能学生自己（或代传的中介）在网页里上传**，系统脚本一律不许写照片。
所以这一步把这些脚本里"塞照片占位"的那一下全部拿掉了——别的材料（护照/学历/成绩单）照旧，
只少了照片那一项。文件一个都没删，只改了塞照片的那几行，并在旁边写明"本步已摘"。

## 改了哪些文件、各摘了几处

| 文件 | 原来怎么塞照片 | 这次怎么改 | 摘了几处 |
|---|---|---|---|
| `jobs/JOB-G0/g0-04-backstage.sql` | Nour 的材料循环数组里有 `'photo'`（4 项） | 数组去掉 `'photo'`→ 3 项（护照/学历/成绩单），加注释 | 1 |
| `jobs/JOB-GS2/gs2-03-students.sql` | 8 个演示生共用的 `dtypes` 数组含 `'photo'` | `dtypes` 去掉 `'photo'`，加注释 | 1 |
| `jobs/JOB-GP1/states/build-core.sql` | 8 个 SQL 被荐生共用的 `dtypes` 数组含 `'photo'` | `dtypes` 去掉 `'photo'`，加注释；旁边旧注释同步改 | 1 |
| `jobs/JOB-GP1/states/pt04-reg.gen.sql` | 单独一条 `insert ... 'photo' ... 'specimen/photo.pdf'` | 整条 photo INSERT 注释掉，加注释 | 1 |
| `jobs/JOB-G1b/seed-amal.sql` | Amal 的材料循环数组含 `'photo'`（4 项） | 数组去掉 `'photo'`→ 3 项，加注释 | 1 |
| `jobs/JOB-GP1/rec/mk-accounts.mjs` | JS 生成 SQL 的数组 `['passport','education','photo']` | 去掉 `'photo'`→ `['passport','education']`，加注释 | 1 |

**合计：6 个文件，6 处。** 统一旁注文案：「照片只许学生自己上传（业主 2026-10-16 裁决），本步已摘」。

## 没动、但要说清的几处（避免误会）
- **装脸脚本族**（`assign-faces.sql`/`_assign-resolved.sql`/`_rehearse-assign.sql`/`assign-faces.mjs`、
  G6b 同名、`assign-faces-gp1.mjs`、`faces.gen.sql`）：这些是往照片行塞**真脸**（不是 SPECIMEN 占位）的脚本，
  在 **F2-00 已经全停用**（驱动它们的 `.sh`/`.mjs` 开头加了 `exit 1`；rebuild 流水线里的装脸钩子也已摘）。
  它们现在根本跑不起来，且不属于本卡"占位步"范围，故本轮不碰、只在此登记。
- `jobs/JOB-GP1/states/st-pt04-docs-full.sql`、`st-pt04-transcript.sql`、`st-pt04-reset-cleanup.sql`、
  `verify.sql`：里面出现 `photo` 都只是**注释说明或只读校验**，没有真的塞照片行，故不改。
- `jobs/JOB-2x`、`JOB-3x` 等 stub/fixtures/green 脚本里的 `doc_type:'photo'`：是**本地假数据/回归断言**，
  不连真库、不往 `documents` 真表插行，不在本卡范围。

## 闸门结果
- **闸①（语法）**：`node --check jobs/JOB-GP1/rec/mk-accounts.mjs` → **OK**。
  SQL 文件：本机 psql 无离线纯解析模式，且本卡禁跑这些种子脚本（会改演示数据），故按 §F3-00 闸①"不可用则只做 grep 闸"执行；
  本次改动仅为"数组去一个元素 / 注释掉若干行"，不改变 SQL 块结构。
- **闸②（非注释行里 `'photo'` 配 doc_type 的插入 = 0）**：6 个文件逐一 grep，**全部 = 0**。✅
- **闸③**：见上表（6 文件 / 6 处）。

全部闸过。
