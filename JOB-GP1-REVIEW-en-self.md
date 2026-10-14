# REVIEW-en-self.md · 英文母版十一项自审（**第四轮返工后 · v4**）

> **第52趟（第四轮返工·RULING-20261014a-review3）**：第 6 项改引用**字幕行数表**（§四.7 实测·四语 10 章横竖全 PASS），不再用段时长公式；更正第三版「十一项全过、0 条对不上」中第 6 项当时未量行数之说。字幕短句修好：2-4（英俄法）、6-2/9-3（俄）横竖全在限内。**残留已清（第53趟）**：第52趟遗留的 OP-2 **横版** b-roll 横向拉伸——第53趟照 §二.4「没有帧的章才重录」重录第6章横版（新帧实测 3000×1358·tag `<lang>-land-ch6` 已正·现行 rec.mjs 无 orient bug·第6章只读录后 DB verify 17/17 PASS），重出 OP-land + 重拼 full/trailer-land（横竖两版）。亲帧复验 OP-2 横版 b-roll 现为正常横版（1920×1080 无拉伸）、双盲守住（只露盲码/无校名）、¥0 无负数、无 beta；ED-2 二维码重解码逐字一致；§四.7 行数表不变（零字幕改动）复核 ch6 land ALL PASS。**本语言第四轮返工十一项全过、清关**。


> 状态：**十一项全过 · EN 第三轮返工清关 ✅** — 第50趟（2026-10-14 Mac mini 无人值守）收口。
> 本文件是**第三轮返工**（RULING-20261013b-video-only）后的 v3 自审，覆盖并取代第37趟 v2（十章定版重录＋OP 重做＋重拼后的重审）。v2 对第 4、6 章沿用旧录像/旧结论的问题，第三轮已按 §三.10「十章全部用 v185 重录、不沿用任何旧录像」逐章返工（trip38~48），OP-2~5 用新素材重做（trip49），四语全片/速览/分段全部重拼。
> 逐镜对账表（第十一项）见 `REVIEW-en-shots.md`：各章第三轮对账行 + 本趟新增「开场 OP-1~6 + 片尾 ED + 速览」对账节；旧行已标「已被第 N 趟取代」，**0 条「否」**。
> **本轮不改任何端口代码**：`git diff origin/main --stat -- partner-portal` 空、无未跟踪 partner 文件（每趟复核在案）。遮蔽只在录制层（rec.mjs/HIDE_INIT/actOff/MASK）。
> **铁律15 人眼闸仍在**：业主上线前亲验成片，第3项「页头平台自有联系保留不遮」届时可一句话改判。
> 成片（不入 git/mh-jobs）：`~/guide/dist/partner/{ch1..10,OP,ED,full,trailer}-{land,port}-en.mp4` + `segments/`。第二版成片留底 `_v2/`，首版 `_v1/`。

## 成片规格（EN，第三轮 ffprobe 实测）
- 全片 master：land **422.5s** / port **421.6s**。
- 速览（trailer）master：land **166.3s** / port **165.8s**。
- OP 开场（OP-1 品牌卡 / OP-2~5 四条重点卡**新素材快剪** / OP-6 目录卡）；ED 片尾（ED-1 四条回顾 / ED-2 二维码）。
- 全片含章节 ch1–ch10 **全部 v185 定版重录**（trip38~48）+ OP + ED；分段全片 land/port 各 12 段、速览各 5 段，逐段有 video+audio。

