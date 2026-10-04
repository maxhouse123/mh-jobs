PUSH_OK=yes

# SUMMARY-39 · 第三十九轮收官 · 补充信息表预填第二步「AI 读材料」

> PUSH_OK=yes 含义：本轮四包闸全过、无必须停，业主可以推主仓库（卡1272）。CC 从不自己推主仓库，这件事与本行无关。

主题（业主 2026-10-03「按图做」）：第一步（第三十八轮）平台档案只够填 3–5 格；教育经历、语言证书、工作单位都在学生自己传的材料里。本轮加按钮「让 AI 从材料里读」——点了之后云函数读本人护照/学历/成绩单/简历/语言证书，按表单字段子集返 JSON，组件只填**空着的**格子、淡黄标「AI 填的，请核对」；结果缓存库里、每小时最多读一次、24h 最多 5 次。校验/必填/导出/机器人契约一个字没改。

## 一、四包一句话
- **39-00**：开工七件 md5 全对；读 precheck-ai 照抄清单（模型/钥匙/取文件/图片处理/大小限）；documents.doc_type 实测 + 白名单 5 类；旧态先红 R1（组件 v1.5 传 onAiPrefill 无按钮）+ R2（学生 v408 无按钮）RED 6/6 0 pageerror。
- **39-01**：迁移 0224（student_filing_profiles 加 ai_prefill/ai_prefill_at + 新表 ai_prefill_log）只写不执行；云函数 filing-prefill 只写不部署、不调真模型（零费用）；桩测 GREEN 31/31 + TS 解析过。
- **39-02**：新建组件 v1-6.js（v1~v1.5 原样留）——onAiPrefill 按钮 + applyPrefill(values,'ai') + 三状态文案 + AI 小字；__selftest 97/0；R1 转绿 9/9；契约 GREEN 4/4。
- **39-03**：学生 v409 / 中介 v180 / 管理端 v248 接云函数；闸8 R2 转绿 11/11 0 pageerror；契约 GREEN 4/4；N1 零删；盲态/secret 净。

## 二、版本 / md5 账（本轮新产线文件）
| 文件 | 版本 | md5 |
|---|---|---|
| assets/mh-filing-form-v1-6.js | v1.6（新建） | c18678a3d6973bcdab2138c3102b3093 |
| student-portal/maxhouse_student_portal_v409.html | v409 | c53f8fbcc8e74e12d574a74dcdde0bb7 |
| partner-portal/maxhouse-partner-portal-v180.html | v180 | db341babeeb6de4940102c308a015037 |
| admin-portal/maxhouse-admin-portal-v248.html | v248 | 05b94f4dfcde619bbdbdb39ed876f474 |
| supabase/functions/filing-prefill/index.ts | v1（新建·待部署） | c840c9c5f020966503ec8ecdb1063b16 |
| supabase/migrations/0224_filing_ai_prefill.sql | 0224（待手贴·镜像 docs） | 5af630dae287ab2b5351996a1022b713 |

旧版 v408/v179/v247、组件 v1~v1.5、school v245、reviewer v46、tests/filing-contract.mjs 一字未动（md5 不变）。学校端/审核端/机器人/启动器/共用查看器/_headers/其它云函数 全程未碰。

主仓库 `git log origin/main..HEAD` = 4 条 JOB-39-00~03（全本轮），工作树 clean。

