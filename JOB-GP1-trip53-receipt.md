# 第53趟收工 · 第四轮返工收官：重录第6章横版清 OP-2 拉伸 + 四语终审 + SUMMARY 第四版

**大白话：** 第52趟遗留的"开场 OP-2 横版画面被横向拉伸"这一处，这趟照裁决 §二.4 忠实修掉了——重录第 6 章横版取回正常横帧、重做开场、重拼横版长片/速览。然后四种语言各把十一项（含字幕行数表）重审一遍，更正第三版两处说法，写出第四版收官单。**GP-1 第四轮返工到此收官，循环自停。**

## 做了什么

1. **重录第 6 章横版（四语）**：`_runch6.sh land:en land:ru land:fr land:zh`（去提额横幅 → 录 → 复位）。
   - 新帧实测 **3000×1358**（正常横版），tag `<lang>-land-ch6` 正常。先前被 trip43 误按竖版视口录成 1080×1600 竖尺寸，这就是 OP-2 横版拉伸的根。
   - **现行 rec.mjs 的 tag 逻辑已正，无需改 `_runch6.sh`**——orient 污染是 trip43 历史问题，本趟实证现行代码无此 bug。
   - 第 6 章只读（仅一条可逆的提额横幅置态，录后还原）。开工 + 收工 DB verify 均 **17/17 PASS 0 FAIL**。

2. **重出开场/片尾 + 重拼**：`gp1-finish bookend/film/trailer` 四语各跑 → 重出 OP/ED（横竖）+ 重拼 full/trailer（横竖）。zh land 也重拼了一次，**仅为纳入修好的 OP-2 横版画面，字幕/章节一字未改**。时长与 trip49/52 一致（full en 422.5/ru 438.2/fr 428.0/zh 429.2）。

3. **OP-2 横版拉伸清零**：四语亲帧复验 OP-2 横版 b-roll 现为正常横版（1920×1080 无拉伸）——Hussain Bilal 盲态进度视图、只露申请号 MH-BY2KDK、无校名（双盲守住）、¥0 无负数、无 beta。

4. **OP/ED 联络表重出**：`_op-ed-contact.mjs` 四语横竖各一 OP（10 格）+ ED（2 格），16 张已推 `shots/GP1/`。ED-2 二维码 jsQR 真帧解码 8 片（四语×横竖）= `https://www.maxhouses.net/partner-portal/?src=video-<lang>` 逐字对。

5. **行数表复核**：`_gate-lines.mjs` 复核 ch6 land 四语（各 4 镜）+ 旧 FAIL 镜（2-4 四语竖 / 9-3 ru 竖 / 6-2 ru 竖）全 **ALL PASS**（横≤2 / 竖 3/3·底边距≥29px）。本趟零字幕改动，行数表同第52趟。

6. **四语终审 + 文书**：四语 `REVIEW-<lang>-shots.md` 追 trip53 节、标 OP-2 残留已清；四语 `REVIEW-<lang>-self.md` 把"残留未清关"改为"残留已清、十一项全过清关"。

7. **SUMMARY 第四版**（`~/mh-jobs/SUMMARY-GP1.md`，首行 PUSH_OK=yes）：大白话写清每条怎么处理、留业主 8 条产品问题、四语时长、"第四版与第三版的区别"节；**更正第三版两处**：自审第 6 项当时没量行数、「四语十一项全过 0 条对不上」在第三版不成立。

## 如实记账

- **§四.5 ch6 forbidden 复扫降级**：`_scan-ch6-forbidden.mjs` 本趟 4 次运行均在第二次登录处 Supabase Auth 超时（首次登录成功：实测 **en land = CLEAN**），病因＝录制 4 次 + 扫描多次 signInWithPassword 触发 auth 限流（网络 200、db-run verify 正常、录制本身登录成功为证）。照 RULING-20261012-gp1 §二.4「试 2 趟不成即降级」停重试。forbidden 安全由三证立：①四语录制内建 @gmail MASK 检查全 `✅ no @gmail`；②四语 OP-2 横版 b-roll 亲帧复验无 beta/负数、双盲守住；③第 6 章只读、本趟仅改录制视口尺寸、画面文字与竖版/历史横版同源（先前 ALL CLEAN）。
- **_v3 留底缺口**：第52趟重拼 full/trailer-land 前未先 cp 到 `_v3/`（_v3 现仅含 ch2/ch6-ru/ch9-ru 章成片），第三轮 full/trailer-land 已被 trip52 覆盖、不可逆。本趟修复在第四轮版上继续，无新第三轮文件可留底。此系 trip52 遗留，记录在案。

## 账目

- §0 代码核验：`git diff origin/main -- partner-portal` 空、无未跟踪、无 v186、index 指 v185 —— **本轮零端口代码改动**。
- 主仓库点名提交 JOB-GP1（DECISIONS D-53-1 + 4 REVIEW-shots + 4 REVIEW-self + 4 ch6-land timeline），**未推**（本轮红线）。成片在本机 dist、不入 git。
- mh-jobs 推：PROGRESS + 决定账 + 4 REVIEW-shots + 4 REVIEW-self + 16 OP/ED 联络表 + SUMMARY 第四版 + 本回执（P5 四段式验证）。

**GP-1 第四轮返工收官。不开始 GP-2：不传 R2、不动 Cloudflare、不推主仓库。循环自停。**