## 十一项逐条（每项注明本轮查法）
| # | 审项 | 结论 | 查法 / 证据 |
|---|---|---|---|
| 1 | 每镜 expect/forbid 全过；跟随镜高亮达标 | ✅ | 各章 v185 定版重录时逐镜 expect/forbid + 高亮 resolve 在 rec.mjs 内强制；每章录前/录后 `states/verify.sql` **17/17 PASS**（trip38~48 回执）；本趟开工+收工 verify 亦 **17/17 PASS**。 |
| 2 | 每章横竖联络表、逐张亲眼看图 | ✅ | 本趟用 `gp1-finish --stage contact` 对**最终 dist 成片**重生成四语×横竖×10 章联络表（每镜字幕中点取帧），**不沿用旧联络表**；亲眼复验代表章（ch2 状态行/漏斗、ch7 ¥0/校名揭晓/JW202）。 |
| 3 | 全片无真邮箱/电话/护照/邀请码明文 | ✅（选 A·页头平台联系保留） | 各章 §四.5 in-frame 扫描 no @gmail（演示生/机构经 MASK 全盖 example.com）；OP-4 ¥0 发票 hi-res 亲验邮箱全 `agency.demo@example.com`；护照样号、邀请码掩码、SPECIMEN 样件。页头平台 Service@maxhouses.net ＝平台公开客服（D-15-1 白名单）。 |
| 4 | 字幕↔按钮逐镜对账 | ✅ | 凡字幕引号引控件/标签，逐字引真控件文本（DOM 读）。第三轮 ch3 §三.8 俄法按钮名已对齐（本语 N/A，EN 本就一致）；全表见 REVIEW-en-shots.md。 |
| 5 | 7-0：¥0 大字橙框连续可见≥2s | ✅ | ch7 7-0（trip45）：真付点击+beta 成功吐司全在镜外（actOff）、HIDE_INIT 双保险遮 beta/placeholder，橙框「¥0.00」（同屏 ¥3,000 删除线 · MAXHOUSE −¥3,000）连续可见 ≥2s；OP-4 b-roll 定格同一 ¥0 发票帧 hi-res 亲验无 beta。 |
| 6 | 字幕无溢出、配音不截断 | ✅ | **字幕行数表（§四.7·从最终成片字幕中点帧实测）10 章×横竖全 PASS**（横≤2 行/竖≤3 行·底边距≥8px·工具 rec/_gate-lines.mjs）；**取代第三版「段时长=max(视长,配音+尾)」公式充数**（裁决 §一.4）。详见 REVIEW-en-shots.md 第四轮节。 |
| 7 | 四语字幕禁用词扫描 | ✅ | captions-v1.json 全镜×4 语正则扫描（禁用词 EN/ZH/RU/FR 变体 + 真名校名），**0 命中**。 |
| 8 | 片尾二维码逐语言解码 | ✅ | 本趟对**最终成片** `ED-{land,port}-en.mp4` 抽实帧经 jsQR **真帧解码**：横竖两版均 = `https://www.maxhouses.net/partner-portal/?src=video-en`，逐字一致。 |
| 9 | 整片与速览齐全、按镜界切、速览当独立片 | ✅ | 全片 12 段 / 速览 5 段按真镜界切；速览（§三.11）＝ OP-1~6 → 章节高亮 → ED-1/2（21 镜），开场重做 OP 卡+收尾 ED 回顾+二维码，自成可独立看懂的招募片；seg04=45.4s/seg05(ED 尾)=13s 为固定镜单按镜界切的固有结果，非缺陷。 |
| 10 | 数字与状态合理（无负数/矛盾统计/beta·test/残留） | ✅ | 十章 v185 定版重录：hero「TOTAL PAYMENTS PROCESSED ¥0」、推荐生卡「Invested ¥0」全片**无负数**（第 4 章 v2 的 −¥3,000 由重录销账）；漏斗 9→3→2→1 真值（v185 已修）；beta/placeholder 由 HIDE_INIT/actOff 在录制层杜绝，captions 扫描无 beta/test；OP-4 ¥0 发票 hi-res 无 beta。 |
| 11 | 逐镜对账表 | ✅ | `REVIEW-en-shots.md`：各章第三轮对账行 + 本趟 OP-1~6/ED/速览对账节，**0 条「否」**。 |

## RULING-20261013b 第三节逐条如何处理（EN）
- §三.1（2-3/2-4）trip38：2-3 框首张学生卡整卡；2-4 依次框 5 张卡状态行（非徽章），字幕按真实阶段重写重配音。
- §三.2(a)（5-1）trip42：从通知铃起框住退回通知，再开学生；字幕不改。
- §三.3（3-3）trip40：整段停在档案字段（出生日期/护照号）并高亮。
- §三.4（3-9）trip40：滚到刚提交的 Demo Aisha #10 卡再框。
- §三.5（7-0 beta）trip45：beta 成功吐司 actOff 镜外 + HIDE_INIT 遮，¥0 橙框 ≥2s。
- §三.6（7-4）trip45：只框状态行「Admission complete.」不框整卡，字幕不变。
- §三.7（提额横幅）各露 hero 镜（1-8/ch2/ch8/ch9/ch10）：录前 st-ch8-quota-off 去横幅、录后 restore，verify#13 回基线。
- §三.8（俄法按钮名）trip40：本语 N/A（见 ru/fr self）。
- §三.9（俄法章节条）trip38 起继承：本语 EN「Partner Hub」不在范围。
- §三.10（十章全部 v185 重录）trip38~48：含第 4、6、8、9 章，不沿用任何旧录像。
- §三.11（OP 新素材 + 重拼）trip49：OP-2~5 新素材快剪，四语全片/速览/分段重拼。

## 留给业主的产品问题（EN 复核所见，详见 SUMMARY）
1. 学生卡状态徽章对已拿 offer/已付/已入学的学生仍写「Documents approved · matching」（s.status 读废弃列 students.stage）——视频里只框状态行、不框徽章。
2. 中介端工作台无「名额已用/剩余」显示（故 2-2/8 改述）。
3. 录取弹窗底部「Unlock to view (beta…)」内测链接，真实中介也看得见（视频 HIDE_INIT 遮）。
4. ¥0 付款成功页「Paid (beta placeholder)」吐司（视频 actOff 镜外 + HIDE_INIT 遮）。
5. 列表卡不显示有材料被退回（故 5-1 从通知铃起讲）。
6. 手机宽度「YOUR APPLICATION ID」状态小标签压编号、中文编号折两行（竖版 3-8/OP-3 照实录）。
