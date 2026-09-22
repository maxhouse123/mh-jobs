# SUMMARY-18 · 第十八轮收官

> 本轮范围（业主 09-22 定 + Claude 核对）：只修不加——第十七轮验收没过的两条 + 复查查出的九处。
> 分 18-00 ～ 18-07 八包，全部完成并已推 mh-jobs 回执。
> 主仓库源码改动（18-00～18-04 共 5 笔）**本地 commit 已就绪、CC 未推、未部署**，等业主用卡1140 push。

---

## 一、三端新版本 + md5

| 端 | 基线（v17 收官） | 新版本 | 新 md5 | 旧版留盘 md5 |
|---|---|---|---|---|
| admin | v217 `a2e15910…` | **v218** | `73b36f0a4d6c09891419a873ff4af013` | v217 `a2e159102e85f4f4cbd1addcca99c3b6` |
| reviewer | v42 `68d136ee…` | **v43** | `183215bc92cddf0a6b23add256bd43c3` | v42 `68d136ee51553c313911f27d70cd8203` |
| partner | v165 `87ded571…` | **v166** | `faabaa5f21eb62f3221123fe4b1e9290` | v165 `87ded57102b90f2f3be8a99a05044051` |

- student v397、school v234 本轮**一行未动**（md5 = §0.3 基线，未列表）。
- 共用查看器 `assets/mh-viewer-v2-1-1.js` `ee351485…`、`jobs/JOB-17-01/kit2/` **一字未改**。
- 三端版本四件套齐（文件名 / 头注 `[VER]` / index.html 三处重定向 / docs/changelog）；index 重定向实测均已指向 v218 / v43 / v166。

## 二、云函数 precheck-ai v24

- `supabase/functions/precheck-ai/index.ts`：v23 `654fcbb5e565ea9a6dda0c68179d476b` → **v24 `50a3df3ceb3769bfe663305ee9830123`**。
- 只改这一个云函数源文件；**改源码不部署**。
- 部署脚本 `jobs/JOB-18-04/deploy-precheck.sh`（公钥读环境变量 `SUPABASE_ANON_KEY`），**待业主部署**。
- 材料名表 `jobs/JOB-18-04/doc-names.json` 由 `gen-doc-names.mjs` 从三处原样读出（en=v397 主文件 `doc.*`；ru/fr=语言包 `maxhouse_student_i18n_v360_{ru,fr}.js` 的 `doc.*`；主文件补充词典覆盖优先），22 码齐全、未手抄未改字。
- zh 路（定时路 + `lang=zh`）与 v23 逐字相同；四语提示词核对 + N4 25 项全过。

## 三、迁移清单

- **本轮无新迁移、无写库、无待业主手贴 SQL。**
- 18-05 只读复核：`reviewer_access_log` / `school_access_log`（如存）/ 相关 outcome 三张审计表的 outcome 列**纯 text、无 CHECK 约束**（探针 `jobs/JOB-18-00/probes/probe4-audit-constraints.sql`，今日 db-run 复跑 0 行约束）→ 任意 text 值都能插、无值会被拒 → 「函数会写、约束不收」的差集为空 → **三张表都无需改**。
- 下一个空号仍是 **0213**，留给后续包。
- （§0.3 记的 0210/0212 已由 CC 应用、0210b/0211 业主手贴✅，均为本轮前既成，无新增。）

## 四、每包一句话

- **18-00**：开工检查（基线 md5/HEAD 全对）+ 探针 + 旧病复现（必须先红）+ 旧版按钮清单；查明审核端慢件根因在服务端渲染/EF 冷启动（喂十九轮），三张审计表无需改（喂 18-05）；除测试件外零写库。
- **18-01**：admin **v218** — 取件两趟同时发（`_v218AdmFetchOriginal`+`ADM_DOC_META`，RPC `admin_log_doc_view` 与 storage.download 并发 `Promise.all`，记不上不给看/`not_an_admin` 不回落）+ 下载用库里真文件名 + PDF/图片统一上方 tools 行。闸3 10绿、N1 全绿（死按钮零新增）、P3 回归 22 绿。
- **18-02**：reviewer **v43** — 查看让路（`_wmFetch(docId,signal)`+预取泵 AbortController，点查看中止除本件外在途预取+放回队首，直读桶泵暂停降0）+ 每份直读 `[v43] wm timing` + 超高卡露出高度≥1/3屏高 + 未知类型名 `_v43SafeType`（9 处统一）。六闸全绿、29 条静态回归。
- **18-03**：partner **v166** — 「两个名字」进琥珀名单块 + 代传出异常不转圈。三闸红→绿 + N7 全量、static-check 29 绿、N1 只增不减。
- **18-04**：precheck-ai **v24** — 英/俄/法提醒说人话（材料名按请求语言原样读出、issues 每条追加对应语言一句自然说法；zh 路逐字不变）。改源码不部署，md5 `50a3df3…`，deploy 脚本待业主部署。
- **18-05**：三张审计表补值——复核后定论**无需改**，不写迁移、无待业主手贴 SQL。
- **18-06**：线上走查脚本（回执自动推送 + 元素级 PII 脱敏截图 + 真页面缩略图删除按钮删测试件 + 带身份 REST 复核 alive=0 + 五端 `[VER]` 轮询 + 中介端琥珀名单块两名字项）；对现役线上跑一遍——单探绿 15 / 红 2（红=partner v166 未上线，属预期）/ 灰 5（门禁挡记 N/A）。
- **18-07**：本收官（SUMMARY-18 + PUSH_OK）。

