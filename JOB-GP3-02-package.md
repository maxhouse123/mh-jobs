# JOB-GP3-02 打包段（第 14 趟）回执 — 派生全重出 + 全闸重跑 + 清单/上传计划 + 页面版本串 → 停点二乙（返工后重开）

日期：2026-10-15 20:28　机器：Mac mini（无人值守循环）

## 背景
第 13 趟按裁决 f+g 把「章成片」本身改好（字幕带两档字号去截断 + 3-8 大 pill 重录 + fr-land 6-1 override）。但第 10~12 趟由旧章派生的 整片/分段/流畅/海报 全是修复前（pre-fix）的货、作废。RULING-g §1 末段授权：按返工后新成片重做派生 + 全闸 + 清单 + 页面，并重写一张新请示单（上张 pre-fix 版已 superseded 归档）。

## 这趟做完的事
### 1. 派生全部重出（旧的作废，基于第 13 趟新 80 章）
- gp3-derive-v5（整片 master 8 + 分段）→ gp3-lite-v5 --set all（章 lite 80 + 段 lite）→ gp3-posters-v5（176 webp）四语。顺序：derive 先（posters 读 full master）。
- 整片时长（横/竖 秒）：en 359.5/347.3、zh 368.7/358.3、ru 378/369.8、fr 367/357.6。分段 segCount 10~11，唯一越界 = ED 尾段 12.6~14.7s（RULING-g §3 明文允许 ED 12~15s）；maxSingleShot 15.4~18s。
- lite 四语 fail=0、maxkbps ≤250（land ceil 250）。posters/thumbs/cover：thumbMax ≤23.3(<25)、posterMax ≤57.7(<60)、cover ≤30.6——上张残疑④ ru/port 61.3KB 海报本趟降到 ≤57.7KB，边际消失。

### 2. 全闸重跑·全绿
| 闸 | 结果 | 工装 / 账 |
|----|------|-----------|
| 禁用词 + PII | 扫 276 条烧入文本 CLEAN（无 beta/test/mock/占位、无负数金额、无真邮箱电话） | gp3-text-gate / text-gate.json |
| 字幕带不截断 | **392/392 全过、0 截断、0 溢出**（--recon 成片真集权威），reconOK 全对 | gp3-subband-gate2 / subband-gate2.json |
| 字幕带证据帧 | 24 张「每语×画幅最长 3 条」+ 1 张 v4↔v5 同镜对比（ch2 竖 zh 2-4） | gp3-subband-evidence（新建）/ subband-evidence.json / shots/GP3/subband2 |
| 剪头/定格 | 408 镜，trimmed 384 / frozen 77 / exceptions 8 / **actionNotPreserved=0** / 12 对比图 | gp3-trimfreeze-list / trimfreeze-list.json |
| 片尾二维码 | 8 条 full 全解出 partner-portal/?src=video-<lang>，FAIL 0 | gp3-qr-gate / qr-gate.json |
| 联络表 | 80 张（ch3-port 四语标 NEWREC），缺 0 | gp3-contact-sheet / shots/GP3/contact |
| 跟随框 | recomp summary 384 follows；6-1 已回 0.25；唯 ch6-land-fr 6-2 被暗罩判 1.53s＝第 13 趟成片帧证实的暗罩误报·实同步，非新病 | recomp-all-v5.summary.json |

- shrink 5 条（RULING-g §1 要求逐条列，全 fs=46、全文完整、都在竖版）：2-4 zh/ru/fr-port、9-2 ru-port、9-3 fr-port。

### 3. 清单 + 上传计划 + 页面版本串
- 版本串 gp2-20261015b→**gp2-20261015c**（页面 D.BUILD + 八份清单 build 全一致，实证打勾）。
- m/<lang>/{manifest,lite-manifest}.json 八份重建：章→v5/<lang>/…?v=<新md5>、trailer→v4/<lang>/…（速览指 v4 不动）、base=公共根；index.html 一行逻辑未改，仅 D.BUILD 字面 b→c。
- 上传计划 gp3-upload-plan.tsv：**431 对象 / 379.5MB**；dry-run（线上 HEAD 只读探测）全部新建、0 已在、0 覆盖＝v5 与 v4 零碰撞不动 v4。
- §0.10 真传路径假模式：TSV 431 行全 4 列、key 全 v5 前缀、本机文件全在且字节匹配、md5 合法、key 唯一（上传循环前置条件满足；真 PUT 经 r2-put.sh 读 .env 属业主卡）。
- 页面回归 gp3-02-page-check 两例（en-port-mob/zh-land-desk）FAIL 0：mute SVG 两态、控制条不盖带、章表 10 全出、零 JS 错。

## 停点
停点二乙（返工后重开）。请示单 jobs/JOB-GP3/NEEDS_OWNER_DECISION.md（= JOB-GP3-NEEDS_OWNER_DECISION-20261015-2028.md）。上张 pre-fix 版已 superseded 归档。
- 业主两步（顺序不能错）：① `bash jobs/JOB-GP3/gp3-upload.sh` 传 431 个 v5 对象（379.5MB 全新建）；② 四段式 push 主仓库。推后 CC 做 GP3-03。
- 残疑：②竖版 3 行（荐 A 收下，同 v4）+ ③字幕带铁律15 肉眼（看 shots/GP3/subband2）+ 知会 5 条 shrink fs=46。上张①（fr-land 6-1 橙测）/ ④（ru 海报边际）已在第 13/14 趟消解。

## 红线守全
只读 partner-v5 成片 + captions + v4 清单快照 + 线上 v4（只读）；写出＝guide/partner/m 八清单 + index.html(D.BUILD) + jobs/JOB-GP3 工装；派生/证据落 partner-v5（仓库外）+ shots/GP3；**本趟零 DB、未推主仓、未传删 R2（仅 dry-run 只读探测）、未碰 Cloudflare、未改端口/首页/guide 其他文件**。CC 本机已点名提交（未推）guide/partner + jobs/JOB-GP3。
