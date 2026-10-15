最后一趟：2026-10-15 20:05 GP-3：第 13 趟做完裁决 f+g 返工的「修复+重合成」段——①字幕带改两档字号(S1=0.26h/S2=0.21h，去 overflow 裁切)绝不截断，全量闸 392/392 过(成片 recon 复测)、0 截断，5 条收字号 fs=46 全文完整(含业主点名 2-4)；②3-8 大 pill：rec-v2 选框首选结构选择器(不回退文本)，单测 3/3，重录 en/ru ch3 竖各 9/9 过、肉眼橙环框大 pill(DB scoped 复位已清)；③fr-land 6-1 箱内橙测证实唯它真不同步(其余 7 变体 fm 已剪对、不动)，加 override(firstOn 1.786)；④全 80 章重合成 80/80、跟随框 384 镜、暗罩 383/384(唯 ch6-land-fr 6-2 经成片帧证实为暗罩误报·实同步)。下趟＝打包段：派生(整片/分段/lite/海报，须全重出)→其余全闸(剪头定格/禁用词/二维码/PII/联络表)→清单 m/两份→上传计划 --dry-run→页面§四+版本串 gp2-20261015c→重写停点二乙请示单(上张已被 superseded)。【19:11 存档】GP-3 到停点二乙：GP3-02 路线丙第 11+12 趟做完——①全闸(§五)全过：剪头定格 408/408 动作保住(+12 对比图)、字幕带规格 48 抽样 0 挂(带高横 140/竖 224、不透明紫、白字加粗)、跟随框 80 章 384 镜 0 超标(暗罩法)、禁用词/PII 276 条 CLEAN、片尾二维码 8 条全解、联络表 80 张；②v5 posters/thumbs/cover 重出 176 webp；③清单 m/<lang> 两份重建(base 公共根、章→v5/<lang> 带新 md5、trailer→v4，index.html murl 零改)；④上传计划 dry-run：431 对象 379.8MB 全部新建(0 覆盖 v4)；⑤页面 §四：静音键→内联 SVG 两态、版本串 gp2-20261015b、查清默认静音＝工装非页面(源码零 muted/零 autoplay)，页面回归 0 挂；⑥主仓库点名提交 f270e28(未推) guide/partner+jobs/JOB-GP3。写停点二乙请示单(NEEDS_OWNER_DECISION-20261015-1911)，附 4 处残疑(fr-land 6-1 橙测/竖版 3 行/铁律15 肉眼/两处码率海报边际)待业主一句话裁。下趟＝业主传 v5+推页面后 CC 做 GP3-03 线上真验+收官。【第 11+12 趟存档见下】【第 10 趟存档】GP3-02 路线丙第 10 趟做完——建 gp3-derive-v5(film 派生)+gp3-lite-v5(DIST→partner-v5)，重出 v5 整片/分段/lite 四语。整片 8(四语×横竖)、章 lite 80、分段 HD land44/port43+同数 lite、段清单 8 份全出；整片比 v4 短约 60s(剪头生效)、四语横竖全段落 20~40s(唯 ED 尾段有意短)。两处定案：①splitter 改读 recon actualDur 按 scale=mp4/ΣactualDur 比例切(修 D-9-4，clip 累加有音轨漂移 ch7≈0.34s)；②分段收尾改「借镜头平衡」破旧算法的 51.6s 巨段。lite 闸 en/zh/fr 全 PASS、ru 1 CHECK(port seg05 223k 边际过冲，不阻塞)。下趟：全闸(联络表/禁用词/二维码/PII/字幕带规格/剪头定格对比图/跟随框闸)→清单 m/<lang> 两份(新 md5)+cp gp2-upload.sh 改 v5 前缀 --dry-run→页面 §四两处(静音 SVG+默认有声)+版本串 bump(gp2-20261015b)→停点二乙请示单。【上趟存档】GP3-02 路线丙第 9 趟做完——新引擎重跑全 80 章（--force 分段 chs1-5 重置+chs6-10 追加），80/80 合成成功、时序全过章 80/80、follow 镜 384 超标 0；全 80 recon 统一带 subAbs（例外镜 8=7-0×8、override 镜 16）；双闸统一复测绿（暗罩法 376 常规镜 maxOn≤0.25；橙测 ch7 全 8 变体 7-0/7-1 全过 0.3s）；字幕带学生规格已入引擎烧进成片（视觉验收留业主二乙·铁律15）。查清派生做法并定案一处正确性点：v5 派生 splitter 必须读 recon.json shots[].clipStart/clipEnd 切段（旧 gp1-finish 按原始公式重算会切错点）。下趟：建 gp3-derive-v5+gp3-lite-v5 重出整片/分段/lite→全闸(联络表/禁用词/二维码/PII/字幕带规格/剪头定格清单)→重建 m/清单+上传计划 dry-run→页面 §四两处+版本串 bump→停点二乙。

