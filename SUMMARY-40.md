PUSH_OK=yes

# SUMMARY-40 · 第四十轮收官

> 含义：本轮四包闸全过、无必须停、业主可以用卡1280 推主仓库。（CC 从不自己推主仓库，与这行无关。）

## 一句话总览
AI 读材料现在也能读 PDF（浏览器把 PDF 前两页拍成照片送云端）；管理员能在后台给学生重置登录密码（生成一次性临时密码）；CC 用学生测试账号真登线上把历史欠验项逐条查了一遍。四端里学校端 / 审核端没动，组件 v1.6 一字没改。

## 四包一句话
- **40-00**：开工核对（七件基线 md5 全对、HEAD=origin、HOTFIX-39 在、pdf.js 已自托管可复用）+ 先红 R1–R3 全红。
- **40-01**：AI 读材料支持 PDF —— 云函数 `filing-prefill` v2（认 `body.images`、与 storage 图合并、钥匙保持 HOTFIX-39）+ 学生 v410 + 中介 v181（用现成 pdf.js 把白名单 PDF 前 2 页画成 JPEG 送）。
- **40-02**：27-B 管理员重置学生密码 —— 新云函数 `admin-reset-student-password`（核 is_admin / 服务钥匙改密 / 临时密码只响应一次 / 记审计不含密码）+ 管理端 v249（学生抽屉「重置密码」按钮→确认→弹临时密码可复制）。
- **40-03**：CC 线上自验七条（真登学生端只读）。

## 版本 / md5 账
| 文件 | 版本 | md5 |
|---|---|---|
| `student-portal/maxhouse_student_portal_v410.html` | v410（新） | `3b1fb65269eee5cd9c89cbbdf8e4097b` |
| `partner-portal/maxhouse-partner-portal-v181.html` | v181（新） | `11bed878ca5d36d90f0addebd993ee9c` |
| `admin-portal/maxhouse-admin-portal-v249.html` | v249（新） | `b7b9f1ca04190a200b1aa458577d5f56` |
| `supabase/functions/filing-prefill/index.ts` | v2（改，待部署） | 钥匙取法保持 HOTFIX-39 不变 |
| `supabase/functions/admin-reset-student-password/index.ts` | v1（新，待部署） | 服务钥匙同 HOTFIX-39 取法，零写死 |
| `assets/mh-filing-form-v1-6.js` | v1.6（**不动**） | `c18678a3d6973bcdab2138c3102b3093`（未变） |
| 学校 v245 / 审核 v46 | 不动 | 未变 |
- 四件套齐：学生/中介/管理端各自文件名 + 头注([VER]) + MH_PORTAL_VER(410/181/249) + index.html 重定向，四处同版。
- HOTFIX-39 未回退（云函数首行钥匙 `SUPABASE_SERVICE_ROLE_KEY` 优先）。

## 闸账（全过）
- **云函数桩测**：filing-prefill v2 `ALL-GREEN 40/40` + `TS-PARSE-OK`；admin-reset `ALL-GREEN 14/14` + `TS-PARSE-OK`（`stripTypeScriptTypes` = 本机 deno check 替身，本机无 deno/docker）。
- **闸8 无头真渲染**（Playwright 真 Chromium，file://，中英各一遍，0 pageerror）：40-01 `GREEN 10/10`（body.images 2 张真 JPEG ≤900KB、passport jpg 不转、无 PDF 回归、读不了跳过 toast）；40-02 `GREEN 8/8`（按钮+确认+弹临时密码+失败人话+取消不调）。
- **N1 零移除**：学生 fn 849→853、中介 623→628、管理端 829→833，id/handler 全在，无一消失；HOTFIX-39 未回退。
- **secret-scan**：净（唯一命中为历史头注里的变量名，非钥匙值；三处新云函数/前端源码零写死钥匙）。
- **盲态不破**：新增文案只有「有 N 份 PDF 读不了」四语；不涉校名 / 学校网址 / 中介账号名。
- **先红→转绿**：R1/R2（PDF）、R3（重置密码按钮）皆由红转绿。

## 需业主做的事
1. **部署云函数（卡1281）**：`filing-prefill`（v2，客户端 PDF 图合并）+ `admin-reset-student-password`（v1，新）。两者 CC 只写未部署。
2. **推主仓库（卡1280）**：本地领先 origin/main 4 笔，全是 JOB-40-00/01/02/03；推完线上才会到 v410/v181/v249。
3. **需手贴 SQL**：**无**。27-B 本需迁移 0226，但实测 `admin_events.event_type` 无 CHECK 约束（迁移 0039）→ 零迁移。

## 线上自验结论表（40-03）
| # | 项目 | 结论 |
|---|---|---|
| 1 | 补充信息表 淡黄预填+表头+改白+重开持久 | 过（本地 file:// 合成 4/4）；线上该账号资料已填满→线上判不了 |
| 2 | 「让 AI 从材料里读」按钮在（不点） | 过（线上真登确认） |
| 3a | 久开缩略图 55min 重签 | 判不了（函数在；推钟属侵入写，线上只读不做） |
| 3b | 新版紫色横幅 + 点×不再弹 | 过（线上真登确认） |
| 4 | 学生档案 层次/专业 多项 | 过（target_programs 数组 2 层次） |
| 5 | 迁移 0220/0218/0222 三 RPC | 过（存在+可调）；`_mh_level_aliases`/`admin_dispatch_docs` 判不了（需 SQL 核） |
| 6 | 云函数清单（CLI） | student-avatars/filing-prefill(部署版2=v1+HOTFIX39)/watermark v37/precheck v26/send-invite 皆在；admin-reset 未部署 |
| 7 | 线上版本探针 | 线上 v409/v180/v245=上轮基线；本地已进 v410/v181 待推 |

## 需其它账号 / SQL 才能验（给第41轮）
- **一个资料未填满的学生测试账号** → 线上看淡黄预填（item1 线上）。
- **学校 / 中介 / 管理员测试账号**（`accounts.json` 已有 stuA/partner1/reviewer1/schX，但本轮只授权学生账号）→ 线上验：中介端代填 PDF、管理端「重置密码」按钮、缩略图 55min 重签。
- **SQL Editor 查 `pg_proc`** → `_mh_level_aliases`、`admin_dispatch_docs` 是否落库。

## 第四十一轮建议包（QUEUE-40 §40-04 必含）
1. 部署两云函数（卡1281）后，**线上真验**：AI 读 PDF 真跑一次（花钱，由 Claude 用卡代查）、管理端重置密码端到端真验。
2. **补学校/中介/管理员测试账号授权**后，用 40-03 同法把其余欠验项自验一遍。
3. **at0086**（学校建档系统接入收尾）。
4. **平台常量真值**（导出 meta 的 filing_url/name_zh 数据血缘缺口，见 32/33 轮 backlog）。
5. **武汉纺大真跑**（人工）。
