# SUMMARY-17 · 第十七轮收官（CC 无人值守，卡1134 收官包 17-08）

只修不加：把 PDF 与图片装进同一条工具条（MHViewer2 v2.1.1，Claude 交付）+ 打开提速 + 第十六轮验收查出的 C–G。
本轮七个工作包（17-01～17-07）逐包真页面「先红后绿」、N1–N6 逐条给证，收官不改任何代码，只写本文件。
主仓库本地已 commit 7 笔（17-00～17-06）未推——**推送归业主卡1135**；本轮不动主仓库、不部署云函数。

---

## 一、五端版本 + md5（本地 HEAD 5c83655 实测）

| 端 | 版本 | 文件 | md5 |
|---|---|---|---|
| 管理 admin | v217 | maxhouse-admin-portal-v217.html | `a2e159102e85f4f4cbd1addcca99c3b6` |
| 学生 student | v397 | maxhouse_student_portal_v397.html | `6e78713b22dd5a9018d7c1ef53708665` |
| 学校 school | v234 | maxhouse-school-portal-v234.html | `a2d2e593bc4694029d5a0ee07bc8332b` |
| 审核 reviewer | v42 | maxhouse-reviewer-portal-v42.html | `68d136ee51553c313911f27d70cd8203` |
| 中介 partner | v165 | maxhouse-partner-portal-v165.html | `87ded57102b90f2f3be8a99a05044051` |

- 起点基线（QUEUE-17 §0.2）：admin v215 / student v396 / partner v163 / school v233 / reviewer v40；HEAD=`e6a9562`（= 本地 origin/main，base-head.txt 相符）。
- 五端 index.html 重定向已同步指向新版（extensionless，CF Pages 口径）：admin→v217 / student→v397 / school→v234 / reviewer→v42 / partner→v165（三处：meta refresh + canonical + location.replace）。

## 二、迁移 0210–0212（正本 `supabase/migrations/`，同 commit 归档 `docs/supabase 文件/`）

| 迁移 | 内容 | 状态 |
|---|---|---|
| 0210_admin_direct_read.sql | 管理员直读 storage 读策略 + `admin_log_doc_view`（记不上审计就不给看，回落 admin-doc） | **CC 已 db-run 应用**（V_policy/V_fn/V_grant 全过） |
| 0210b_admin_outcome_served_direct.sql | outcome CHECK 加 `served_direct`（drop constraint 红线，db-run 拦） | **待卡1136 业主 SQL Editor 手贴**（未跑前直读成功路按设计回落 admin-doc，不破功能） |
| 0211_reviewer_outcome_denied.sql | reviewer_access_log.outcome 补 `denied_revoked` / `denied_doc_deleted`（真差集 10 值） | **待卡1136 手贴**；⚠ 内含一处「图纸(+3)与现实(真差集)冲突」，CC 落成真差集版并在头注醒目标出，**业主手贴前先裁决**（CC 建议走真差集版） |
| 0212_slim_delegate.sql | `set_doc_slim` 归属 OR 链尾追加有效委托人 | **CC 已 db-run 落库**（SLIM-FN delegate=true；RED→GREEN + N4 四态回归全绿，全 rollback 零残留） |

## 三、云函数 precheck-ai v23（改源码不部署）

- 源码 `supabase/functions/precheck-ai/index.ts`，md5 `654fcbb5e565ea9a6dda0c68179d476b`（v22 基线 `1c4ce932208c0b63181d223c5ed4cf49`）。
- 只动两处：① 英文/俄/法界面下 AI 提醒改用**界面语言**（不再固定中文）；② 按需预检限频改**按触发人**计（本人 + 中介给别人的学生各自算）。
- **待卡1136 部署**：业主挂代理 `supabase login` → `export SUPABASE_ANON_KEY=<student-portal 里 sb_publishable_ 那串>` → 跑 `bash jobs/JOB-17-05/deploy-precheck.sh`（`--no-verify-jwt`，自带探针，期望末行 `✅ precheck-ai v23 部署 + 探针全过。`）。
- watermark-doc（v33 `55debf4d…`）/ admin-doc（`ac5f227a…`）/ send-invite-email 本轮**一行未改**。

