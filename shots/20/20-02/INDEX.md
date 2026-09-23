# JOB-20-02 公开截图索引（中介端 v168 · 真页面真点 · partner1 真登 · 邮箱打码）

真页面：本地静态服起仓库（assets/vendor 同源）+ 线上 Supabase；partner1 真登 → 进 StuB 详情弹窗 → 护照栏 setInputFiles 一张合成「无机读码/姓名不一致」护照（只暂存、绝不提交）。判定一律用脚本量出的几何数字/颜色/可见文字。#emailInput 已 mask；学生 StuB、编号 MH-FG85、姓名均为测试合成数据。

- `bug1-roster-visible-GREEN.png` —— 核对结果出来后 ≤1s 名单块可见（旧版红：verdict 已出但名单块不现，要等下次整栏重画）。量得：verdict 5221ms 出，1s 后名单块 present+visible，666×107。
- `bug2-roster-gone-after-delete-GREEN.png` —— 点缩略图红× 删暂存件后 ≤1s 名单块消失、暂存缩略图归零（旧版红：删后名单块 666×107 仍在）。
- `bug3-en-halfwidth-colon-GREEN.png` —— 英文界面卡片标题「Passport check: 」用半角冒号（旧版红：中文全角「：」）。
- `bug4-cardstack-clear-1280w-GREEN.png` —— 桌面宽 1280：提醒卡片钉右上角（x904,y16,360×116），与提醒框/缩略图/提交按钮/名单块矩形零重叠（旧版红：中央底部 520px 盖住缩略图 34840px²）。
- `bug4-cardstack-clear-390w-GREEN.png` —— 手机宽 390：卡片 x16,y16,358×116，零重叠且不出屏（旧版红：7424px²）。

对应 RED 基线见 `~/mh-jobs/shots/20/20-00/`（bug1/2 红、bug4 红）。
