# JOB-GS0-01 回执 · 学校端横版截图 + 横版试录 + 录制与闸门环境探针

全程只读：只用两所演示校登录看界面、截图、录了一段测试视频、查了本机工具和 Cloudflare 环境。没有建任务、没加候选人、没发 offer、没传文件、没改设定、没点保存。打开学生详情会给演示校写一条自己的操作日志（任务书允许）。下面是结果。

## 一、横版截图（1920×1080，共 17 张 + 1 张联络表，已推公开仓库 shots/GS0/）
每张都对应对照表里的一个画面；推之前做了两道保险：① 截图前把页面里所有真电话改成「+86 *** **** ****」、真护照号改成「***PASSPORT***」、非公司邮箱改成「***@***」；② 所有输入框再盖一层遮罩。保留的唯一真实信息是公司对外客服邮箱 Service@maxhouses.net（本就印在官网页脚，属公开）。逐张肉眼复核过代表性画面（仪表盘/学生详情/浏览/设置/配额/日志/通知/英文页/联络表），干净。

| 文件 | 画面 | 关键内容 |
|---|---|---|
| s01-auth-login-zh | 登录门 | 内测·邀请制登录框、EN/中、注册/忘记密码/申请通道 |
| s02-dashboard-zh | 工作台首页 | 演示大学 SCH-1AD6C8 APPROVED、待你处理2、六个统计卡(0/1/3/2/4/8)、配额面板、三大按钮、任务列表 |
| s03-browse-zh | 浏览学生 | 分桶标签、筛选搜索、学生卡(脱敏，只给 STU/MH 编码) |
| s04-taskList-zh | 招生任务列表 | 「申请创建更多招生任务·第3个及更多需后台审核通过」、招生中8、ADM 任务卡 |
| s05-task-detail-zh | 任务详情 | ADM-100037、一键匹配学生/学生 offer预览、本任务学生区 |
| s06-student-detail-zh | 学生详情 | DEMO AMAL、脱敏档案(无联系方式)、护照号打码、材料(水印查看)、已发Offer状态 |
| s07-createTask-zh | 新建招生任务 | 任务中英文名、招生层次、人数、时间安排、院校类型/学制/城市、报名窗 |
| s08-quotaRequest-zh | 申请提额表单 | 当前配额5/已发8/剩余0/申请后5、**九档芯片 +5/+10/+20/+30/+50/+100/+200/+500/+1000**、申请原因、关联任务 |
| s08b-quotaList-zh | 提额申请记录 | 申请记录列表页 |
| s09-settings-zh | 账户设置 | 学校名/联系人/办公电话/个人手机/微信/官网/城市(字段全在，输入内容已遮罩) |
| s10-accessLog-zh | 下载审计日志 | 总下载/已发原件/已标记异常 计数 + 明细表(时间/学生/材料/权限/学校) |
| s11-notifications-zh | 通知面板 | 右侧抽屉「学生已付款·请上传JW202」等通知 |
| s12-dashboard-en | 工作台(英文) | 同 s02 英文界面 |
| s13-browse-en | 浏览学生(英文) | All/Pre-admission/Agreed/To-do/Admitted/My bookmarks、31 students 列表 |
| s14-task-detail-en | 任务详情(英文) | 同 s05 英文 |
| s15-createTask-en | 新建任务(英文) | 同 s07 英文 |
| s16-emailgate-sch2-zh | 第二所校·邮箱验证门 | guide_sch2 登录后卡在「Verify your email first」(见遗留①) |
| test-rec-contact.jpg | 试录九宫格 | 候选池→任务页→学生详情→返回 的 9 帧联络表 |

**说明**：原计划 s16 截第二所演示校的空态仪表盘，但该校账号卡在「先验证邮箱」门（见遗留），进不去仪表盘，故 s16 实为邮箱验证门画面。另：schX 的提额表单用真按钮「申请增加配额」进入才正确（用程序直调函数会错落到建任务页，已修正）。

## 二、横版试录（只存本机，不进仓库、不传 R2）
- 内容：登录 schX → 进任务候选池滚动 → 任务页 → 打开一个学生详情再关 → 回仪表盘。
- 成片：`/Volumes/Dev/MAXHOUSE/guide/dist/school-test/school-test-landscape.mp4`
- 规格：**1920×1080、30fps、时长 26.3 秒、3.5 MB**，ffprobe 可正常读取（788 帧）。录制时同样做了实时打码，画面无真电话/护照号。
- 只把九宫格联络表推了公开仓库（`shots/GS0/test-rec-contact.jpg`），mp4 本身留本机。