## 三、闸账
- 旧态先红：R1（组件）+ R2（学生）RED 6/6，0 pageerror。
- 转绿：R1 组件 9/9；R2 学生+中介 闸8 11/11，中英各一遍，0 pageerror。
- N1 零移除：四端 + 组件 function/id/handler 无一消失（学生 373 id / 中介 206 / 管理端 227 不变；组件公开接口只增 applyPrefill）。
- P3 静态断言：组件 __selftest 97 绿 0 fail（含 T36-44 新增）；云函数桩测 31 绿。
- 契约测试：默认取 v1-6 + admin v248，GREEN 4/4，REQUIRED 55。
- deno check：本机无独立 deno/Docker，用 stripTypeScriptTypes 解析过作替身（见未证之事）。
- secret-scan：净（仅命中历史 v140 头注 service_role 一词 + 各端 base64 LOGO，非密钥，旧版同在）。
- 盲态不破：学生/中介端新文案、新数据不涉校名/学校网址/中介账号。
- 四件套：三端齐（名/头注/[VER]&MH_PORTAL_VER/index）；学生 MH_PORTAL_VER 补正 407→409（v408 遗留）。

## 四、业主要做的三件事（收官后）
1. **推主仓库**（卡1272）：4 条 JOB-39 提交 push origin main（四段式：推前列账→push→推后空→status clean）。
2. **部署云函数 filing-prefill**（卡1273）：
   `~/mh-verify/node_modules/.bin/supabase functions deploy filing-prefill --project-ref uexgzwfambanvhdhxome`
   （本轮只写源码、CC 不部署；需钥匙 secret 已在 precheck-ai 那套：SB_SECRET_KEY / AI_TRANSLATE_KEY / AI_TRANSLATE_BASE / AI_PRECHECK_MODEL。）
3. **贴 SQL 0224**（卡1274）：Supabase SQL Editor 手贴 `supabase/migrations/0224_filing_ai_prefill.sql` 全文（幂等、只增型、无 drop）；贴完按文件尾 V1/V2/V3 三条核行数（2 列 / 1 表 / 1 策略）。

## 五、给业主的验收（推完 + 贴完 + 部署完后 Claude 代查，业主只需拖复查包、贴一次 SQL、跑一次部署卡）
1. 学生端打开补充信息表 → 表头进度旁有按钮「让 AI 从材料里读」。
2. 点一下 → 几十秒内教育经历、出生地、英语证书等被填，且淡黄标「AI 填的，请核对」；状态行「已读 N 份材料，填入 M 项」。
3. 一小时内再点 → 提示「一小时内已读过，用的是上次结果」。
4. 没传过材料的学生点 → 提示「没有可读的材料，先在材料页上传学历证书或成绩单」。
5. 中介代填被荐生表单，同样有这个按钮，只读得到该生的材料（云端核验推荐关系）。
6. 0224 没贴前点按钮 → 提示「功能正在上线，请稍后再试」（按钮不消失，不报错）。

## 六、未证之事清单（§0.5）
- **真 deno check / 真 functions serve**：本机无独立 deno、无 Docker，跑不起 serve；用 Node 的 stripTypeScriptTypes 解析通过作本机替身（TS 语法成立）。真 deno check 与真 serve 等卡1273 部署时由 Claude 代查。
- **真模型调用**：桩测用假模型响应，零费用；真模型取数/解析/缓存/护栏等，部署后 Claude 代查端到端（读真材料是否按字段子集返 JSON、是否绝不编造、60 分缓存与 24h 5 次是否生效）。
- **真登 / 真库**：本机无 .env/accounts.json，R2 的 invoke 走 stub 假响应验流程，未连真库真登。
- 构建脚本 jobs/JOB-39-03/patch_hosts.py 本机留存未入 git（.gitignore `patch_*.py`，同 JOB-38-02 惯例）；产物 HTML + index 已入 git，回执全文记录其动作。

## 七、第四十轮建议包（QUEUE-39 §39-04 必含项）
- **27-B**：管理员重置学生密码云函数（历史欠项）。
- **历史欠验项 CC 线上自验**：需 accounts.json —— 本轮 filing-prefill 真模型端到端、第一步平台预填线上验收、组件 v1.6 线上真解锁路径等。
- **at0086**：建档系统 at0086 线路（历史 backlog）。
- 附带：filing-prefill 部署后若模型不稳可加重试/超时；ai_prefill_log 管理端查看面板（费用可视）。
