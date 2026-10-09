# JOB-G6b-06 回执 · 上线后线上真验 + 收官（两线全过，PUSH_OK=yes）

日期 2026-10-09 ｜ 无人值守 ｜ 本机 Mac mini（真卷 /Volumes/Dev/MAXHOUSE）

## 一句话（大白话）
上一趟（G6b-05）把活全做完、写了 `NEED_PUSH.txt` 就收工。这趟开工看到 `jobs/JOB-G6b/PUSHED-222545.txt`——说明业主侧已经把 9 笔 JOB-G6b 提交**推上了 origin/main**、Cloudflare Pages 也部署好了。我这趟**在真·线上用真浏览器头 + 真 curl + 抽帧看图，把两条线逐条验了一遍，全过**，写了收官单 `SUMMARY-G6b.md`（首行 `PUSH_OK=yes`）。**最关键的那件事——尼日利亚学生配非洲脸、Lina 换成年轻不戴眼镜的非洲女——在线上眼见为实地确认了。**

## 开工即确认：已推、已部署，不用等
- 主仓库 `git log origin/main..HEAD` = **空**（0 笔待推）；HEAD = origin/main = `a70f6e1`（git fetch 后复核）。
- 线上构建串（真浏览器 UA 取）：学生 `g6b-2026-10-09`、学校 `gs6b-20261009`，**都是本轮新串** → 部署到位，直接真验（轮询第 1 次 22:27 就已是新串）。

## 学生线真验（公开桶 media.maxhouses.net/guide/student/v2，四语）
| 验的事 | 真实结果 |
|---|---|
| 页脚邮箱 | `Service@maxhouses.net` ✅ |
| OVERRIDE 指向 | c05–c13 全指 `-g6b`、full/quick 指 `-g6b`，四语齐全 ✅ |
| 章片 HTTP 200 | 13 章 × 4 语 + full + quick × 4 = **60/60 全 200** ✅ |
| 海报 200 | en 9/9（c05–c13-g6b）✅ |
| 列表小图 200 | 抽查 4 章 × 4 语 = 16/16 ✅ |
| Range 206 | c05-g6b/en 请求 `bytes=0-1023` → **206**、回 1024 字节 ✅ |
| 分享二维码 | 指向 `maxhouses.net/guide/student`（引导页，非外站）✅ |
| **c05 英雄卡的 Lina** | **抽帧看图：年轻非洲裔女性、不戴眼镜、短发微笑**——就是业主要的样子（旧版是看着 40 岁、戴眼镜）✅ |
| 片尾二维码 | full-g6b 末帧解码 = `https://www.maxhouses.net/` ✅ |

## 学校线真验（私有桶，须测试码；/guide/school/media，中文）
| 验的事 | 真实结果 |
|---|---|
| 构建串 | `gs6b-20261009` ✅ |
| 错码 | redeem 乱码 → **404 invalid** ✅ |
| 对码 | 自造 `G6b-test` 码 redeem → **200**（label 回 "G6b-test"）✅ |
| 无证取片 | 不带 cookie 直取章片 → **403** ✅ |
| 目录 | manifest 200：full-g6b **728.6s** / quick-g6b **175.7s**，14 章，其中 7 章(c05/06/07/08/10/12/13)是 `-g6b` ✅ |
| 章片+整片+速览 200 | **16/16 全 200** ✅ |
| 缩略图 200 | **14/14 全 200**（c13 缩略图照旧用 thumb-c13.jpg，代表帧没变，符合 G6b-03）✅ |
| Range 206 | c07-g6b 请求 `bytes=0-1023` → **206** ✅ |
| **c07 候选池看脸** | 抽帧放大逐人核：**Student 03 Nigeria·男 = 明确的非洲裔男脸（就是业主点名的那处，演示生 Chidi，已修对）**；Student 01 Vietnam=东亚脸、02 Bangladesh=南亚脸、04 Egypt=中东北非女、05 Pakistan=南亚脸——**国籍对脸全对** ✅ |
| c08 档案大头像 | Bangladesh·男 = 南亚脸 ✅；档案「脱敏」正常（无联系方式、护照号打码）✅ |
| 片尾二维码 | full-g6b 末帧解码 = `https://www.maxhouses.net/` ✅ |

> 说明：第 6 章（浏览/筛选）镜头主体是筛选弹窗，学生池在弹窗背后以暗化背景出现，不是正面四行脸；同一批演示学生的正面脸在第 7 章候选池已清楚核过（见上）。

## 测试码处理（铁律：删前列清单、只删 G6b-test、绝不碰业主码）
- 为验学校端，往生产 KV（命名空间 worker-mh-guide-gate）加了一个 **label=G6b-test** 的码（max_devices=5、2 天过期）。
- 加之前码仓 **3 个**业主码 + 1 个 edu 键 = 4 个；加完 5 个；
- **验完立刻只删这一个测试码**：列清单（5 个）→ DELETE 仅我的测试码 → 回读（**4 个**，业主 3 码 + edu 键原封未动）→ 再 redeem 该码 = **404 invalid**，确认删净。
- 码值、令牌、业主自用码一个字都没进本回执/截图/仓库。

## 这趟改了哪些文件
- **主仓库：零改动**（G6b-06 只做线上真验 + KV 测试码进出，不碰产品/页面/桶；无新的 JOB-G6b 提交要推）。
- 回执仓库 `~/mh-jobs`：本回执 `JOB-G6b-06.md` + 收官单 `SUMMARY-G6b.md` + 线上联络表 `shots/G6b/online/{student,school}/`（含 c05-Lina 放大脸、c07 候选池放大五人、c08 档案、两线片尾解码帧）。
- 本机验证下载与裁图在 `~/mh-verify/g6b-online/`，不入仓库。

## 结论
G-6b 全轮完成、已上线、线上真验两线全过。`SUMMARY-G6b.md` 首行 `PUSH_OK=yes`。下一轮建议见收官单末节。