## 四、每包一句话

- **17-00**：记录基线 HEAD(e6a9562) + 落 QUEUE-17；kit2 解包 `KIT2-UNPACK-OK 24 files`（viewer md5 `ee351485…` 相符）；两内核 PDF/图片自测四遍全过；A–F 旧病真页面**先红**复现（D 因本地无 ICAO-MRZ 生成器按 N2 标 UNRECONFIRMED，留 17-04 gate3）。
- **17-01（A）**：MHViewer2 v2.1.1 装进审核 v41 / 学校 v234 / 管理 v216——PDF 与图片同一条工具条（−%+ / 整页·适宽·1:1 / 旋转 / 翻页），管理端多出新标签打开+下载；真页面先红后绿。
- **17-02（B）**：打开提速——迁移 0210 管理员直读 + admin v216→v217 直读 + reviewer v41→v42 预取跟着看的地方走（第 3 组滚到即预取，点开 0 新请求、94ms 秒开）；真页面先红后绿。
- **17-03（C）**：中介端 v163→v164——Copy link 点了有看得见的反应（提示条「链接已复制」+ 按钮变「已复制」；剪贴板被拒走 execCommand 备用，再失败弹只显链接的小窗）；真页面先红后绿。
- **17-04（D+F①F②）**：学生端 v396→v397 / 中介端 v164→v165——护照姓名核对全程琥珀软提醒（外框/底色/徽章/名单块计算后色皆琥珀、提醒含两个名字、四语命中）+ 原因框慢网秒数暂停/取消改文案 + 瘦身行按本件不串槽；真页面先红后绿，N1 removed=0。
- **17-05（E+G③）**：precheck-ai v22→v23（改源码不部署）——英文界面 AI 提醒改用界面语言 + 按需限频改按触发人计；21 格鉴权矩阵 AS-EXPECTED，绿灯待卡1136 上线后出。
- **17-06（G①②）**：迁移 0211（reviewer_access_log.outcome 补两值，待卡1136 手贴）+ 0212（set_doc_slim 加有效委托人，已落库 RED→GREEN）。
- **17-07（G④⑤）**：线上走查脚本修好（真类名找元素、真传合成件、先轮询五端 [VER] 再走、公钥读环境变量）+ 第十六轮收官单勘误（SUMMARY-16 §七#1：学校 v233/管理 v214 放大缩小已由 16-01b 转放行）；本机对**现役线上**单探一遍：绿 8 / 红 7（全是新版未上线的预期红）/ 灰 4；真红→绿留业主卡1136 跑。
- **17-08（收官）**：本文件（SUMMARY-17，含 PUSH_OK）。

## 五、A–G 逐项「旧版红 → 新版绿」截图文件名

公开元素级截图在 `~/mh-jobs/shots/17/<包号>/`（全合成件、真实文字已 mask）；本机全量图在 `~/mh-verify/shots/JOB-17/`。

- **A（PDF 工具条统一，17-01）**：
  - 旧红：`17-00/A-reviewer-v40-pdf-RED.png`（旧版无 MHViewer2 2.1.1 工具条、裸 pdf.js canvas，version=2.0.0）
  - 新绿：`17-01/{reviewer,school,admin}-pdf-fitwidth.png`、`…-pdf-zoomed.png`、`…-new-pdf-11-rot.png`、`…-new-pdf-05-fitpage.png`、`reviewer-pdf-narrow-{en,ru}.png`（390px 窄盒不跳页）；坏件 `{reviewer,admin}-new-pdf-corrupt-error.png`；图片零回归 `{reviewer,school,admin}-img-0[1-7]-*.png`。
- **B（打开提速，17-02）**：
  - 旧红：`17-00/B-reviewer-v40-click-RED.png`（未预取组点开 3s 内发起 2 个新下载）；对照绿 `17-00/B-reviewer-v40-click-GREEN.png`
  - 新绿：`17-02/reviewer-v42-3rd-group-open-GREEN.png`（第 3 组预取后 0 新请求、94ms）、`17-02/admin-v217-pdf-direct-GREEN.png`（走 admin_log_doc_view 直读、信息行标「直读」）
