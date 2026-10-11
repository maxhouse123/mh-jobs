# JOB-GP0-02 回执 —— 十二章素材清单与收官（**完成 · 闸3 通过**）

日期 2026-10-11｜无人值守续跑｜接 GP0-01 之后一口气收官。

## 一句话（给业主）
把正片每一章「要录什么、用哪个号、学生要处于什么状态、还缺什么要新造」列成了一张十二章的清单（`chapter-needs.md`），又把「下一轮该造哪些演示学生、各自什么状态」列成建议清单，再把学生/学校线已经做好的**托管、缓存、双档降速、分享图**等可直接照抄的做法记下来。最后写了全线收官总结 `SUMMARY-GP0.md`（首行 PUSH_OK=yes）。

## 第 1 条 · 十二章素材清单 ✅
- `jobs/JOB-GP0/chapter-needs.md`（= `~/mh-jobs/JOB-GP0-chapter-needs.md`，**两份 md5 一致** `6b909d2164ce45ea5bdccfd297cd1dab`）。
- **十二章**（开场 + 第1~10章 + 片尾）每章三栏齐：**账号 / 状态 / 缺口**。
- 核心结论：Demo Agency 名下现 0 学生，**第 2~10 章都要新造被荐生铺状态**；发 offer 主用 Demo University（8 任务），多校对比加 Demo University 2；录制遮蔽字段按 G-3 D1（邮箱/电话/WhatsApp/WeChat/付款账号/真人 PII）。

## 第 2 条 · 演示数据建议清单（只列不做）✅
- 建议造 **guide-pt-01~10** 十名被荐生（邮箱 `maxhouseapp+guide-pt-01~10@gmail.com`），逐人状态表已列（草稿/审核中/退回/委托自传/在途offer多校/已接受/已付款/已入学/备用）；国籍性别分布供 AI 脸配对（脸库在 jobs/JOB-G6）；一键复位脚本要覆盖的范围已写明（放 JOB-GP1/states，新增型可清回 0 学生）。

## 第 3 条 · 托管与速度可复用项 ✅（来源 SUMMARY-G8 2026-10-10；SUMMARY-G9 本轮尚未出，未读 JOB-G9 文件=守边界）
- 记下 GP-2 可直接照抄的：单文件页面写法、缓存规则（HTML must-revalidate + CF 第二次 HIT + zone 已开 http3/0rtt/early_hints/brotli/tiered-smart）、高清/流畅双档（moovInHead + lite-manifest，码率档）、自动降档（卡 2 次切流畅 + 2 秒提示 + 进度不倒退）、缩略图/海报（posters.mjs，角标残债留意）、速览分段串播（学生 quick 单片 175 秒弱网 >5s 的坑→GP 速览一开始就分段）、make-manifest 版本串地址、OG 分享图、片尾二维码；并记 **R2 的 S3 直连令牌已失效（403），现用 CF REST API + wrangler 传桶**。

## 第 4 条 · SUMMARY-GP0.md ✅
- `~/mh-jobs/SUMMARY-GP0.md`，首行 **PUSH_OK=yes**；正文大白话：版本与四语、手机布局结论（能当原生竖版录）、倍率结论（横 2.5×）、四支样片优缺点一句话、Demo Agency 就位、**GP-1 建议包 7 条**。

## 闸3 判据对账
- chapter-needs.md 十二章每章有「账号/状态/缺口」三栏，且 ~/mh-jobs 有副本（md5 一致）✅
- SUMMARY-GP0.md 存在且首行 PUSH_OK=yes ✅
- **闸3 通过。**

## 产物与合规
- 主仓库：`jobs/JOB-GP0/chapter-needs.md`（点名提交、不推主仓库）。
- `~/mh-jobs/`：本回执、JOB-GP0-chapter-needs.md、SUMMARY-GP0.md。
- 本轮零改产品、零造数据、零录正片、DB 零写入；未碰 JOB-G*/JOB-GS* 原文件、未碰 R2/CF。