## 三、竖版写死参数清单（只列不改，给 GS-3 改横版用）
全部在录制/合成脚本里，带文件:行号：
1. 录制视口 `jobs/JOB-G1/rec/harness.mjs:167-168` —— `viewport {width:405,height:600}`，`deviceScaleFactor: 8/3`（实渲 1080×1600 的页面帧，竖版 9:16 基础）。
2. 合成画布 `jobs/JOB-G1/rec/assemble.mjs:60`（及 :167 第二条路径）—— `scale=1080:1600` + `pad=1080:1920:0:96`（总画布 **1080×1920**，顶条 96，页面区 1080×1600）。
3. 帧率 `jobs/JOB-G1/rec/assemble.mjs:60,167` —— `fps=30`。
4. 字幕带 `jobs/JOB-G1/overlays.mjs:39,69`（注释见 :2）—— `width:1080, height:224`（紫底白字，≤2 行，56px→48px 梯级压字）；字幕文字宽 `overlays.mjs:77` `width:940px`。
5. 顶条 `jobs/JOB-G1/overlays.mjs:85` —— `width:1080, height:96`。
6. 章名卡 / 片尾卡 `jobs/JOB-G1/overlays.mjs:94,105` —— `width:1080px, height:1920px`。
7. 二维码 `jobs/JOB-G1/overlays.mjs:109` —— `width:360px, height:360px`。
8. 海报/封面 `jobs/JOB-G1/rec/posters.mjs:41,47` —— `1080×1920`（posters/cNN.webp）。
9. OG 分享图 `jobs/JOB-G1/rec/posters.mjs:54` —— `width:1200,height:630`（og.png，16:9 横版，已是横的但仍写死）。
10. 走查视口 `jobs/JOB-G1/g5-walk.mjs:8-9,31,36` / `g5-measure.mjs:37` / `g5-ui-check.mjs:6,40-41` —— `390`（手机竖屏宽）。

## 四、工具探针（本机有/无）
- 语音：**Tingting（中文 zh_CN）在、Samantha（英文 en_US）在**。
- ffmpeg **9.0.2 在**、ffprobe **9.0.2 在**。
- 字体 **PingFang 在**（PingFangUI.ttc，系统自带）。
- Playwright **1.63.0 在**（在 ~/mh-verify/node_modules）。

## 五、Cloudflare / R2 环境（只读 whoami 与 list，没改任何设置）
- wrangler **已登录**（OAuth，maxhouseapp@gmail.com；账号 ID c1bdb0f0…）。
- **Pages 项目**：`maxhouse`，生产分支 **main**，域名 www.maxhouses.net（+ maxhouse-2qs.pages.dev），Git 连接，最新部署来自 f53ac37（G5 提交，约 1 小时前）。
- **R2 桶**：只有一个 `maxhouse-media`（2026-10-05 建）。媒体走 media.maxhouses.net。
- **KV**：**空，一个都没有**。
- **functions/ 目录**：有，`functions/share/[[path]].js`（分享链接的 Pages Function）。
- **wrangler.toml**：根目录没有；**_redirects**：没有；**_headers**：有，缓存规则覆盖五端(版本文件30天immutable、index不缓存、vendor 7天)，`/guide/student/*` 为 max-age=300 + stale-while-revalidate=86400（G5-01 加）。
- **云函数源码**（supabase/functions，共 12 个）：admin-doc、admin-reset-student-password、ai-translate、fetch-logo、filing-prefill、notify-email、precheck-ai、send-invite-email、send-verify-email、student-avatars、watermark-doc、_shared。学校端用到的 fetch-logo/send-verify-email/student-avatars/watermark-doc 都在。
- **三个线上探针**：`/guide/school/` → **404**（学校引导页还没上线，符合预期）；`media.maxhouses.net/guide/student/v2/manifest.json` 不带凭据 → **200**（媒体桶公开）；`www.maxhouses.net/admin-portal/` 不带凭据 → **302 跳 maxhouseapp.cloudflareaccess.com**（Cloudflare Access 在用，管理端受保护）。

## 闸门自查（任务书 GS0-01）
- ① 截图 ≥15 张且各对应一个画面 → 17 张 + 联络表，过。
- ② 试录 1920×1080、≥25fps、15-30s、ffprobe 可读 → 1920×1080/30fps/26.3s/可读，过。
- ③ 竖版写死清单 ≥5 条且带文件行号 → 10 条，过。
- ④ 语音/字体/ffmpeg/Playwright 各有在/不在结论 → 均「在」，过。
- ⑤ CF 四条命令各有输出 + 三个线上探针各有状态码 → 全有(404/200/302)，过。

## 给业主的遗留 / 要留意的事
1. **第二所演示校 guide_sch2 进不去仪表盘**：Supabase 层邮箱已确认，但学校端自己的「邮箱验证门」(is_my_email_verified) 还没过，登录后一直停在「Verify your email first」。做演示数据轮（GS-2）前，需要先给这个账号过一次学校端的邮箱验证，否则录不了第二所校的画面。
2. guide_sch2 还没设等级（tier 空），名额总数算不出；schX 是 trial(5) 但已发 8 超额——录制提额/超额提示时正好能用，但别当「正常余额」演示。
3. 试录成片只在本机 guide/dist/school-test/，没进仓库也没传 R2。

没有红线触发，没有停工。下一包 GS0-02（学生页去下载 + 上线真验 + 收官）。