- **C（Copy link 有反应，17-03）**：
  - 旧红（本机，链接含 token 不公开）：`partner-v163-grant-RED-chromium.png` / `partner-v163-deny-RED-chromium.png`
  - 新绿（本机）：`partner-v164-grant-GREEN-chromium.png` / `partner-v164-deny-GREEN-chromium.png` / `partner-v164-manual-modal-GREEN-chromium.png`
- **D（护照姓名软提醒，17-04）**：
  - 旧红：`17-00/D-student-v396-mismatch-tone.png` / `17-00/D-partner-v163-mismatch-tone.png`（中介端旧走 .toast.error 红口吻）
  - 新绿：`17-04/01-student-v397-D-amber.png` / `17-04/02-partner-v165-D-amber.png`（琥珀外框+底色+徽章「姓名待核对」+名单块 ⚠）
- **E（英文界面 AI 提醒非中文，17-05）**：红已在 17-00 真页面出；**绿依赖 v23 上线**，在卡1136 部署探针（`lang=en` issues 无中日韩字符）与 17-07 线上走查里出——本轮不据此放行绿。
- **F①（原因框慢网秒数暂停/取消文案，17-04）/ F②（同名件不串瘦身行）**：行为判定非视觉件，判据见 `jobs/JOB-17-04/` gate JSON（旧三法 undefined 红 → 新版秒数不动/取消新文案/旧槽不冒瘦身行 绿）。
- **G①（0211 审计约束）**：SQL 层确定性 RED（约束拒 denied_revoked/denied_doc_deleted），**GREEN 待卡1136 手贴后线上出**。**G②（0212 委托人）**：已落库 RED→GREEN（`jobs/JOB-17-06/redgreen-0212.sql`）。**G③**：并入 17-05。**G④**：`jobs/JOB-17-07/online-walk.*`。**G⑤**：`~/mh-jobs/SUMMARY-16-ERRATA.md`。

## 六、kit2 两内核结果（原样抄自 17-00）

- Chromium PDF：`CLAUDE-PDF-JUDGE ALL-AS-EXPECTED (chromium, MHViewer2 2.1.1, shard 0/1, ran 34)`
- WebKit PDF：`CLAUDE-PDF-JUDGE ALL-AS-EXPECTED (webkit, MHViewer2 2.1.1, shard 0/1, ran 34)`（MISMATCH=0；skip 主要 J17，另 J09/J08 各一，均 skip 非 mismatch，判官 want==got）
- Chromium 图片：`SELFTEST MHV2-ALL-AS-EXPECTED (chromium)`
- WebKit 图片：`SELFTEST MHV2-ALL-AS-EXPECTED (webkit)`
- §0.9③④ 全过（无 MISMATCH）。

## 七、未放行清单（均为「按设计待业主动作」，非失败，且不破现役功能）

1. **0210b 迁移**——outcome CHECK 加 served_direct，drop constraint 触 db-run 红线，**待卡1136 SQL Editor 手贴**；未跑前管理端 v217 直读成功路自动回落 admin-doc 云函数，功能不破。
2. **0211 迁移**——reviewer_access_log.outcome 补两值，同属手贴类，**待卡1136 手贴**；⚠**业主先裁决**图纸(+3)与真差集(+denied_revoked/+denied_doc_deleted)冲突（CC 建议走真差集版，文件头注已标）。
3. **precheck-ai v23**——改源码未部署，**待卡1136 部署**（deploy-precheck.sh）；E 的绿灯随部署出。
4. **管理端直读成功路真验**——served_direct 真插+真下载需管理员凭据，CC 无凭据，**待业主手验**（见八·管理端）。
5. **D 护照 OCR 真机读码**——本地无 ICAO-MRZ 生成器，authoritative 先红后绿以生产态量真页面真函数输出替代（N2），真图触发留业主线上看。
6. **17-07 线上真红→绿**——现役线上仍旧版（预期红），真绿要业主卡1136 推送+部署后再跑 online-walk（不带 NO_WAIT）产出元素级红→绿截图。

## 八、要业主亲眼看的清单（Claude 据此出验收表）

