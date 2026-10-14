# REVIEW-fr-self.md · 法文十一项自审（**第四轮返工后 · v4**）

> **第52趟（第四轮返工·RULING-20261014a-review3）**：第 6 项改引用**字幕行数表**（§四.7 实测·四语 10 章横竖全 PASS），不再用段时长公式；更正第三版「十一项全过、0 条对不上」中第 6 项当时未量行数之说。字幕短句修好：2-4（英俄法）、6-2/9-3（俄）横竖全在限内。**残留已清（第53趟）**：第52趟遗留的 OP-2 **横版** b-roll 横向拉伸——第53趟照 §二.4「没有帧的章才重录」重录第6章横版（新帧实测 3000×1358·tag `<lang>-land-ch6` 已正·现行 rec.mjs 无 orient bug·第6章只读录后 DB verify 17/17 PASS），重出 OP-land + 重拼 full/trailer-land（横竖两版）。亲帧复验 OP-2 横版 b-roll 现为正常横版（1920×1080 无拉伸）、双盲守住（只露盲码/无校名）、¥0 无负数、无 beta；ED-2 二维码重解码逐字一致；§四.7 行数表不变（零字幕改动）复核 ch6 land ALL PASS。**本语言第四轮返工十一项全过、清关**。


> 状态：**十一项全过 · FR 第三轮返工清关 ✅** — 第50趟（2026-10-14 Mac mini 无人值守）收口。
> 本文件是**第三轮返工**（RULING-20261013b-video-only）后的 v3 自审，覆盖并取代第37趟 v2。十章全部用 v185 重录（trip38~48）、OP-2~5 新素材重做（trip49）、四语全片/速览/分段全部重拼。
> 逐镜对账表（第十一项）见 `REVIEW-fr-shots.md`：各章第三轮对账行 + 本趟「开场 OP-1~6 + 片尾 ED + 速览」对账节；旧行标「已被第 N 趟取代」，**0 条「否」**。
> 本轮不改任何端口代码（partner-portal 与线上一致，diff 空）。遮蔽只在录制层。成片不入 git/mh-jobs。

## 成片规格（FR，第三轮 ffprobe 实测）
- 全片 master：land **428.0s** / port **428.4s**；速览 master：land **168.4s** / port **169.0s**。
- 含 ch1–ch10 全部 v185 定版重录 + OP + ED；全片各 12 段、速览各 5 段。

## 十一项逐条（每项注明本轮查法）
| # | 审项 | 结论 | 查法 / 证据 |
|---|---|---|---|
| 1 | 每镜 expect/forbid 全过；高亮达标 | ✅ | rec.mjs 内逐镜强制；各章录前/录后 verify **17/17 PASS**；本趟开工+收工 verify 亦 17/17 PASS。 |
| 2 | 每章横竖联络表、逐张亲眼看图 | ✅ | `gp1-finish --stage contact` 对**最终 dist 成片**重生成（每镜字幕中点取帧），不沿用旧联络表；亲眼复验 ch7（¥0/校名揭晓/JW202/Admission terminée）法文本地化、章节条 Espace partenaires。 |
| 3 | 全片无真邮箱/电话/护照/邀请码明文 | ✅（选 A） | §四.5 in-frame no @gmail（演示生/机构 MASK 全盖 example.com）；OP-4 ¥0 发票 hi-res 邮箱全 `agency.demo@example.com`；平台 Service@maxhouses.net 白名单（D-15-1）。 |
| 4 | 字幕↔按钮逐镜对账 | ✅ | §三.8：fr 3-1 字幕按钮名已对齐界面「Soumettre un nouveau référencement」（trip40 主审 grep 实证 v185 外挂 i18n 真值、重 TTS）；详见 shots.md。 |
| 5 | 7-0：¥0 大字橙框连续可见≥2s | ✅ | ch7 7-0（trip45）真付+beta 吐司 actOff 镜外、HIDE_INIT 遮，橙框「¥0.00」≥2s；OP-4 b-roll 定格同帧 hi-res 无 beta。 |
| 6 | 字幕无溢出、配音不截断 | ✅ | **字幕行数表（§四.7·从最终成片字幕中点帧实测）10 章×横竖全 PASS**（横≤2 行/竖≤3 行·底边距≥8px·工具 rec/_gate-lines.mjs）；**取代第三版「段时长=max(视长,配音+尾)」公式充数**（裁决 §一.4）。详见 REVIEW-fr-shots.md 第四轮节。 |
| 7 | 四语字幕禁用词扫描 | ✅ | captions-v1.json 全镜×4 语正则扫描，**0 命中**。 |
| 8 | 片尾二维码解码 | ✅ | **最终成片** `ED-{land,port}-fr.mp4` jsQR 真帧解码 = `https://www.maxhouses.net/partner-portal/?src=video-fr`，逐字一致。 |
| 9 | 整片与速览齐全、速览当独立片 | ✅ | 全片 12 段/速览 5 段按真镜界切；速览（§三.11）OP-1~6→章节高亮→ED-1/2，自成可独立看懂的招募片。 |
| 10 | 数字与状态合理（无负数/beta/残留） | ✅ | 十章 v185 定版重录：工作台 ¥0、推荐生卡「Investi ¥0」无负数；漏斗真值；beta 由 HIDE_INIT/actOff 杜绝；OP-4 ¥0 发票 hi-res 无 beta。法语界面动态串英文回退照录（D-18-4）。 |
| 11 | 逐镜对账表 | ✅ | `REVIEW-fr-shots.md`，**0 条「否」**。 |

## RULING-20261013b 第三节逐条如何处理（FR）
- §三.1~§三.7/§三.10/§三.11 同 EN（各章 trip38~49 已落）。
- §三.8（俄法按钮名）：fr 3-1 已对齐「Soumettre un nouveau référencement」并重配音。
- §三.9（俄法章节条）：章节条左标签改用 v185 页头法文名「Espace partenaires」（trip38 overlay）。
- D-18-4：工作台统计/漏斗标签/提额/增值服务名等法语界面英文回退照录不补。

## 留给业主的产品问题（同 EN 清单，详见 SUMMARY）
1. 卡状态徽章对已 offer/已付/已入学恒显旧阶段文字（读废弃列 students.stage）——视频只框状态行。
2. 工作台无「名额已用/剩余」显示。
3. 录取弹窗底部内测解锁链接（视频遮）。
4. ¥0 成功页「Paid (beta placeholder)」吐司（视频 actOff+遮）。
5. 列表卡不显示材料被退回（5-1 从通知铃起讲）。
6. 手机宽度申请编号块状态标签压编号（竖版照实录）。
7. 法语界面多处英文回退（产品 i18n 未补全，D-18-4 照录）。
