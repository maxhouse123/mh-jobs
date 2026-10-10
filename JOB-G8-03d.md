# JOB-G8-03d · 第10章「补充信息表」表头手机排版 —— 真修表（业主裁决A）

时间：2026-10-10 第 4 趟。大白话写给看不懂代码的业主。

## 一句话
第10章补充信息表在手机上，表头一旦有橙色「N 项由平台预填」提示就塌（标题被挤成竖条、字段顶到看不见）。本趟按业主裁决 A「修表」真修好了，出了新版 student v413 + partner v184，四语手机/电脑两档本地验收全过。已提交、**没推送**，等业主本地肉眼终验后自己推。

## 二、先只读取证（裁决第五节），病根对上了没？
用 Playwright 在**本地** v412 文件上把坏态原样复现（注入 5 个预填让橙色提示冒出来，手机 390 宽，英文——跟上次线上 brokenform 证据同一个条件），读出的真实数字：

| 裁决第五节判据 | 应满足 | 实测 | 对上？ |
|---|---|---|---|
| 表头 display | flex | flex | ✅ |
| 表头 flex-wrap | nowrap | nowrap | ✅ |
| 标题 clientWidth | < 120px | **16px**（30个字母被挤成25行、高675px）| ✅ |
| 右信息组 scrollWidth | > 视口宽 | **414 > 390** | ✅ |
| 橙色提示 white-space | nowrap（整行不换行）| nowrap，scrollWidth 414 | ✅ |
| 必填字段数 | 55 | 55 | ✅ |

**四条判据全中，病根对上**（表头一行不许换行 + 橙色提示整行不换行 + 标题没最小宽度）。取证脚本 jobs/JOB-G8/ch10-forensics.mjs；坏态图 shots/G8/ch10-forensics-en-390.png（标题竖排、橙条冲出屏幕，与上次线上证据一致）。

## 三、怎么修的（只改一个表单组件的表头 CSS，不碰功能/文字/字段）
- 新出组件 `assets/mh-filing-form-v1-7.js`（v1-6 原样保留），**只在它注入的样式末尾追加几行 CSS**：
  - 表头：允许换行 `flex-wrap:wrap`、顶部对齐；
  - 标题：留最小宽度 `min-width:12ch`，不再被挤没；
  - 橙色提示 / AI 按钮 / 进度：`white-space:normal` 能自动折行、不撑宽；
  - 手机(≤640px)：标题独占一行、右边那组落到标题下面靠左、宽 100%，关闭 × 固定在右上角（绝对定位）；
  - 电脑：表头照旧一行。
- JS 逻辑 / 四语文案 / 字段 / 必填数(55) **一个字没动**，逐项回归同 v1.6。
- 两端都引用这个组件，所以各出一版、只换引用 + 版本四件套（文件名/头注/[VER]探针/index 重定向）：
  - **student v413**（← v412）
  - **partner v184**（← v183，代填也用这个表单）

三份文件逐行 diff 都很干净：组件只多了头注/STYLE_ID/末尾 CSS；两端 HTML 只改了「引用 v1-6→v1-7」+ [VER] + MH_PORTAL_VER 三行（外加各自 index 重定向）。

## 四、改后验收（裁决第四节，本地四语两宽度，闸的真实输出）
脚本 jobs/JOB-G8/ch10-after.mjs，v413 本地打开、注入 5 预填、四语 × 390/1366，断言 + 截图：

```
en 390 PASS :: titleLines=1 progOvf=0 noticeOvf=0 firstFieldTop=449 docOvf=0
en 1366 PASS :: titleLines=1 progOvf=0 noticeOvf=0 firstFieldTop=397 docOvf=0
zh 390 PASS :: titleLines=1 progOvf=0 noticeOvf=0 firstFieldTop=434 docOvf=0
zh 1366 PASS :: titleLines=1 progOvf=0 noticeOvf=0 firstFieldTop=399 docOvf=0
ru 390 PASS :: titleLines=2 progOvf=0 noticeOvf=0 firstFieldTop=476 docOvf=0
ru 1366 PASS :: titleLines=1 progOvf=0 noticeOvf=0 firstFieldTop=433 docOvf=0
fr 390 PASS :: titleLines=2 progOvf=0 noticeOvf=0 firstFieldTop=496 docOvf=0
fr 1366 PASS :: titleLines=1 progOvf=0 noticeOvf=0 firstFieldTop=820 docOvf=0
ALL PASS
```

断言含义：标题 390 宽不超过 2 行（俄/法最长也就 2 行）、右信息组零溢出、页面零横向溢出、第一个表单字段顶到弹窗顶 ≤900px（实测最多 496）。截图 shots/G8/ch10-after-<lang>-390.png 与 -1366.png 共 8 张。我本人肉眼看了 en-390 / fr-390：标题横排、橙条折行靠左、× 右上角、字段全显——对。**肉眼最终是否一致仍以业主本地为准（铁律15）**。

组件语法 `node --check` 通过。

## 五、还差什么 / 下一步
- 本趟**只 commit 未 push**（主仓库 CC 从不推）。已写 `jobs/JOB-G8/NEED_PUSH.txt` 首行 `cycle=1b`，待推 8 笔全 JOB-G8 开头。
- 请业主：① 本地打开 student v413 手机宽度肉眼验收四语表头（见 NEED_PUSH.txt 里的照做步骤）；② 挂代理 `git push origin main`；③ 推完写 `jobs/JOB-G8/PUSHED-<时分秒>.txt` 首行 `cycle=1b`。
- 下一趟（见 PUSHED cycle=1b 后）：轮询线上 student 到 v413 → 线上 390 真登录 guide_stuA 截 ch10-live-390.png 对照坏态 → 重录 c10 四语（c07/c12 已重录好不重录）→ 接 QUEUE-G8 §4 第 3 条 assemble 重拼。
