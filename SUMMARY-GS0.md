PUSH_OK=yes

# SUMMARY-GS0 · 学校端 G 线第零轮 收官（GS0-00 ~ GS0-02）

日期 2026-10-06 ｜ 跑在笔记本无人值守会话 ｜ 全轮只读为主，唯一代码改动 = 学生页去下载。
三包回执见 `JOB-GS0-00.md` / `JOB-GS0-01.md` / `JOB-GS0-02.md`；截图在 `shots/GS0/`；对照表在 `JOB-GS0-school-map.json`。

## 1. 学校端版本与语言
- 现役 **v245**，文件 `maxhouse-school-portal-v245.html`，md5 `6851ea1ae17f379a520951b8f4b4a5c9`，探针 `MH_PORTAL_VER=245`。
- 界面语言**只有中文、英文两种**（右上角与登录门都只有「EN / 中」）。中英各 1600+ 条词条、完整；俄/法只有 63 条零碎回落词（给学生内容用），**没有俄/法切换按钮**。
- 语言包**内嵌在大 HTML 里**，不是外挂 js。页面只外链两个脚本：`vendor/supabase.js`（连库）+ `assets/mh-viewer-v2-1-1.js`（放大镜）。

## 2. 对照表画面数 + 后台接口有/没有
- 对照表 **34 个画面**，覆盖登录/首页/招生任务/名额与提额/找学生(匹配+盲搜)/候选池/学生详情/材料评审/面试/发offer/offer列表/通知书与JW202上传/确认入学/联系方式互通/导出/建档设定/设置/操作记录/通知/收藏/语言切换。
- 源码用到的 **35 个 RPC 全部存在**（add_task_candidate、create_admission_task、get_task_candidates、school_send_offer_after_interview、school_set_filing、search_students_blind、match_task_candidates、mark_student_enrolled… 逐个核过，无一缺）。
- 用到的 **16 张表/视图全部存在**；**4 个存储桶**在（comm-attachments / offer-letters / offer-samples / school-onboarding-docs；源码里的 `schools` 是表不是桶）。
- 名额等级表 tier_quota：试用5 / 标准20 / 高级100 / 旗舰500；提额九档 5/10/20/30/50/100/200/500/1000（前端）。
- 「一校一生一份有效 offer」唯一约束在：`uq_offer_live_per_school_student`。
- 学校会收到的通知 6 种：面试已确认 / 面试被拒 / 通知书已付款 / 学生已回应offer / 平台对学校申请的决定 / 任务已审核。

## 3. 两所演示校 + 演示学生现状（给 GS-2 用）
| 账号 | 校名/编号 | 状态 | 等级 | 总名额 | 已用 | 建档 | 任务 | 候选 | offer | 已同意 | 已完成 |
|---|---|---|---|---|---|---|---|---|---|---|---|
| schX | 演示大学 / SCH-1AD6C8 | active | trial | 5 | 8(超额) | form | 8 | 9 | 8 | 7 | 4 |
| guide_sch2 | 演示大学二号 / SCH-8E561C | active | 空(未设) | — | 2 | none | 2 | 2 | 2 | 2 | 0 |

- 整个演示池：**is_test 学生 42 人**，其中 25 人已提交、42 人都设了曝光级别、36 人有材料——浏览页够厚。
- 「guide_* 五人」实际只有两个有资料：guide_stuA（6材料/2offer）、guide_stuB（7材料/1offer）；其余 guide-agent/agentfresh/ref1~3 是代理/推荐空壳；guide-rec-en/zh 库里查不到（已回收）。照实记录。
- **要紧（遗留①）**：guide_sch2 卡在学校端自己的「邮箱验证门」（is_my_email_verified 未过，Supabase 层邮箱已确认），登录后进不去仪表盘。GS-2 前需先给它过一次学校端邮箱验证，否则录不了第二所校。

## 4. 横版试录
- 录了「候选池滚动→任务页→打开学生详情→返回」一段：**1920×1080、30fps、26.3 秒、3.5 MB**，ffprobe 可读；全程实时打码（无真电话/护照号）。
- 成片只在本机 `guide/dist/school-test/school-test-landscape.mp4`（不进仓库、不传 R2）；九宫格联络表 `shots/GS0/test-rec-contact.jpg` 已推。
- 另出 17 张横版 1920×1080 截图（全打码）+ 联络表，推在 `shots/GS0/`。

