# JOB-G6-06 回执 · 上线后线上真验 + 收官（两线全过，PUSH_OK=yes）

日期 2026-10-09 ｜ 无人值守 ｜ 本机 Mac mini（真卷 /Volumes/Dev/MAXHOUSE）

## 一句话
上一趟（G6-05）学生线做完、写了 `NEED_PUSH.txt` 就收工。这趟开工看到 `jobs/JOB-G6/PUSHED-175341.txt`——说明业主侧循环**已把 16 笔 JOB-G6 提交推上 origin/main**、Cloudflare Pages 也已部署。我这趟**在真·线上用真浏览器 + 真 curl 把 G6-06 的真验逐条跑了一遍，两线全过**，写了收官单 `SUMMARY-G6.md`（首行 `PUSH_OK=yes`）。

## 开工即发现：已推已部署，不用等
- `git log origin/main..HEAD` = 空（0 笔待推）；origin/main 上 **16 笔 JOB-G6** 提交，HEAD=origin/main=`0a74ac9`。
- 线上构建串（真浏览器 UA 取）：学生 `g6-2026-10-09`、学校 `gs6-20261009`，都是本轮新串 → 不用轮询等部署，直接真验。

## 线上真验结果（全过；真实输出见 SUMMARY-G6.md 对应节）
- **学生页（四语 405px）**：首屏目录无横滚、3 ✓、13 章、构建串新、页脚邮箱 `Service@maxhouses.net`、点第 1 章 20–29ms 出画面、13 章+速览+整片四语 HEAD 全 200、改了的章带 `-g6`/没改的章地址不变、分享二维码仍指引导页（解码 `…/guide/student`）。
- **学校页（中文）**：输码页无 EN 按钮、错码 404、自造 `G6-test` 码 200 发证、4 ✓、14 缩略图 200、整片/速览 ffprobe 时长=manifest（728.9/175.7）、点章全屏、水印 6 秒换位（左上→右上→右下）、Range 206、无证 403。
- **抽帧看脸 + 扫码**：学生 c05 英雄卡 photo.jpg = AI 非洲裔女性人脸；学校 c07 候选池 Student 03–07 五张 AI 真人脸对国籍性别；两线片尾帧解码均 == `https://www.maxhouses.net/`。证据在 `~/mh-jobs/shots/G6/online/`。

## 测试码处理（铁律：删前列清单、只删 G6-test、不碰业主码）
- 为验学校端，往生产 KV（命名空间 worker-mh-guide-gate）加了一个 **label=G6-test** 的码 `MHS-G6TS-TEST`（max_devices=5、2 天过期）。
- 验完：列清单（4 个）→ DELETE 仅 `code:MHS-G6TS-TEST` → 回读（3 个）→ 再 redeem 该码 = 404 invalid。
- **业主自用 3 个码（LSBV / R45X / ZTDN）全程原封未动**；码值/令牌一个没进回执。

## 这趟改了哪些文件
- **主仓库：零改动**（G6-06 只做线上真验，不碰产品/页面/桶；本趟没有新的 JOB-G6 提交要推）。
- 回执仓库 `~/mh-jobs`：本回执 `JOB-G6-06.md` + 收官单 `SUMMARY-G6.md` + 线上联络表 `shots/G6/online/`（学生/学校四帧 + 两张抽脸图 + 两张片尾图 + 页面截图）。
- 本机验证脚本在 `~/mh-verify/`（g6-student-verify.mjs / g6-school-verify.mjs / decode-share.mjs / decode-frames.mjs），不入主仓库。

## 结论
G-6 全轮完成并线上真验通过。`SUMMARY-G6.md` 首行 `PUSH_OK=yes`。下一轮建议见收官单末节（清旧章片、SPECIMEN 清尾、学生第 10 章待组件修、cleanup.sql 健壮化）。
