PUSH_OK=yes

# SUMMARY-21 · 第二十一轮收官（只修不加：水印缓存覆盖 + 常驻渲染方案 + 中介端卡片/守卫 + 法文/preload/走查核验）

> PUSH_OK=yes 只表达 CC 自己的闸全过（各包先红后绿 / N1–N7 / shell-lint / secret-scan）。视觉件（中介端卡片位置）与部署件（watermark v36、迁移 0213）的线上肉眼验收/手贴/部署仍需业主，逐条列在下方「未放行」「要业主亲眼看的」。

## 一、版本与 md5（本轮）
- **中介端 partner v168 → v169**（唯一升版端）：`7bbddf589cbe4f9f2d3eb3364bd8faf1`
- 未动端（md5 与 SUMMARY-20 全等）：student v399 `dd3a5bcc…` / school v234 `a2d2e593…` / admin v218 `73b36f0a…` / reviewer v45 `c2cf1f26…`
- 学生端**不 bump v400**（21-03 法文两键已满足）、审核端**不 bump v46**（21-04 源码无可改点）。
- 主仓库本轮 **7 个提交待业主推送**（21-00×2 / 21-01 / 21-02 / 21-03 / 21-04 / 21-05），HEAD 领先 origin/main；CC 未推（§0.9）。

## 二、watermark-doc 升版与「待部署」
- **watermark-doc 源码 v35 → v36**（21-01）：现场渲染（reviewer 未命中）成功后回写 wm-cache（同 prepare 对象名/索引行，`EdgeRuntime.waitUntil` 放回图之后、零客户端等待、限 reviewer、fail-open、不改缓存语义），并删计时头恒 0 的 `mem` 段、保留 `seq`。
- **状态 = 源码已改、未部署**。部署脚本 `jobs/JOB-21-01/deploy-watermark.sh`（含 OPTIONS / 无凭据网关 401 / reviewer1 真登取一份→200 且头含 seq 不含 mem 的探针）；计时探针 `jobs/JOB-21-01/wm-timing-probe.mjs`。**待业主部署后验收**。

## 三、待业主手贴的 SQL（本机未执行）
- **`docs/supabase 文件/0213_wm_prepare_coverage.sql`**（21-01）：防御触发器/函数，补两类缓存冷窗口——gap2 重新派单（`reviewer_assignments` un-revoke）→ 触发 prepare 预渲染；gap1 换件（`documents.file_path` 变）→ 触发 cleanup。只增不删、可重复执行、带注释；本机临时 Postgres 跑两遍幂等过。**业主在 Supabase SQL Editor 手贴执行**（Claude 出卡；铁律16：执行成功后已随 21-01 卡归档入册）。

## 四、每包一句话
- **21-00**：开工核对（九件 md5 全等 / HEAD 干净 / 四账号真登 / 0213 空）+ 七探针 + 旧病复现（④跳登记表单、⑤卡片 5567/8586ms 无悬停 390 重叠 15750px² 真红；⑥学生法文已法文、⑦审核端本地 0 preload 未复现）+ 三端静态清单 N1 基线。
- **21-01**：watermark v36 现场渲染回写缓存（源码未部署）+ 迁移 0213 防御触发器（未执行·SQL 全文供手贴）+ 常驻渲染方案书 + deploy/timing 脚本（lint 绿·syntax 过）。
- **21-02**：中介端 v169 —— 琥珀卡停留 5500→15000/8500→20000ms + 鼠标悬停暂停（剩余≥3s）+ 卡片定位从右上改钉视口底（详情弹窗 760px 居中，右上两宽都压标题条；桌面右下/手机通栏，六项零重叠）+ renderUploadGrid 守卫加 `state.wiz.step`（无 step 不跳登记表单）；名单块冒号 v168 已按语言无改。真页面先红后绿全过 + N1（0 删）+ N7 四项。
- **21-03**：学生端法文两键核验 —— v399 真页面 fr 已法文（源 v360_fr 包 L1181/L76，无 _sup.fr 覆盖），premise（fr 回落英文）未复现 → 只修不加、不 bump v400。
- **21-04**：审核端 preload 核验 —— v45 本地真渲染 0 告警，源码唯一 preload（supabase.js）被正确使用、字体全 @font-face 无 preload、无运行时注入 → 源码无可改点、不 bump v46；三条警告系 CF 边缘注入，标未放行（等业主线上核 + CF 设置）。
- **21-05**：走查脚本版本表自动化 —— 期望版本改读主仓库 `<portal>/index.html` 指向（单一真源，不再手写）+ `MH_WALK_VERSIONS_ONLY` 自测开关；自检 school 假 v999 判红·还原干净·lint 绿；现役线上跑 绿6/红2（partner v169 领先线上 v168，正确信号）/N/A4。