【第 7 趟存档】GP3-02 路线丙第 7 趟——prod-ch-v5 接重录帧来源切换 + 多态拼章（ch5），全 80 章重合成到暂存 ~/guide/dist/partner-v5（不碰 v4）并逐章跑跟随框闸。结果 80/80 合成成功、318/392 镜实测过 0.3s 闸（甲对齐在环可清晰测得处全修好，对照原始 385/392 超标）；实测超标仅 3 镜全是 ch7-land-en/fr/ru 的 7-0（¥0 优惠码镜，onDelay 1.2~1.83）。根因：7-0 橙框框的是优惠码生效后才出现的「¥0」，橙环真在字幕起~1.8s 后才亮＝真不同步；followmeasure 暗罩法把 firstOn 误定在弹窗变暗瞬间而非橙环亮起。7-0 正是 RULING-e §一.2 预授权例外（字幕述头部动作、框高亮结果→不剪头+字幕延后到环亮）。74 解析镜（测量盲）集中在弹窗镜，ch6/7/8 疑同样被掩盖同类病。属自处理项（§二+§一.2），非停点。下趟：橙色像素法测环亮→实现 §一.2 例外→复核解析镜→派生+全闸+v5上传计划 dry-run+页面两处→停点二乙。

## 任务顺序
- [x] GP3-00 诊断（停点一）—— 已裁：页面先修 GP3-01、成片后修 GP3-02
- [x] GP3-01 修页面（页面方案）—— 本地提交未推，闸全绿，停点二甲（等业主验收+推）
- [~] GP3-02 修成片 —— 裁走路线丙(RULING-e)。进度：
      · 甲·合成层对齐引擎 prod-ch-v5 建成+三章验证(第4趟)
      · 录制工装 rec-v2 建成(§二三处改)+ ch3 竖版 en 重录验证 9/9 过 0.3s(第5趟)
      · ch3 竖版 zh/ru/fr 重录 各 9/9 过 0.3s(第6趟)——§二「只重录 ch3 竖版四语」四语全备
      · prod-ch-v5 接重录帧来源切换 + 多态拼章(ch5)；全 80 章重合成到暂存 partner-v5(不碰 v4)+逐章跑闸(第7趟)：80/80 合成成功、318/392 镜实测过、实测超标仅 ch7-land-en/fr/ru:7-0(¥0 优惠码镜真不同步，§一.2 例外待实现)
      · 橙色像素法(#F39200)复核全部 74 解析镜(第8趟)：真病只两类——7-1 全 8 变体暗罩定早 Δ+2.6~3.0s(被解析掩盖的系统性真不同步，橙测重对齐已修)；7-0 全 8 变体走 §一.2 例外(prod-ch-v5 已实现不剪头+开头静默+字幕/旁白延后到环亮)。其余弹窗镜本就无不同步留 fm；fr-land 6-1 列残疑。ch7 全 8 变体重合成到 partner-v5、双闸(verify-timing 暗罩 + verify-ring-composite 橙测)全过；fr-land-ch6 复原。工具：ring-pixel-v5 / ring-measure-batch / verify-ring-composite-v5 / ring-override.json（16 条=7-0×8+7-1×8）
      · 新引擎重跑全 80 章(第9趟)：--force 分段(chs1-5 重置 40 + chs6-10 追加 40)，80/80 合成成功、时序全过章 80/80、follow 镜 384 超标 0；全 80 recon 统一带 subAbs(例外镜 8=7-0×8、override 镜 16)；双闸统一复测绿(暗罩法 376 常规镜 maxOn≤0.25、maxOff≤0.04；橙测 ch7 全 8 变体 7-0 −0.08~+0.02 / 7-1 land≈0·port+0.23~0.25 全过 0.3s)；字幕带学生规格已入引擎(不透明紫+加粗700+字号 h·0.26+竖224/横140)烧进成片，视觉验收留业主二乙(铁律15)
      · v5 派生重出(第10趟)：建 gp3-derive-v5(cp gp1-finish film 流程，DIST→partner-v5，splitter 改读 recon actualDur 按 scale=mp4/ΣactualDur 比例切段——修 D-9-4：clip 累加 actualDur 与 mp4 容器时长有音轨 apad 漂移 ch7≈0.34s；分段收尾改「借镜头平衡」破 51.6s 巨段 D-10-1)+gp3-lite-v5(cp gp2-01-lite，DIST→v5，chapters+fullseg)。产出：整片 master 8、章 lite 80、分段 HD land44/port43+同数 lite、段清单 8；整片比 v4 短约 60s、四语横竖全段 20~40s(唯 ED 尾段有意短)；lite 闸 en/zh/fr PASS、ru 1 CHECK(port seg05 223k 边际，不阻塞)。OP/ED 复用 _book 不改、trailer 不重出指 v4
      · 待办(下趟)：全闸(联络表/禁用词/二维码/PII/字幕带规格/剪头定格清单最差12对比图)→重建 m/<lang> 两份清单(新 md5)+cp gp2-upload.sh 改 v5 前缀出上传计划 --dry-run→页面 §四两处(静音 emoji→内联 SVG 两态+查默认静音源保证点章有声)+版本串 bump(gp2-20261015b)→停点二乙请示单
      · 派生正确性点(第9趟定案)：gp1-finish splitChapter/chapterShotDurs 用 prod-ch 原始公式重算镜时长按 total/recon 比例切段；v5 章因剪头/定格真实镜时长已变→旧公式切错点。正解＝读 recon.json shots[].clipStart/clipEnd(实测已存在)。OP/ED 复用 REC/out/_book 不改；trailer 及派生/分享图不动、清单指 v4
      · online-01 控制条图 16 张已拍 / followmeasure.json 全量已出 / 留记 ru 3-8 框元素 + fr-land 6-1 残疑待二乙裁
      · 【第 13 趟·裁决 f+g 返工·修复+重合成段】①字幕带去 overflow 截断→两档字号(S1=0.26h/S2=0.21h、行高1.12、不丢字)，新全量闸 gp3-subband-gate2 成片 recon 复测 392/392 过·0 截断·5 条 fs=46 全文完整(含点名 2-4)；②rec-v2 _resolve 首选结构(不回退 text=)修 3-8，单测 3/3+_unit-union 2/2，重录 en/ru ch3 竖各 9/9、肉眼框大 pill(DB scoped 已清)；③ring-inbox-v5 箱内橙测证唯 fr-land 6-1 真不同步(其余 7 变体 fm 已剪对)→只 override fr-land-ch6/6-1(firstOn1.786)；④全 80 重合成 80/80、follow 384、暗罩 383/384(ch6-land-fr 6-2 经成片帧证为暗罩误报·实同步)。改源码 overlays-v5/prod-ch-v5/rec-v2/verify-ring-composite(+boxfrac)；证据 shots/GP3/{rec3-v2 en|ru 3-8,followbox-v5 6-1/6-2,subband2 2-4}
      · 待办(下趟·打包段)：派生(整片/分段/lite/海报缩略封面，按新 80 章全重出——旧派生是 pre-fix 的作废)→其余全闸(剪头定格清单/禁用词/二维码/无PII/联络表)→清单 m/<lang> 两份(新 md5)→cp gp2-upload.sh 出 v5 上传计划 --dry-run→页面§四两处(静音 SVG+版本串 gp2-20261015c)→**重写**停点二乙请示单(上张已被 superseded，按 RULING-g 返工后重开)
- [ ] GP3-03 线上真验 + 收官

## 已停点二甲（等业主本地验收 + 推页面）
- 请示单 jobs/JOB-GP3/NEEDS_OWNER_DECISION.md（= JOB-GP3-NEEDS_OWNER_DECISION-20261015-1331.md）
- CC 本机已提交（未推）：guide/partner/index.html（版本串 gp2-20261015a）
- 证据 ~/mh-jobs/shots/GP3/gate/（128 张四态截图 + _gate-results.json）

## 本趟记录（GP3-01）
- 只改 guide/partner/index.html（+97 −5）。顶部播放器 cover→contain；两播放器去原生 controls；attachCtl 自绘控制条放视频框外下方（播放/拖进度/时间/静音/全屏，画质沿用 #qbar）；手机 playsinline、原生全屏、键盘空格/左右、点视频切播。
- 闸 gp3-01-gate.mjs：页面本机截流、媒体只读走线上 v4；四语×手机/电脑×竖横×两播放器×四态，结构+紫带像素+页面回归全绿 16/16。紫带露出 0.42-0.91 vs 旧版被盖 0.063，阈值 0.30。
- 决定 D-GP3-2-1..7（版本串格式 / 画质档不搬入 / 全屏仅临时开 controls / 闸像素法 / band-in-box 需 videoWidth>0 / 媒体走线上 / 一文件点名提交未推）。

## 已停点二乙（等业主传 v5 + 推页面；2026-10-15 第 11+12 趟）
- 请示单 jobs/JOB-GP3/NEEDS_OWNER_DECISION.md（= ~/mh-jobs/JOB-GP3-NEEDS_OWNER_DECISION-20261015-1911.md）。标题「GP3-02 成片已备好」。
- CC 主仓库点名提交（**未推**）f270e28：guide/partner/index.html（§四 静音 SVG+版本串 gp2-20261015b）+ guide/partner/m/{en,zh,ru,fr}/{manifest,lite-manifest}.json（指 v5）+ jobs/JOB-GP3 工装/闸/决定账/请示单。
- 业主两步（顺序不能错）：① 原生终端挂代理 `bash jobs/JOB-GP3/gp3-upload.sh` 传 431 个 v5 对象（379.8MB，全新建、0 覆盖 v4）；② 四段式 push 主仓库。推后 CC 做 GP3-03。
- 4 处残疑待业主裁（详见请示单三节）：① fr-land 6-1 橙测 onDelay 1.0s（CC 荐 B 下次全量重录一并修）② 字幕带竖版 3 行（CC 荐 A 收下，同 v4、横≤2/竖≤3）③ 字幕带视觉铁律15 肉眼 ④ ru 竖版 seg05-lite 223k + 1 海报 61KB 边际（知会）。
- 全闸工装/结果（jobs/JOB-GP3/）：gp3-trimfreeze-list / gp3-subband-gate / gp3-text-gate / gp3-qr-gate / gp3-contact-sheet / gp3-posters-v5 / gp3-manifest-v5 / gp3-upload.sh / gp3-02-page-check + 各 *.json + followbox-gate-table.json + v4-manifests-src 快照。
- 证据：~/mh-jobs/shots/GP3/{trimfreeze 12 / subband 48 / contact 80 / page-v5 2}。
- 决定：D-GP3-11-1~8（全闸）、D-GP3-12-1~8（清单/posters/页面/上传计划）。