## 五、「旧版红 → 新版绿」截图（公开脱敏版在 `~/mh-jobs/shots/18/`；本机完整版 `~/mh-verify/shots/JOB-18/`）

- **18-01**：`18-01/v217-pdf-extras-in-component-RED.png` → `18-01/v218-pdf-buttons-on-top-row-GREEN.png`、`18-01/v218-image-download-realname-GREEN.png`
- **18-02**：`18-02/v42-unknown-type-title-RED.png` → `18-02/v43-unknown-type-title-GREEN.png`
- **18-03**：`18-03/v165-roster-no-verdict-RED.png` → `18-03/v166-roster-two-names-GREEN.png`；`18-03/v165-r2-toast-RED.png` → `18-03/v166-r2-softtoast-1s-GREEN.png` + `18-03/v166-r2-softtoast-4s-GREEN.png`（N7：第1秒/第4秒各一张，软提醒琥珀）
- **18-06 线上走查**：`walk/par-invite-list-masked.png`（中介端邀请列表，姓名/邮箱样式打码）、`walk/stu-upload-card.png`（学生端上传卡展开后）
- 各目录配 `INDEX.md`；真实学生文字 mask、PDF/图片网络层换合成件、推前过 secret-scan（`SECRET-SCAN-CLEAN`）。

## 六、未放行清单

- **无未放行项。** 六个施工包三层自验/新闸全过、均绿。
- 待业主的两步**不算未放行、属正常发布动作**：①用卡1140 push 主仓库 5 笔（18-00～18-04）；②用 `jobs/JOB-18-04/deploy-precheck.sh` 部署 precheck-ai v24。

## 七、要业主亲眼看的（哪一端 · 点哪里 · 应看到什么）

> 以下多数需**线上**验收（新版本 push 后 1–2 分钟 CF Pages 自动上线；本地 file:// 部分资产 CORS 加载不了）。

1. **管理端 v218 · 取件用时 + 两处下载文件名**：打开任一学生 3 份几百 KB 原件，看**取件比 v217 明显变快**（RPC 与下载并发，不再串行两趟）；分别点 PDF 的 `<a download>` 与图片行下载，**下载下来的文件名 = 库里真文件名**（兜底 `原件-<id8>.<ext>`）。
2. **中介端 v166 · 姓名不一致**：某推荐学生「注册名 ≠ 护照名」时，护照栏**琥珀名单块里同时列出两个名字**；触发相关提示时看**弹出提示为琥珀色（非红）、停留到第 4 秒仍在、不被后续提示顶掉**。
3. **审核端 v43 · 往下翻后点「查看」的速度**：队列往下滚动（触发预取）后点某份「查看」，**几乎立即出**（在途预取让路 + 泵暂停）；控制台每份直读打 `[v43] wm timing`。
4. **审核端 v43 · 未知类型材料的标题**：遇到 `studyProof`/`studyPlan` 等未登记类型的材料，卡片标题显示**安全可读的类型名**（不再是空/裸 key）。
5. **英文界面的 AI 提醒措辞**：学生端切英文后**新传一份材料**，看 precheck 的 issues 是**自然英文句子**（按材料名称呼、普通双引号、不出现内部代码）。**注意此项需先部署 precheck-ai v24 才会生效**（ru/fr 同理，切对应语言看）。

## 八、第十九轮建议包

1. **审核端慢件根因（18-00/18-02 查实）**：reviewer1 真登逐个直读队列 30 份，**15 份 ≥5 s**（中位 5.25 s，range 1.2–9.4 s），经 watermark-doc EF；**与文件大小、是否命中缓存无关**（几乎全 `wm_status=cached`、body 很小仍慢），415 不支持行反而快返 → **成本在服务端渲染 / EF 冷启动，不是带宽**。建议查 watermark-doc 冷/热渲染路径与 EF 冷启动（预热 / 常驻 / 提前签发直链）。
2. **清一次历史 online-walk storage 孤儿**：本轮收尾复核发现 `recommendation` 槽 1 个 storage 孤儿 `…_r16-online-synth.png`（无 documents 行，第十六轮 online-walk 历史遗漏）；删 storage 属敏感、非本包必需，留十九轮统一清一次历史 online-walk 残件。
3. **未登记材料类型入册**：`studyProof`/`studyPlan` 未进 DOC_TYPES（v43 已用 `_v43SafeType` 兜显示名，但类型表本身未补）——若要正式登记，走新增块。
4. **审计表 outcome 白名单 CHECK（如决定要）**：把三张审计表 outcome 的 text 值收进白名单 CHECK 属**新增功能**、需业主拍板范围，本轮「只修不加」未做。
5. **配额云化 / admin LS 桥收敛** 等既有 backlog 顺延（非本轮范围）。

## 九、边界复述

- 未新建/改任何 migration；未改共用查看器；未碰 .env；未造新测试账号；未改真实（非 is_test）用户数据；除 18-04 写明的几句外未动 AI prompt；未部署云函数；**CC 未推主仓库**。
- 测试写库克制：红测先证实拦截生效再点上传；每包收尾用带身份探针复核测试件 `alive=0`（18-06 末次真按钮删 + 带身份 REST 复核 documents 活件 0 / `other` 合成孤儿 0）。
- 全程无 `~/mh-verify/r18-STOP.txt`（无「必须停」触发）。

---

PUSH_OK=yes
