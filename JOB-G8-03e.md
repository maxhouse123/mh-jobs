# JOB-G8-03e —— §4 收口：第 10 章修好后 c10 四语重录 + 四语重拼 + 全闸过

日期 2026-10-10　机器 Mac mini　本趟代号 G8-03e（§4 包 G8-03 收口）

## 一句话（大白话）
上一趟（03d）把第 10 章那张手机上塌掉的「补充信息表」修好了，出了学生端 v413，业主已肉眼验收并推上线。
这趟先确认线上确实已经换成 v413，然后在**修好后的真页面**上把第 10 章的四种语言视频重新录了一遍（标题终于横着排、字段全看得见了），
再把四种语言的成片整个重拼一遍，所有自检闸全过，片尾二维码扫出来正好是官网。
**没改任何产品网页**（只改了录视频用的工具里写的网址版本号），成片先留在本机，下一趟 G8-04 才传到云桶。

## 一、线上 v413 已部署（本趟真测）
- 线上学生端 index 跳转目标 = `maxhouse_student_portal_v413`（已部署）✅
- 直接拉 `…/maxhouse_student_portal_v413.html`：HTTP 200、页面版本探针 = `[VER] student portal v413 (JOB-G8-03d: …补充信息表组件 v1.7 …)`✅
- 结论：cycle=1b（表头修）已上线，可以在真页面上重录 c10。

## 二、录制工具升版到 v413（录视频的工具，不是产品）
上一轮 03c 的坑是「真正导航登录的是 lib.mjs，不是 harness.mjs」。这次两处一起升，免得又录到旧版：
- `jobs/JOB-G0/flows/lib.mjs` STUDENT_URL **v412→v413**（真导航用这个）
- `jobs/JOB-G1/rec/harness.mjs` STUDENT_URL **v412→v413**
- PARTNER_URL 留 v183 不动（本趟只录学生线 c10，不碰 partner 章）。
- 这两处是录制工具，不是五端产品版本号，照 03c 同款处理。

## 三、c10 四语重录（在修好后的 v413 上，真机手机宽度 405）
命令 `node run.mjs --chapter 10 --lang <L>`，四语各一次，真实输出：
```
[c10/en] shots=6 ok=6 lens=30s   frames=335
[c10/zh] shots=6 ok=6 lens=31.3s frames=329
[c10/ru] shots=6 ok=6 lens=33.4s frames=352
[c10/fr] shots=6 ok=6 lens=31.8s frames=342
```
- 肉眼核验 10-4 表单帧（en/zh）：标题「Supplementary Information Form / 补充信息表」**横排一行**、关闭×在右上角、橙色「N 项由平台预填」提示**自动折行**、下面「平台已有信息」「个人信息·婚姻状况」等字段**全部看得见**——就是修好的样子，和上一轮 `g8-03c-ch10-brokenform-en.jpg`（标题一个字母一行竖排、字段看不见）截然不同。
- 画面只出现演示号 Omar（邮箱 omar.demo@example.com，不是 @gmail.com），无名单外真学生。

## 四、四语重拼 + 全闸过（闸的真实输出）
- `node assemble.mjs --lang <L> --all` 四语全成：13 章 + full + quick + posters 全出，每章期望/实际时长 Δ≤0.05s。
  成片时长（秒）：

  | 语言 | c07 | c10 | c12 | full | quick |
  |---|---|---|---|---|---|
  | en | 37 | 33 | 65 | 569 | 153 |
  | zh | 60 | 36 | 82 | 737 | 197 |
  | ru | 61 | 36 | 89 | 705 | 196 |
  | fr | 57 | 35 | 85 | 678 | 184 |

- `node gates.mjs` → **「全闸通过」**（subtitle 检查 344 条 0 失败；audioOnset 对齐误差 ≤12ms）。
- 片尾二维码四语解码（jsqr）全部 == **"https://www.maxhouses.net/"** ✅
- 第 10 章章名已恢复（captions-v2.json 实测含「Supplementary form & students in China / 录取后的补充信息表 + 在华学生专项」）。

## 五、证据帧（shots/G8/，本机 ~/mh-jobs，不入主仓库）
- 新录：`g8-03-ch10-10-4/10-5/10-6-{en,zh,ru,fr}.jpg`（12 张，修好后的表）。
- 既有（03c）：`g8-03c-fee07-{en,zh,ru,fr}.jpg`（7-3 新费名）、`g8-03c-fee12-{en,zh,ru,fr}.jpg`（12-10 新费名 ¥0）、`g8-03c-ch10-brokenform-en.jpg`（坏态对照）。

## 六、本趟写入 / 推送
- 主仓库（**仅 commit 未推**，G8-03 非推送点，cycle=2 推送在 G8-04 末）：
  `1e2d674 JOB-G8-03e:` —— lib.mjs / harness.mjs（URL 升版）+ g8-03-rerecord-plan.txt（进度）+ ch10-after.mjs / ch10-forensics.mjs（03d 取证/验收脚本补入库）。产品 HTML 一行未改。
- 成片在 `guide/dist/<lang>/`（.gitignore，不入库），传桶留 G8-04。
- ~/mh-jobs：本回执 + shots/G8 新 12 张，push。

## 七、还差什么 + 下一步（G8-04，cycle=2 推送点）
- 高清/流畅双档：流畅版 `-lite-g8` + 弱网自动降档 + 流畅整片串播。
- 页面 guide/student index 原子落地：ch10 四语章名同步、dur 更新、OVERRIDE c10→c10-g8、构建串、双档开关，**必须与新媒体上桶同时落**（否则线上页名与播放内容错配）。
- 新对象传 R2（后缀 -g8 / -lite-g8），cleanup 旧对象留 §7。
- 两次推送点里的 cycle=2 在 G8-04 末。

## 八、安全
- 录制只碰演示号 guide-stua（Omar 在华待建档态，纯高亮/只读，不改状态）；真实用户一行不碰。
- 画面无 @gmail.com、无名单外真学生；钥匙/密码不进回执/截图/仓库；accounts.json 只读未读内容；.env 未读。
- 无「必须停」触发：§4 全部可自动完成，照做收口。
