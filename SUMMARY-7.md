# 第七轮队列 · 总回执（2026-09-16）· 手机巡检修复 + 上传体验 + PWA

> 大白话总账。**九包全部交付**（3a/3b 算两个，共 9 包全做完）。全程守双盲、守红线、只加不删、零破坏性 DB 操作。stuA 密码到位后按你授权真登真传，**真机验证还当场抓出并修好了一个 7-05 的病根**。主仓库全程未推——本轮 **10 个本地提交**等你验收后自己挂代理推；日志仓库 `~/mh-jobs` 已实时推全部回执。

## 0. 基底核对（开工前）
起点五端 md5 全对上 SUMMARY-6：admin v206 / student v382 / partner v150 / school v230 / reviewer v31 ✅。

## 1. 九包结果
| 包 | 结果 | 一句话 |
|---|---|---|
| **7-01** | ✅ 闸8 9/9 | 学生端真 PWA：`manifest.webmanifest` + `sw.js`（**只缓存 manifest/图标，绝不缓存 HTML/API**）+ head(rel=manifest/apple-touch-icon/application-name) + index 指针。student **v383**。⚠️ 图标暂用占位（你的 zip 不在电脑上，见待办①）|
| **7-02** | ✅ 走查16/16 | 五端图标审计（PIL 读四角）：白角方形应用图标 `favicon.png`(64×64) + `og-cover.png`(1200×1200 当图标) → 改指四角铺满 `assets/icons/*`；og:image 不动；邮件模板/水印 EF logo 只列不换。admin **v207**/partner **v151**/school **v231**/reviewer **v32** + 根 index。⚠️ 图标占位待 zip |
| **7-03a** | ✅ stub 8/8+5/5 · 真机✅ | 上传反馈层：共享 `_v384`——签名直传+XHR **真进度**，**任一步失败回落 `storage.upload`（红线）**；选完当场出进度卡+3并行池+在途去重+8s慢网提示+失败红卡重试+按钮锁。student **v384**/partner **v152**。**stuA 真传 2MB 实测走签名直传真进度成功（非回落）** |
| **7-03b** | ✅ stub 5/5 | TUS 断点续传：**自托管** `assets/vendor/tus.min.js`（**没用 cdnjs**，守自托管铁律，见待办③）；>1MB 且开关 `mh_upload_tus`(默认开) 走 TUS 6MB分片+retryDelays 断网续传，失败逐层回落 7-03a。student **v385**/partner **v153**。真断网续传闸待线上（待办④）|
| **7-04** | ✅ 390px 4/4 | 「开启新一轮」卡 390px 断词：容器 `flex-wrap:wrap`+左栏 `flex:1 1 200px/min-width:0`+药丸 `white-space:normal`。一处卡片 CSS。student **v386** |
| **7-05** | ✅ 真机✅（修补见§3）| 「YOU'RE ALL SET」卡申请号取错：改取**已确认 offer 所属轮次**的 app_no。student **v387→v389**（真机暴露我 v387 兜底用错列名，v389 修好）。**stuA 真数据实测显示正确 MH-6KG2JN**（原错显 MH-9F4AG7）|
| **7-06** | ✅ 走查7/7 | 文案四项：①材料槽 DOC→WebP；②AI 预检露代码 `'criminal'`→前端显示前换材料名（仅带引号；EF 侧留另开，待办⑤）；③fr/ru 漏翻 ✎Edit/通知标题四语化；④个人陈述 200→1000（statement 列已是 text，**零迁移**）。student **v388** |
| **7-07** | ✅ 走查6/6 | 驳回理由/二审反馈一律英文：admin `verdictReason`、reviewer `rejectDetail`+`rejectAllReason` 下加灰字提示 + 检测中日韩字符→琥珀边框+提示加粗（不阻止提交）。admin **v208**/reviewer **v33** |
| **7-08** | ✅ 走查5/5 · 闸9零新类 | 分页最小自建（6-05 遗留）：共享 `_v209Pager` 只用现成 `btn btn-ghost btn-sm`（**零新 CSS 类**）+自带四语；接 admin 委托邀请「已发邀请」每页50 + partner 已发邀请(limit 50→500) 每页50。admin **v209**/partner **v154** |

## 2. 五端最终版本 + md5
| 端 | 版本 | md5 | 本轮涉及 |
|---|---|---|---|
| **管理端** | **v209** | `f12e994c60a4359a881575b5ce2f6abb` | 7-02/07/08 |
| **学生端** | **v389** | `ad2b188aed13e9532305b3bfab3a2e3c` | 7-01/03a/03b/04/05/06 |
| **中介端** | **v154** | `35f288679c455a9d8d9498b6c2177964` | 7-02/03a/03b/08 |
| **学校端** | **v231** | `b4473f8906ff0a07735640209300677a` | 7-02 |
| **审核端** | **v33** | `058b3eca992750eb4f701dcfbefb3038` | 7-02/07 |

（五端 index.html 重定向指针均已同步到上述版本。）