**本轮 A–G：**
- **A · 管理/学校/审核三端**：各打开同一类 PDF → 工具条长得一样（−%+ / 整页·适宽·1:1 / 旋转 / 翻页），滚轮翻页、Ctrl+滚轮/双指缩放、放大后小字清楚；**管理端还多出「新标签打开 / 下载」**。
- **B · 管理端**：关代理打开 3 份不同原件，「取件用时」标「**直读**」且每份 ≤ 2s（须先跑完 0210b）；桩失败/无管理员时标「云函数」。**审核端**：滚到第 3+ 个学生组停一会再点「查看」，应几乎秒开、无新下载。
- **C · 中介端**：登录 → Sent invites → 点任一「Copy link」→ 中上方弹「链接已复制」、按钮短暂变「已复制」，粘贴出来是该邀请链接；把浏览器剪贴板权限设「阻止」再点仍有可见反应；点完清单和每条重发/复制/撤销按钮都还在；切 EN/РУ/FR 提示条跟着变语言。
- **D · 学生端 / 中介端**：传一张「机读码姓名和申请表不一致」的护照件 → 缩略图琥珀外框+琥珀底色、徽章「姓名待核对」、名单块琥珀 ⚠（不再红叉），提醒里能看到**两个名字**；切 EN/РУ/FR 文案跟着变。
- **F① · 学生端 / 中介端**：第 3 批触发原因框，开着等十几秒 → 卡上**不再有往上跳的秒数**；点取消 → 卡上写「需要写原因，未上传」（不是「上传失败」）。**F②**：同一文件名先后传到两个不同槽 → 旧槽**不再冒别人的瘦身行**，刷新后也不冒。
- **E · 学生端（须 v23 上线后在线上看）**：界面切 English，对一份会报问题的护照/成绩单图触发预检 → AI 提醒是**英文**（不再中文）；切 РУ/FR 同理。
- **G① · （须先手贴 0211）**：撤销某派单 → reviewer1 调 watermark-doc 得 403，审计 denied_revoked 从 0→1 行。**G②**：某中介对其名下委托学生的新传件在 15 分钟内触发瘦身写回，看是否成功（0212 已落库）。

**第十六轮业主还没验完的（随本轮一并看）：**
- 审核端 Word 卡图标；
- 管理端打开一张真图片，看控制台有无红字；
- 学校端图片预览；
- 学生端刷新后护照新件与瘦身行仍在；
- 坏 PDF 预览是不是「人话」错误提示；
- 中介端代传「勾选 → Submit → 刷新」链路。

## 九、第十八轮建议包（含顺延项 + 本轮新发现）

1. **0210b / 0211 手贴闭环回收**：卡1136 手贴后，把两条约束的真上线状态、denied_revoked 首行审计截图归档，正式销「待手贴」账。
2. **管理端直读推广**：PDF 直读口径可推广到学校端录取通知书样张等取原件路径（17-02 N6 观察项），评估是否统一走 admin_log_doc_view 直读+审计。
3. **护照 MRZ 真机读校对**：引入 ICAO-MRZ 生成器或用真样张，把 D 的 authoritative 先红后绿从「生产态量真函数」升级为无头可复现的真 OCR 触发。
4. **线上走查转常态**：online-walk 在卡1136 出真红→绿后，评估纳入每轮收官的固定线上探针（现只 CC 单探现役）。
5. **vendor/tesseract LFS 与入仓补账**（LEDGER-3 观察项顺延）、**withdraw_referral 线上 400 复现定性**、**R2 缩略图角标名字匹配残债**。
6. **kit2 组件版本收敛**：MHViewer2 v2.1.1 已三端在用，评估把 `jobs/JOB-17-01/kit/`（CC 的 v2.1.0 参考件）按约定清理时机。

---

各包闸3 与新闸 N1–N6 全过或未过项已标「未放行」且不破其它功能；N1 差集为空或逐条有交代（17-04 added 仅私有 `_slowTick`）；secret-scan 对 `~/mh-jobs` 全树 `SECRET-SCAN-CLEAN`；主仓库 tracked 工作树干净、7 笔待推（17-00～17-06）。据此：

PUSH_OK=yes