## 五、截图文件名（本机 `~/mh-verify/shots/JOB-21/`；公开 `~/mh-jobs/shots/21/`）
- `shots/21/21-02/card-@390.png`、`card-@1280.png`、`INDEX.md`：中介端 v169 卡片位置验收（手机底部通栏 / 桌面右下；弹窗标题条含姓名已 mask）。
- `shots/21/walk/INDEX.md`：21-05 走查（本次未产出截图，PII 红线；证据在红绿表）。

## 六、未放行清单（CC 闸过、需业主动作才闭合）
1. **watermark-doc v36**：源码已改、**未部署**。业主部署后跑 `deploy-watermark.sh` 探针验收（21-01/21-06）。
2. **迁移 0213**：SQL 已入册、**本机未执行**。业主在 SQL Editor 手贴（21-01）。
3. **审核端三条 preload 警告**：源码无可改点，标**未放行·等业主线上真 URL 核 + CF 关 Rocket Loader/Early Hints**（21-04）。若业主贴回线上告警 href，CC 再评估是否有源码侧配套（须先有线上实证，铁律14）。
4. **中介端 v169 卡片定位**：桌面从「右上」改「右下」系 760px 居中详情弹窗的**必要偏离**（右上任何可读宽度都压标题条）；数字实证六项零重叠，**留业主线上肉眼验收**（闸二）。

## 七、要业主亲眼看的（推送 + 部署后）
- 中介端：护照琥珀卡停留更久（一般 15s / 护照 20s）、鼠标悬停暂停、手机不再盖弹窗标题条/关闭钮、桌面卡在右下。
- 中介端：详情弹窗暂存不一致护照时**不再突然跳到登记表单**。
- 学生端：法文界面「Attestation d'études / Plan d'études」两栏名（本就法文，核验项）。
- 审核端：**线上真 URL** 控制台确认三条 preload 警告的具体 href（判定是否 CF 注入）→ 关 CF Rocket Loader/Early Hints 后应消失。
- 部署 watermark v36 + 手贴 0213 后：审核员**第一次**打开没缓存的可渲染件（现场渲染）→ **第二次**直读应命中缓存（`wm-timing-probe.mjs` 断言）。

## 八、第二十二轮建议包
1. **常驻渲染方案书结论（21-01 `jobs/JOB-21-01/persistent-renderer-proposal.md`）**：CC 荐**暂缓**（v36 回写 + 0213 触发器已把「审核员首开 5s」的冷窗口收敛到极小；常驻渲染是更大工程）。若要做，**首选 CF Worker**（站点已在 Cloudflare Pages+Access，Worker 实例复用好、支持 WASM 图片库，避免新平台/新密钥面）而非 Fly/Railway 常驻容器。**业主要定的三问**：①花不花钱（Worker 付费档 vs 现状 EF 冷启）②服务密钥放哪（Worker Secret vs 容器 env，均须离 GitHub）③谁维护（Worker 与现 EF 同栈、维护面小）。
2. **旧版本网页标签处理（承 21-05 版本表自动化）**：各端启动时对比线上 `index.html` 指向与当前打开的版本，不一致就提示「有新版，请刷新」——**待业主点头**再做（涉及全端小 UI，先请示）。
3. **partner v169 卡片定位**：若业主线上验收不满意「右下」，再评估右上窄卡（≤244px 仅 ≥1280 清得开）或其它方案（本轮已留必要偏离说明）。
4. **REJ-1 / 配额云化 / access_log 等既有 backlog**（承第二十轮 LEDGER）按业主优先级排。

## 九、闸账
- 各包 secret-scan 全 CLEAN；`jobs/JOB-20-04/shell-lint.sh` 每包收尾全绿；给业主粘贴的脚本正文无 `!`/反引号。
- 21-02 真页面 partner1 先红后绿全过（时长/悬停/六项零重叠/守卫/四语冒号）+ N1（0 删，+3 闭包）+ N7 四项。
- 无「必须停」（§0.8）触发：基线九件 md5 全等、HEAD 干净、四账号真登过、无删桶/改真实数据/动共用查看器/学校端/管理端。
- **PUSH_OK=yes**（本轮 CC 自闸全过）。