## 3. 7-05 病根 —— 真机才暴露（诚实交代）
- v387 我用「时间窗」兜底（因 `get_my_offers` 不吐 round_id）。但轮次起点误写成 `opened_at/created_at/started_at`——**`get_my_rounds` 一个都不返回**（真列是 `submitted_at`），导致起点恒 null → 匹配到列表第一个（当前在审轮）→ **和原 bug 同果**。
- **stuA 真数据一跑现形**：v387/v388 解析出 MH-9F4AG7（错）。
- **v389 修好**：起点改真列 `submitted_at`，加兜底「已确认 offer 优先取 accepted/enrolled>0 或已关闭轮，绝不用当前在审开轮」。真机复验 → **MH-6KG2JN · 第 1 轮**（对）。
- 教训：能真登的闸一定要真跑，stub 证不了「服务端真列名」这类事。

## 4. 7-03 上传线清单（探出的）
- **学生端**：`handleUploadCloud`(自填主线) · `_ru1UploadPending`(材料换版/驳回重传) · `_handleReferralUpload`(推荐草稿即传)。（另有 payment-evidence / concierge 线不在本轮范围，未动。）
- **中介端**：`_matCommit`(代传材料真提交) · `_wzStageFiles`/向导自定义 · 代传换版重传线（`_v134StageReplace` 系）。（onboarding 自证材料线 `10517` 不在队列三线内，保守未动。）
- 三线（两端）全部接入共享上传层，各带回落。

## 5. 7-06 item3 漏翻扫描结果
- ✎Edit / 通知面板标题：已四语化（中/英/俄/法），旧写死英文清零。
- Playwright 切 fr/ru 扫 `[data-i18n]` 可见元素：**登录前页面（gate+静态结构）零英文残留**。⚠️ 登录后深层页面需真账号全量渲染才能扫，属线上验收范畴。

## 6. 待办（交给你/下一轮）
1. **图标 zip 缺失**：`~/Downloads/maxhouse-pwa-icons.zip` 不在电脑上（全盘搜过）。现用占位图（橙#F39200底白M四角铺满，能装能测）。你找到 zip 后两句覆盖即正式：
   `cd /Volumes/Dev/MAXHOUSE && unzip -o ~/Downloads/maxhouse-pwa-icons.zip -d student-portal/icons/ && unzip -o ~/Downloads/maxhouse-pwa-icons.zip -d assets/icons/`
2. **get_my_offers 补 round_id**（7-05 加固）：`offer_decisions.round_id` 真有值且真指对轮次；让 RPC 吐它就能「直配」免时间窗。需 DROP+CREATE 函数（破坏性）——**你说本轮不做、下轮给执行器开一次例外**。时间窗（修正列名后）真数据已够用，此为加固。
3. **tus-js-client 自托管 vs cdnjs**：队列写 cdnjs，与 CLAUDE.md 自托管铁律冲突（GFW+Capacitor）→ 我按既有惯例自托管到 `assets/vendor/tus.min.js`。如你坚持 cdnjs 说一声（**建议维持自托管**）。
4. **7-03b 真断网续传闸**：需线上部署版跑「断网3s→看 Upload-Offset」；本地已验决策/回落/开关。部署后我补真验。
5. **7-06 item2 EF 侧根治**：AI 预检提示词里的材料代码（`criminal` 等）在服务端。本轮只做前端显示替换；EF 侧改+部署留另开包。
6. **验收后挂代理推主仓库 10 个提交**（原生终端，先 export 代理）。

## 7. 本地待推提交（10 个，主仓库未推）
```
cf499e6 student v389   JOB-7-05 修补(真机暴露病根: 时间窗错列→submitted_at)
344565d admin v209/partner v154   JOB-7-08 分页最小自建
d681cb9 admin v208/reviewer v33   JOB-7-07 驳回理由一律英文
187aa71 student v388   JOB-7-06 文案一致性四项
13bdd3d student v387   JOB-7-05 成功卡申请号取错(初版)
3e4007e student v386   JOB-7-04 390px 断词
24ef410 student v385/partner v153   JOB-7-03b TUS断点续传
bb453f1 student v384/partner v152   JOB-7-03a 上传反馈层
09543d2 admin v207/partner v151/school v231/reviewer v32+根index   JOB-7-02 图标换新
7516732 student v383   JOB-7-01 真PWA
```

## 8. 三层自验/十道闸小结
- 每包都跑了本地 Playwright（用你电脑 Chrome，`channel:'chrome'`）+ 静态 grep 闸，逐包附走查数（见各 JOB-7-0X.md）。JS 全部解析干净。
- 真库变更（登录/上传）本轮**经你授权**用 stuA 真跑，密码只走环境变量、未落任何文件；测试脚本放仓库外 `~/mh-verify`（邮箱不入库）。
- 只增不删；唯一的只读 DB 探针在 `jobs/JOB-7-0X/probe*.sql`。

---
**第七轮全部收官（9 包全交付）。五端线上基线 admin v209 / student v389 / partner v154 / school v231 / reviewer v33。主仓库未推（10 个本地提交待你挂代理推）。**