## 5. 竖版写死参数清单（GS-3 改横版用，只列不改，带文件:行号）
1. 录制视口：`jobs/JOB-G1/rec/harness.mjs:167-168` viewport 405×600 · dsf 8/3（实渲 1080×1600）。
2. 合成画布：`jobs/JOB-G1/rec/assemble.mjs:60`(及:167) scale=1080:1600 + pad=1080:1920:0:96。
3. 帧率：`assemble.mjs:60,167` fps=30。
4. 字幕带：`jobs/JOB-G1/overlays.mjs:39,69` 1080×224（≤2行，56→48px；文字宽 940 @:77）。
5. 顶条：`overlays.mjs:85` 1080×96。
6. 章名卡/片尾卡：`overlays.mjs:94,105` 1080×1920。
7. 二维码：`overlays.mjs:109` 360×360。
8. 海报/封面：`jobs/JOB-G1/rec/posters.mjs:41,47` 1080×1920。
9. OG 分享图：`posters.mjs:54` 1200×630。
10. 走查视口：`g5-walk.mjs:8-9,31,36` / `g5-measure.mjs:37` / `g5-ui-check.mjs:6,40-41` = 390。

## 6. 工具 + Cloudflare 环境
- 本机工具：语音 Tingting(中)/Samantha(英) 都在；ffmpeg/ffprobe 9.0.2 在；PingFang 字体在；Playwright 1.63.0 在。
- Cloudflare：wrangler 已登录（OAuth maxhouseapp@gmail.com，账号 c1bdb0f0…）。
- Pages 项目 **maxhouse**，生产分支 **main**，域名 www.maxhouses.net。
- R2 桶只有一个 **maxhouse-media**（媒体走 media.maxhouses.net）。**KV 空，一个都没有**。
- `functions/` 目录有：`functions/share/[[path]].js`（分享链接函数）。无 wrangler.toml、无 _redirects；_headers 有（五端缓存规则 + /guide/student/* max-age=300+swr=86400）。
- 云函数源码 12 个（含学校端用的 fetch-logo/send-verify-email/student-avatars/watermark-doc）。
- 三个线上探针：`/guide/school/` = **404**（学校引导页未上线）；`media.maxhouses.net/.../manifest.json` 不带凭据 = **200**（媒体桶公开）；`/admin-portal/` 不带凭据 = **302 跳 cloudflareaccess**（Access 在用）。

## 7. 去下载的改动点与线上结果
- 只改 `guide/student/index.html` 一个文件：删分享区「下载整片」按钮(#dlBtn)+四语 download 文案键+.dl 样式+href 赋值；构建串 g5→**gs0-2026-10-06**。分享/速览/整片/章节播放全保留；单文件零外链。
- 本地四语无头真验 ALL PASS；上线后轮询到线上构建串 = gs0-2026-10-06，线上四语手机宽真验 ALL PASS（无下载文字/无 download= 属性/第1章+速览+整片能播/0 报错）；肉眼核线上截图分享区只剩四项无下载。
- 线上截图：`shots/GS0/live-nodl-zh.png` / `live-nodl-en.png`。

## 8. 给业主的肉眼事
手机打开 `https://www.maxhouses.net/guide/student/` → 往下滚到「分享本指南」→ 现在只有 WhatsApp / Telegram / 复制链接 / 微信扫码，**没有「下载整片」**了。视频照常能看，分享照常能用。

## 9. 遗留
1. **guide_sch2 卡学校端邮箱验证门**（见 §3 遗留①）——GS-2 前需先过验证。
2. schX 是 trial(5) 但已发 8 **超额**，适合录超额/提额提示，别当正常余额演示；guide_sch2 未设等级、名额算不出。
3. 试录 mp4 只在本机，未进仓库、未传 R2。
4. 学校引导页线上还是 404（本轮不上线，仅摸底）；闸门（访问码/设备数/私有桶/动态水印/高校邮箱验证）留 GS-1。

全轮无红线触发、无停工。
