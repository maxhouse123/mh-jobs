最后一趟：2026-10-13 第39趟 第三轮返工（RULING-20261013b-video-only）：**做了＝第〇节代码核验（partner-portal 与线上一致·无 v186·diff 空）+ ch1 §三.10 定版重录 + §三.7 去横幅 + §三.9 俄法章节条**。ch1 四语横竖 8 片用 v185 重录（不沿用旧录像）；1-8 露工作台顶部→录前 st-ch8-quota-off/录后 restore 去掉「Quota raise pending 10→30」横幅；俄法章节条左标签继承 trip38 已改 overlay（Центр партнёров/Espace partenaires）。ch1 字幕无缺陷纯重录（字幕/shots/captions/产品码一字未改）。开工+收工 verify 均 **17/17 PASS 0 FAIL**。亲眼逐帧：EN land 1-8 f00402+EN port 1-8 f00438（hero 橙框·¥0 无负数·无横幅·STUDENTS 9）+RU/FR land 章节条裁帧（Центр партнёров/Espace partenaires）；无 beta/test、双盲守住、no @gmail、页头平台联系方式不遮（D-14-3/D-15-1）、俄法 hero LL 英文回退 D-18-4 照录。第二版 ch1 成片留底 _v2/、dist 覆盖第三轮版。**下趟＝ch3（§三.3 ch3-3 中俄法档案字段高亮+§三.4 ch3-9 滚到 Demo Aisha 卡+§三.8 俄法 3-1 引用按钮名+§一 工作台；state 章需 st-ch3-cleanup/mark-test）**。GP-1 第三轮返工未收官。
> 【存档·第38趟】最后一趟：2026-10-13 第38趟 第三轮返工（RULING-20261013b-video-only）：**做了＝第〇节放回代码核验（partner-portal 与线上一致·无 v186·diff 空）+ ch2 §三.1 重做**。2-3 高亮改框第一张学生卡整卡（原框计数药丸）；2-4 改为依次框 5 张不同真实阶段的卡状态行（nth1/4/5/6/8＝审核中/已通过匹配/新offer/已发通知书/录取完成·rec.mjs 新增 hlseq 多段高亮）+四语字幕重写重配音；§三.7 录前 st-ch8-quota-off/录后 restore 去掉工作台顶部提额横幅；§三.9 俄法章节条左标签改 Центр партнёров/Espace partenaires。四语横竖 8 片 v185 重录+重拼，开工+收工 verify 均 **17/17 PASS 0 FAIL**。亲眼逐帧复验 EN seg1-5/2-1/2-3+ZH seg3+RU/FR seg5：环框正确、无提额横幅、¥0 无负数、各 ¥ 正数、无 beta/test、双盲守住、no @gmail。第二版成片留底 _v2/、dist 覆盖第三轮版。**下趟＝ch1（§三.10 十章全部重录：四语横竖 v185 定版重录+§三.7 去横幅+§三.9 俄法章节条；ch1 字幕无缺陷纯重录）**。GP-1 第三轮返工未收官。
> 【存档·第二版收官单结论，已被第三轮返工重开】最后一趟：2026-10-13 第37趟 返工：**做了＝四语过 review1 §六十一项重审 → GP-1 返工收官**。全部工作台章(ch1/2/3/5/7/8/9/10 v185 定版)+ ch6 §二去揭晓(trip21)+ ch4 原版 + 开场快剪 OP-2..5 + 四语全片/速览(trip36 重拼)齐备。本趟纯复审+文书、**零 DB 写入**，开工+收工 verify **17/17 PASS 0 FAIL**。十一项四语各自全过：写 REVIEW-en-self.md(九项升十一项 v2)+ 新建 REVIEW-{zh,ru,fr}-self.md；四张 shots 逐镜对账表 **0 条「否」**。当场新验：①禁用词＋真名校名＋beta/test 对 captions 全 **57 镜×4 语** 扫描 **0 命中**；②8 个片尾成片 ED-{land,port}-{en,zh,ru,fr} 抽实帧 jsQR **真帧解码**全＝`…/partner-portal/?src=video-<语言>` 逐字对；③ffprobe 实测四语 full/trailer/OP/ED 时长与 trip36 记录逐项一致、segments 全语齐。四语新时长：全片 land/port EN426.6/424.7·ZH441.1/440.3·RU449.9/449.6·FR440.3/439.8s；速览 EN164.3/162.8·ZH168.4/167.6·RU172.3/172.2·FR165.8/165.5s。十一项四语全过→照 RULING-20261012c-rework 第4条重写 `~/mh-jobs/SUMMARY-GP1.md`(首行 **PUSH_OK=yes**，大白话：返工改了什么/review1 每条怎么处理/6 条产品问题留业主/四语新时长/v1 与 v2 区别/GP-2 建议包)。主仓库点名提交 JOB-GP1(4 self-review+DECISIONS D-37-1)不推；4 self-review+SUMMARY+决定账+PROGRESS 推 mh-jobs。**GP-1 四语横竖返工全部收官，循环自停。不开始 GP-2：不传 R2、不动 Cloudflare、不推主仓库。**

# 第 39 趟（2026-10-13 Mac mini 无人值守）· ch1 §三.10 定版重录 + §三.7 去横幅 + §三.9 俄法章节条（RULING-20261013b-video-only）
- **背景**：第三轮返工续跑（§五 顺序 ch2 后首章＝ch1）。第〇节代码核验：partner-portal 无 v186、`git diff origin/main --stat -- partner-portal` 空、无未跟踪文件→无需还原，本轮不改五端口代码（每趟复核在案）。
- **本趟＝ch1**：
  - **§三.10（定版重录）**：ch1 整章四语横竖 8 片用 v185 重录（不沿用旧录像）→ prod-ch 合成覆盖 dist → gp1-finish contact 四语联络表。8 片 res OK+audio yes+no @gmail+8 镜 box 全 resolve。时长 land en49.45/zh49.44/ru51.21/fr49.68·port en49.45/zh49.49/ru51.26/fr49.59s。
  - **§三.7（去横幅）**：1-8 露工作台顶部 hero。录前 `st-ch8-quota-off`（quota_requests 单列 pending→approved、decided_at 保持 NULL→产品清横幅）、录后 `st-ch8-quota-restore` 还原 pending。横版 en 1-8 f00402+竖版 en 1-8 f00438 亲验：header 与 hero 间无 amber 横幅。收工 verify #13 回 pending。同时取代 trip29 ch1 §一节「1-8 横幅属真实背景、不矛盾」说法。
  - **§三.9（俄法章节条）**：gp1-overlays.mjs ru.hub=Центр партнёров、fr.hub=Espace partenaires（trip38 已改 commit），本趟 ch1 重烧继承。横版 ru/fr 成片裁帧亲验章节条已改。zh「合作伙伴端」/en「Partner Hub」不在范围、不动。
- **验收**：开工+收工 verify 均 **17/17 PASS 0 FAIL**（scoped 置态/复位）。1-8 hero TOTAL PAYMENTS PROCESSED ¥0 无负数、STUDENTS SUBMITTED 9、APPROVED 徽章橙框；无 beta/placeholder/test；注册段邀请码打码/SPECIMEN 样件/无真护照电话/Demo Agency 无真 PII；页头平台 WhatsApp/Email 不遮（D-14-3/D-15-1）；俄法 hero LL 英文回退（D-18-4 照录不补）。
- **账目**：主仓库点名提交 JOB-GP1（REVIEW-{en,zh,ru,fr}-shots.md 追加 ch1 第三轮节 + DECISIONS D-39-1），**未推**（本轮红线）。无 shots/captions/产品码/迁移改动。第二版 ch1 成片留底 `guide/dist/partner/_v2/ch1-*.mp4`，dist 覆盖第三轮版（不入 git）。四语 ch1 联络表 + 4 REVIEW-shots + 决定账 + PROGRESS 推 mh-jobs。
- **下趟**：ch3（§三.3 ch3-3 中俄法横竖整段停在档案字段出生日期/护照号并高亮 + §三.4 ch3-9 滚到刚提交的 Demo Aisha 卡再框 + §三.8 俄法 3-1 引用按钮名 + §一 工作台背景；ch3 是 state 章需 st-ch3-cleanup/mark-test）。**GP-1 第三轮返工未收官**，后续 ch4→ch10（含 §三.2 ch5-1/§三.5+§三.6 ch7）逐章做，再 OP 重做+重拼+十一项重审→才重写 SUMMARY-GP1。

# 第 38 趟（2026-10-13 Mac mini 无人值守）· 第三轮返工开工 + ch2 §三.1 重做（RULING-20261013b-video-only）
- **背景**：第二版(trip37)曾判收官；业主 2026-10-13 19:04 改判「不改中介端任何代码、只完成操作视频并上线」→ RULING-20261013b-video-only 开第三轮返工（RULING-20261013a-review2 作废、v186 取消）。SUMMARY-GP1-v2-*.md 系业主改名的第二版收官单，不动。
- **第〇节（放回代码）**：partner-portal 无 v186、`git diff origin/main --stat -- partner-portal` 空、无未跟踪文件 → 第二轮从未动 v186，无需还原。本轮不改五端口任何代码。（以后每趟复核此两项。）
- **本趟＝ch2（§五 顺序先 ch2）**：按 §三.1 重做 2-3/2-4 + §三.7 去提额横幅 + §三.9 俄法章节条左标签。
  - **2-3**：高亮由计数药丸改框第一张学生卡整卡（Serikova Aizhan），字幕不改。
  - **2-4**：依次框 5 张不同真实阶段的卡状态行 `.partner-student-issue`（nth 1/4/5/6/8＝审核中/已通过匹配/新offer Bilal/已发通知书 Karimova/录取完成 Volkov；rec.mjs 新增 hlseq 多段高亮，每段 hold1.3s、环不熄仅移动，逐段占其时段~76%≥70%）。字幕四语重写（不加引号避 §四.4）+重配音。实证探针 _probe-ch2-issue/_probe-ch2-nth；8 片 timeline seq 全 YYYYY。
  - **§三.7**：录前 st-ch8-quota-off（quota_requests 单列 pending→approved）、录后 st-ch8-quota-restore。2-1 整屏已无「Quota raise pending」横幅。
  - **§三.9**：gp1-overlays.mjs 俄 hub→Центр партнёров、法 hub→Espace partenaires（＝v185 页头名，亲帧实证），只重烧章节条、重拼 ru/fr ch2。
- **验收**：开工+收工 verify 均 **17/17 PASS 0 FAIL**（scoped 置态/复位）。四语横竖 8 片 res OK+audio yes，录制全 no @gmail。亲眼逐帧：EN seg1-5（环框正确状态行·¥3,000 正数）+2-1（无横幅·¥0 无负数）+2-3（整框首卡）；ZH seg3（发来新 offer·章节条本地化）；RU seg5（录取完成·章节条已改 Центр партнёров）；FR seg5（admission terminée·章节条已改 Espace partenaires）。无 beta/test、双盲守住、演示机构无真 PII、页头平台联系方式不遮（D-14-3/D-15-1）。俄法状态行内英文回退片段＝产品 i18n 回退（D-18-4 照录不补）。
- **账目**：主仓库点名提交 JOB-GP1（shots-v1.json/captions-v1.json/rec.mjs/gp1-overlays.mjs/4 REVIEW-shots/DECISIONS+探针），**未推**（本轮红线）。第二版 ch2 成片留底 `guide/dist/partner/_v2/`，dist 覆盖第三轮版（不入 git）。四语 ch2 联络表(contact+2-4 segments)+4 REVIEW-shots+决定账+PROGRESS 推 mh-jobs。
- **下趟**：ch1（§三.10 十章全部重录：四语横竖 v185 定版重录+§三.7 去横幅+§三.9 俄法章节条；ch1 字幕无缺陷，纯定版重录+横幅/章节条处理）。**GP-1 第三轮返工未收官**，后续 ch3→ch10（含 §三.2/§三.3/§三.4/§三.5/§三.6/§三.8）→OP 重做→重拼→十一项重审→才写 SUMMARY-GP1。

# 第 37 趟（2026-10-13 Mac mini 无人值守）· 四语过 review1 §六十一项重审 → GP-1 返工收官
- **接手核对**：git status + 读齐 PROGRESS/loop-tail(20261012-163805·辨明 16:00「2 分钟即停」＝误判收官非真收官)/RULING-b-review1(§六十一项)/-c-rework(第4条收官)/-gp1(§三前九项+§二停下四情形)/-d/-e/DECISIONS/QUEUE/storyboard。trip36 已全部返工+重拼→本趟＝十一项重审+写 SUMMARY。首行开工即改「返工进行中」，开工 verify **17/17 PASS**。
- **性质**：纯复审+文书，零重录/零置态/零 DB 写入。
- **十一项证据**：多数已在 trip21-36 落 REVIEW-*-shots.md(第十一项逐镜对账·0 否)，本趟跨语言汇总 + 补三项当场新证(禁用词扫描/二维码真帧解码/ffprobe 时长)。
- **ch6 §二 复核（防误判）**：trip36 PROGRESS「ch6 review1 未列」措辞易误解——实证 D-21-1(trip21) 已完整执行 review1 §二(删 6-4/6-6+去 _p130_SchoolCache→6-1→6-2→6-3→6-7 只读、6-3/7-1 字幕四语改+重配音、beta 链接 MASK_INIT 遮、速览镜单改)。ch6 无工作台背景→§一未列、不需 v185 重录，trip36 纳入 trip21 返工版。核对无缺。ch4 同理(review1 未标任何缺陷+无工作台背景)。
- **缺陷2**：曾拟写 NEEDS_OWNER_DECISION，后中介端 v185 修好上线(RULING-d/e 2026-10-12 21:38)作答→不再需停下，含工作台章全 v185 定版重录销账；旧两张 NEEDS_OWNER_DECISION(1914/2017)属旧议题已由 v185 上线作答，本趟不新写停下文件。
- **改了**(主仓库点名 JOB-GP1 不推)：REVIEW-en-self.md(九→十一项 v2)、REVIEW-{zh,ru,fr}-self.md(新)、DECISIONS.md(D-37-1)。无成片/shots/captions 改动。4 self-review+SUMMARY-GP1+决定账+PROGRESS 推 mh-jobs。
- **下趟**：无。GP-1 收官，循环自停。

【上一趟（第36趟）首行存档】最后一趟：2026-10-13 第36趟 返工：**做了**＝§五 开场快剪 OP-3/4/5 四语横竖（仿 trip26 OP-2）+ 四语全片/速览重拼。缺陷2(工作台漏斗)已随中介端 v185 上线修好(RULING-e)、ch3/ch7 trip30/31 v185 定版重录→OP-3/4/5 素材(3-8 真 app_no/7-0 ¥0/7-1 校名揭晓+下载)解除阻塞。给 gp1-finish.mjs OP_BROLL 加 OP-3/4/5：按镜号从该章 timeline 取窗(逐语言/画幅各异)。**OP-3**(3-8)动态播完末帧定格真 app_no；**OP-4**(7-0,still:4.5)——取证发现 7-0 的 pre 在镜内跑、ts~4 ¥0 发票落定后点付款→成功页带「Paid(beta placeholder)」吐司且各语言付款时点不一(ru-port ts9 已处理中)，动态窗必漂入 beta 页→改**定格 ts≈4.5 干净 ¥0 发票单帧**(¥0 全程在画面，避 lead-in/处理中/beta)；**OP-5**(7-1,leadin:1.0)跳开窗转场落录取详情(揭晓校名条+下载钮两段高亮)。b-roll 加 tpad=clone 补满 brollDur+强制 30fps CFR(避定格窗低帧率致全片 A/V 漂移)。读 rec.mjs 实证 HIDE_INIT(遮 .cloud-offer-unlock beta 链接)+MASK_INIT(@gmail→demo)在录制时改活 DOM→原始帧即已遮/脱敏。亲验四语 land OP-3(en MH-EYJ5EE/zh MH-M4S9FH)+OP-4(¥0:en+ru land/port+zh)+OP-5(reveal:en+fr)+en-port OP-4：真 app_no/¥0 无负数/校名揭晓+下载、全程无 beta/内测/test、演示生无真 PII、邮箱掩码 no @gmail、双盲守住、标题条＝本语 OP 卡标题/ED-1 回顾一字一致；卡总时长=配音+0.5 不变、配音未动。§十一对账四语写 REVIEW-*-shots.md(开场快剪 OP-3/4/5 段)。**四语全片/速览重拼**(bookend→film→trailer，纳入全 v185 定版章+OP-3/4/5)：全片 land/port EN 426.6/424.7·ZH 441.1/440.3·RU 449.9/449.6·FR 440.3/439.8s(drift≤0.1)；速览 EN 164.3/162.8·ZH 168.4/167.6·RU 172.3/172.2·FR 165.8/165.5s。8 全片+8 速览真 Chrome 全 readyState4/seek 近尾/pageErr 0。章节底座 ch1-3/5/7-10 为 v185 定版、ch4/ch6 review1 未列照原版入拼。本趟纯成片工装、**零 DB 写入/零置态**，开工+收工 verify **17/17 PASS 0 FAIL**。dist OP/full/trailer/segments 覆盖为 v2(v1 早在 `_v1/` 留底)。主仓库点名提交 JOB-GP1(gp1-finish.mjs+4 REVIEW+DECISIONS)不推；四语 4 REVIEW+决定账(D-36-1)+PROGRESS 推 mh-jobs。**下趟**＝全部工作台章+开场快剪(OP-2..5)返工完毕、四语全片/速览已重拼→四语过 review1 §六十一项重审(写/更新 REVIEW-{en,zh}-self.md+ru/fr 自审)，全过后照 RULING-20261012c-rework 第4条重写 `~/mh-jobs/SUMMARY-GP1.md`(首行 PUSH_OK=yes，大白话)。写完循环自停。**GP-1 未收官，勿据旧『收官』停工。**

# 第 36 趟（2026-10-13 Mac mini 无人值守）· §五 开场快剪 OP-3/4/5 + 四语全片/速览重拼
- **接手核对**：git status + 读齐 PROGRESS/loop-tail/RULING-b/-c/-d/-e/-gp1/DECISIONS/QUEUE/storyboard/D-26-1(OP-2 先例)。trip35 列下趟＝OP-3·4·5。首行开工即改「返工进行中」，开工 verify **17/17 PASS**。
- **选题**：OP-3/4/5(review1 §五最后一块)；缺陷2 v185 上线+ch3/ch7 v185 定版→素材解除阻塞；做完即全部返工完毕→重拼全片。
- **实现(零改产品码/迁移)**：gp1-finish.mjs OP_BROLL+OP-3/4/5 按镜号取窗；OP-4 still:4.5 定格干净 ¥0 发票避 beta 吐司(取证 7-0 pre 在镜内跑、各语言付款时点不一)；OP-5 leadin:1.0；nearestFrame/stillConcat；tpad=clone 强制 30fps CFR。
- **自验**：四语 OP-3/4/5 card+b-roll+尾帧亲验(真 app_no/¥0/揭晓+下载、无 beta、demo-safe、no @gmail、双盲守住、标题条一致)；卡时长=配音+0.5 不变、配音未动。
- **重拼**：四语 bookend→film→trailer；8 全片+8 速览 Chrome 播放全过；drift≤0.1；OOR＝groupSegments 既有贪心(ED 尾段有意独立+偶发 43-45s 段)、非本趟引入。
- **DB**：零写库，开工+收工 verify 17/17 PASS 0 FAIL。
- **改了**(主仓库点名 JOB-GP1 不推)：rec/gp1-finish.mjs、REVIEW-{en,zh,ru,fr}-shots.md、DECISIONS.md(D-36-1)。成片/voice 不入 git；dist 覆盖 v2、v1 在 _v1/。四语 4 REVIEW+决定账+PROGRESS 推 mh-jobs。
- **下趟**：四语 §六十一项重审→写 SUMMARY-GP1(PUSH_OK=yes)。GP-1 未收官。

【上一趟（第35趟）首行存档】最后一趟：2026-10-13 第35趟 返工：**做了**＝ch10 设置章（读-only）v185 工作台背景定版重录，落 review1 §一（销 1-8 类负数/漏斗缺陷1 的工作台背景）。ch10＝设置章 3 镜 10-2/10-3/10-4（高亮 hub 已登录态的账户设置/语言切换/退出菜单项，client-side·全程零写库·无弹窗置态，同 ch1/ch9 profile）；review1 未标 ch10 任何字幕缺陷→字幕/高亮/shots/captions 一字未改，纯换录制底座 v184→v185（漏斗修复已上线 RULING-e）重录 3 镜 × 四语 × 横竖＝8 片覆盖 dist 使背景数字落定版。亲验 en-land 10-2 原始帧 f00022 + fr-land 10-2 原始帧 f00022 + 四语 land 联络表：背景 hero「TOTAL PAYMENTS PROCESSED **¥0**」无负数（缺陷1 销账，§一达标）、「STUDENTS SUBMITTED 9」；三下拉项高亮逐镜对账仍「是」；RU/FR 高亮目标真本地化（Настройки аккаунта/Выйти、Paramètres du compte/Se déconnecter 非 EN 回退），hero 卡标签/提额横幅 RU/FR 英文回退＝D-18-4 照录入 SUMMARY，与 ch1/ch9 同背景非本趟引入；Demo Agency 无真 PII、邮箱掩码 agency.demo@example.c…、无 beta。8 片全 res OK+audio yes+no @gmail+3 镜 hl 全 resolve。§十一对账四语写 REVIEW-*-shots.md（ch10 §一段）。时长 land en16.31/zh16.33/ru16.32/fr16.30·port en16.32/zh16.32/ru16.32/fr16.29s（3 镜）。ch10 读-only 零写库，开工+收工 verify **17/17 PASS 0 FAIL**，baseline 全程守住。ch10 v1 早在 `_v1/` 留底、dist 覆盖定版 v2。**全片不重拼**（待全部工作台章完后统一拼）。主仓库点名提交 JOB-GP1 不推；四语 ch10 联络表(land+port)+4 REVIEW+决定账+PROGRESS 推 mh-jobs。**下趟**＝OP-3·4·5 开场快剪（§五，素材 3-8/7-0/7-1 已随 ch3/ch7 v185 定版就位·不再阻塞·仿 trip26 OP-2 做法）；OP-3·4·5 做完即全部工作台章+开场快剪返工完毕→四语过十一项重审+重拼全片（纳入全部 v185 定版章）→写 SUMMARY-GP1 首行 PUSH_OK=yes。**GP-1 未收官，勿据旧『收官』停工。**

【上一趟（第34趟）首行存档】最后一趟：2026-10-13 第34趟 返工：**做了**＝ch9 增值服务章（读-only）v185 四语横竖定版重录，落 review1 §一（v185 工作台背景）。ch9 字幕/高亮 trip23（§三.6）已改对——9-1 增值服务区标题、9-2 Audit ¥1,500、9-3 Human-assisted ¥600、9-4 付费曝光 ¥4,500 起，逐镜框对应真行，字幕/shot 一字未动（已 banked）。本趟纯换录制底座 v184→v185（漏斗修复已上线 RULING-e，rec.mjs trip28 已切 FILE=partner-portal-v185.html）重录 8 变体 + prod-ch 合成覆盖 dist，使背景数字落定版。亲验 en-land 9-1/9-2 原始帧 + ru-land 9-1 原始帧 + 四语 land/port 联络表：增值服务区标题行右「Invested on this student: **¥0** / 该学生已投入：¥0 / Вложено в студента: ¥0 / Investi pour cet étudiant : ¥0」**无负数**（缺陷1 销账，§一达标）；三服务行价与字幕逐镜对账仍「是」；RU/FR chrome 真本地化（Центр партнёров/Ожидает/Платное продвижение/Espace partenaires…），Audit Service/Human-assisted Search 等 LL 动态串英文回退（D-18-4 照录不补，留 SUMMARY）。8 片全 res OK+audio yes+no @gmail+4 镜 box 全 resolve。§十一对账四语写 REVIEW-*-shots.md（ch9 v185 定版段）。时长 land en22.73/zh23.77/ru26.38/fr24.18·port en22.79/zh23.76/ru26.46/fr24.30s（4 镜）。ch9 读-only 零写库，开工+收工 verify **17/17 PASS 0 FAIL**，baseline 守住。ch9 v1 早在 `_v1/` 留底、dist 覆盖定版 v2。**全片不重拼**（待全部工作台章完后统一拼）。主仓库点名提交 JOB-GP1 不推；四语 ch9 联络表(land+port)+4 REVIEW+决定账+PROGRESS 推 mh-jobs。**下趟**＝ch10（读-only v185 背景重录）/ OP-3·4·5 开场快剪（素材 3-8/7-0/7-1 已随 ch3/ch7 定版就位，不再阻塞），一趟一章；全部完后四语十一项重审+重拼全片→写 SUMMARY-GP1。**GP-1 未收官，勿据旧『收官』停工。**

# 第 34 趟（2026-10-13 Mac mini 无人值守）· ch9 增值服务章（读-only）v185 定版重录（review1 §一）
- **接手核对**：git status + 读齐 PROGRESS/loop-tail/RULING-b-review1/-c-rework/-d-funnel/-e-v185-live/-gp1/DECISIONS/CHOREOGRAPHY/storyboard/QUEUE。辨明 16:00 那趟「2 分钟即停」＝误判收官（loop-tail 实证），返工实为 trip29-33 做 ch1/3/7/8/5；trip33 列下趟 ch9 首。首行开工即改「返工进行中」，开工 verify **17/17 PASS**。
- **选题**：ch9 读-only，字幕 trip23 已改对，缺的只是 v185 背景。纯重录，无置态。
- **录制闭环**：`node rec.mjs --chapter 9 --orient {land,port} --lang {en,zh,ru,fr}`（引号位置参数避 LEDGER-3）8 变体 → `prod-ch --tag *-ch9` 合成 8 片覆盖 dist → `gp1-finish --stage contact --chapter 9` 四语联络表。
- **自验**：8 片 res/audio/no-@gmail/4 镜 box 全过；亲验 en-land 9-1/9-2 + ru-land 9-1 原始帧（¥0 无负数、三服务价、RU 真本地化）+ 四语联络表（字幕逐镜对账「是」）；§十一四语写 REVIEW-*-shots.md（ch9 v185 定版段）。
- **DB**：ch9 读-only，开工+收工 verify **17/17 PASS 0 FAIL**，零写库。
- **改了**（主仓库，点名 JOB-GP1，不推）：`REVIEW-{en,zh,ru,fr}-shots.md`(追加 ch9 v185 定版段)、`DECISIONS.md`(D-34-1)。shots-v1.json/captions-v1.json 未改（trip23 已 banked）；成片/voice 不入 git；ch9 v1 在 `_v1/`、dist 覆盖 v2；全片不重拼。四语 ch9 联络表+4 REVIEW+决定账+PROGRESS 推 mh-jobs。
- **下趟**：ch10 读-only v185 背景重录 / OP-3·4·5 开场快剪，一趟一章；全部完后十一项重审+重拼全片→写 SUMMARY-GP1。GP-1 未收官。

【上一趟（第33趟）首行存档】最后一趟：2026-10-13 第33趟 返工：**做了**＝ch5 材料退回章（两态·state 章）v185 四语横竖定版重录，落 review1 §三.3（5-2 字幕）+§三.4（5-4 真·审核中态）+§三.8（5-1 工作台）+§一（v185 背景）。**两态为何必需**：5-2 需退回态 `.reviewer-row-rejected`、5-4 需审核中态 `.badge-reviewing`，apply `st-pt03-reupload` 后 transcript 被产品 0104 supersede、退回行消失→单 rec pass 不可兼得（trip25 实证）。故**两态分录**：退回基线录 5-1/5-2/5-3，置态后单录 5-4，`prod-ch --tags` 按镜序拼成一章。**工具（jobs 工装·非产品码·rec 仍只读·DB 全走 db-run.sh）**：rec.mjs 加 `--only`/`--tagsuffix`、prod-ch.mjs 加多 tag 拼章、gp1-finish.mjs chapterShotDurs 合并 companion `b` 目录。**§三.4 真态（零改产品码·非前端伪造）**：录前 `st-pt03-reupload`（新建 transcript v2、uploaded_at 更晚、无新裁决）→ 产品自身 0104 supersede → 详情弹窗 transcript 槽真变 reviewing → 徽章真·本地化：zh「审核中」/ru「НА ПРОВЕРКЕ」/fr「EN EXAMEN」/en「REVIEWING」+ 矩阵「等待初步审核/Ожидает первичной проверки/En attente de la première vérification/Awaiting initial review」（四语 land 原始帧亲验，非 EN 回退、非伪造）。录后 `st-pt03-reupload-reset-cleanup` 删 v2 回退态。**§一**：5-1「Invested ¥0」无负数（缺陷1 销账）。8 片全 res OK+audio yes+no @gmail+4 镜 hl 全 resolve（passA 3+passB 1）。EN land 4 镜原始帧 + 四语 land 5-4 徽章帧 + 四语 land/port 联络表（帧取字幕中点）亲验；§十一对账四语写 REVIEW-*-shots.md（ch5 定版段）。时长 land en36.87/zh36.82/ru36.97/fr36.67·port en36.83/zh36.77/ru36.84/fr36.81s（4 镜）。开工+收工 verify **17/17 PASS 0 FAIL**，baseline 守住（scoped 复位，无全量 rebuild）。ch5 v1 在 `_v1/` 留底、dist 覆盖定版 v2。**全片不重拼**（待全部工作台章完后统一拼）。主仓库点名提交 JOB-GP1 不推；四语 ch5 联络表(land+port)+4 REVIEW+决定账+PROGRESS 推 mh-jobs。**下趟**＝下一含工作台章定版重录（ch9 9-2/9-3 已改·需 v185 背景重录 / ch10 读-only / OP-3·4·5 开场快剪，素材已不阻塞），一趟一章；全部完后四语十一项重审+重拼全片→写 SUMMARY-GP1。**GP-1 未收官，勿据旧『收官』停工。**

# 第 33 趟（2026-10-13 Mac mini 无人值守）· ch5 材料退回章（两态·state 章）v185 定版重录（review1 §三.3 + §三.4 + §三.8 + §一）
- **接手核对**：git status + 读齐 PROGRESS/loop-tail/RULING-b-review1/-c-rework/-d-funnel/-e-v185-live/DECISIONS/storyboard/QUEUE。trip32 ch8 已定版；下趟列 ch5 首。首行开工即改「返工进行中」，开工 verify **17/17 PASS**（#10 pt-03 退回态在）。
- **两态机制（见 D-33-1）**：退回基线录 5-1/5-2/5-3；apply `st-pt03-reupload` 录 5-4（产品 0104 supersede 真·回审核中）；`prod-ch --tags` 拼章。工具 rec.mjs `--only`/`--tagsuffix` + prod-ch 多 tag + gp1-finish chapterShotDurs 合并 companion。
- **录制闭环（每变体）**：verify 退回基线 → passA(`--only 5-1,5-2,5-3`) → apply reupload(自检 2/t/1) → passB(`--only 5-4 --tagsuffix b`) → reset(自检 1/1) → `prod-ch --tags`。8 变体全过。
- **自验**：EN land 4 镜原始帧 + 四语 land 5-4 徽章帧（真·本地化）+ 四语联络表；5-1 ¥0 无负数；§十一四语写 REVIEW-*-shots.md。
- **DB**：开工+收工 verify **17/17 PASS 0 FAIL**，往返幂等、零残留。
- **改了**（主仓库，点名 JOB-GP1，不推）：rec/rec.mjs、rec/prod-ch.mjs、rec/gp1-finish.mjs、REVIEW-{en,zh,ru,fr}-shots.md、DECISIONS.md。shots/captions 未改（trip24/25 已 banked）；成片/voice 不入 git；ch5 v1 在 _v1/、dist 覆盖定版 v2；全片不重拼。四语 ch5 联络表+4 REVIEW+决定账+PROGRESS 推 mh-jobs。
- **下趟**：ch9 / ch10 / OP-3·4·5，一趟一章；全部完后十一项重审+重拼全片→写 SUMMARY-GP1。GP-1 未收官。

【上一趟（第32趟）首行存档】
最后一趟：2026-10-13 第32趟 返工：**做了**＝ch8 名额/提额章（state 章）v185 四语横竖定版重录，落 review1 §三.7 + §一。**§三.7（8-1 横幅矛盾）**：基线有一张 pending quota_request（verify #13）→ 工作台顶恒显 amber「Quota raise pending: 10→30」，与 8-2/8-3「才去申请」矛盾。读产品源（partner v185 L14679-14757 `_qrApplyBanner`）定逻辑：pending 行→amber 横幅；否则看最新裁决行，decided_at 空→box 空。做法＝新建 `st-ch8-quota-off.sql` 单列可逆 UPDATE 把该行 `status='pending'→'approved'`（decided_at 保持 NULL）→ 横幅清空（8-1/8-2/8-3 无横幅），`referral_quota` 不动（仍 10，hero 数字不变）；录后 `st-ch8-quota-restore.sql` 还原 pending → verify #13 回基线。**8-1 字幕随 §11 改**：产品无常驻名额表（§三.1 已证），去横幅后 8-1 高亮 `.partner-stats-hero-card` 仅显「STUDENTS SUBMITTED 9」→ 字幕「Your quota is almost used up.」改述屏真有的数「You've submitted nine students.」（zh「你已提交九名学生。」/ru/fr 重译回译），四语重配音；「名额已满」语境由 8-2 弹窗标题「Referral quota reached · used 9/10」承接，8-2 不改。**8-4 改前端伪造为产品自身渲染（§8 先例）**：旧 8-4 改写 pending 卡造绿条（去横幅后无此卡）→ 改调产品自身 `_qrApplyBanner()` 喂样例已批数据，hl 改 `#qrPendingBanner`，渲染真·绿条——zh 真中文「提额申请已批准：配额已调整为 30 席」、en/ru/fr 走产品 LL 的 EN 回退（＝D-18-4 记录的真产品行为）；因 hero 卡不显名额数，8-4「now 30 seats」与屏上无名额数字冲突（§十 数字一致守住）。**§一**：8-1/8-4 hero「TOTAL PAYMENTS PROCESSED ¥0」无负数（缺陷1 销账）。登录态只读探针 `_probe-ch8-fns.mjs` 实证产品函数/let 变量 eval 可达 + 喂样例渲染真绿条。8 片全 res OK+audio yes+no @gmail+4 镜 hl 全 resolve。亲验：EN land 8-1（无横幅框 9）/8-4（产品绿条非伪造）原始帧 + 四语 land 联络表 + en-port 联络表（§11 四镜全「是」，写入 REVIEW-*-shots）。时长 land en30.32/zh28.31/ru30.80/fr31.89·port en30.07/zh28.26/ru30.80/fr31.68s。开工+收工 verify **17/17 PASS 0 FAIL**，baseline 守住（scoped 复位，无全量 rebuild）。ch8 v1 早在 _v1/ 留底、dist 覆盖 v2。**全片不重拼**（待全部工作台章完后统一拼）。主仓库点名提交 JOB-GP1 不推；四语 ch8 联络表(land+port)+4 REVIEW+决定账+PROGRESS 推 mh-jobs。**下趟**＝下一含工作台章定版重录（ch5 5-1 工作台+5-4 两态 / ch9 9-2·9-3 已改需 v185 背景重录 / ch10 读-only / OP-3·4·5 开场快剪），一趟一章；全部完后四语过十一项重审+重拼全片→写 SUMMARY-GP1。**GP-1 未收官，勿据旧『收官』停工。**

# 第 32 趟（2026-10-13 Mac mini 无人值守）· ch8 名额/提额章 v185 定版重录（review1 §三.7 + §一）
- **接手核对**：git status + 读齐 PROGRESS/loop-tail/RULING-b-review1/-c-rework/-d-funnel/-e-v185-live/-gp1/DECISIONS/storyboard/QUEUE。trip31 ch7 已定版；下趟列 ch8 首。首行开工即改「返工进行中」，开工 verify **17/17 PASS**。
- **取证（只读探针，不写库）**：`_probe-ch8-quota.sql`/`_probe-ch8-qrrow.sql`（基线 pending quota_request 全字段 + status check 约束）、`_probe-ch8-fns.mjs`（登录态·证产品 `_qrApplyBanner`/`_qrOpenRaise` eval 可达 + let 变量可赋值 + 喂样例渲染真绿条 + `#qrPendingBanner` 在）。读产品源定横幅逻辑。
- **改法**：见首行 + D-32-1。state：st-ch8-quota-off/restore（单列可逆 UPDATE，无 delete/reinsert/FK）。shots-v1.json 8-1 cap + 8-4 pre/hl 重写；captions-v1.json 8-1 四语；tts `--force-ids 8-1` 四语重配。
- **录制闭环**：verify 17/17 → st-ch8-quota-off → en-land 亲验 → 批量录 7 变体（带引号位置参数避 LEDGER-3）→ 合成 8 → st-ch8-quota-restore → 收工 verify 17/17。
- **自验**：8 片 res/audio/no-@gmail/hl 全过；亲验 EN land 8-1/8-4 原始帧 + 四语联络表；§十一对账四语写 REVIEW-*-shots.md（ch8 节）。
- **DB**：开工+收工 verify **17/17 PASS 0 FAIL**，零残留。
- **改了**（主仓库，点名 JOB-GP1，不推）：states/st-ch8-quota-off.sql(新)、states/st-ch8-quota-restore.sql(新)、rec/shots-v1.json(8-1/8-4)、captions-v1.json(8-1)、rec/_probe-ch8-*(3 新·只读)、REVIEW-{en,zh,ru,fr}-shots.md、DECISIONS.md。voice/8-1 四语重配、成片不入 git；ch8 v1 在 _v1/、dist 覆盖 v2。四语 ch8 联络表+4 REVIEW+决定账+PROGRESS 推 mh-jobs。
- **下趟**：ch5/ch9/ch10/OP-3·4·5，一趟一章；全部完后十一项重审+重拼全片→写 SUMMARY-GP1。GP-1 未收官。

【上一趟（第31趟）首行存档】最后一趟：2026-10-12 第31趟 返工：**做了**＝ch7 工作台章（state 章·最复杂章）v185 四语横竖定版重录，一并落 review1 §二.3 + §三.5 + §一。**§二.3（7-1 两段高亮）**：给 rec.mjs follow() 加 `hl2`（前半 dwell 框 hl、后半切 hl2），7-1 先框真揭晓校名条 `.admission-id-tag--unlocked`（🔓 Demo University·演示大学·Wuhan/武汉·SCH-1AD6C8）、再框下载钮 `.admission-doc-btn-letter`——完成 trip21 明文「待 ch7 一并做」的两段高亮；7-1 字幕/配音 trip21 已改，本趟只改高亮。亲验 en-land phase1(f00032)/phase2(f00037) 原始帧达标，8 录屏 7-1 hl+hl2 全 resolve。**§三.5（7-4 字幕对账）**：读源实证病根＝卡徽章 `s.status=r.stage||'pending'`(L7311) 读废弃列 students.stage（恒 NULL，与缺陷2/漏斗同根）→ 恒 pending、gate_open 覆盖成蓝「Documents approved·matching」，产品**从不在列表卡徽章真显 enrolled**（已知产品问题，trip28 已记、留 SUMMARY）；但卡**状态行** `.partner-student-issue`（源 cloudTl.completed）稳定真显「⏳ Admission complete」＝review1 §三.5 观察——走 §三.5 兜底，7-4 字幕由「Enrolled. Done.」改**与状态行逐字一致**：en「Admission complete.」/ zh「录取完成。」/ ru「Зачисление завершено.」/ fr「Admission terminée.」，四语重配音。亲验四语 7-4 真帧：产品**真本地化**渲染状态行、与字幕**逐字对账**（ru/fr 非英文回退）。未改产品码。**§一**：7-4 卡「Invested ¥0」无负数（v185，缺陷1 销账）。state 章安全闸：先空跑状态往返证复位可靠（dirty→reset→verify 17/17）；每片前 st-pt07-pay-cleanup（每片 7-0 真付 ¥0 写 letter_paid_at）+ 末 st-pt0708-reset-cleanup。8 片全 res OK+audio yes+no @gmail+5 镜 hl 全 resolve（7-1 含 hl2）。时长 land en44.66/zh44.00/ru43.29/fr43.60·port en43.29/zh43.24/ru43.23/fr43.52s。开工+收工 verify **17/17 PASS 0 FAIL**，baseline 守住（scoped 复位）。ch7 v1 早在 _v1/ 留底、dist 覆盖 v2。**全片不重拼**（待全部工作台章完后统一拼）。主仓库点名提交 JOB-GP1（b7a4ad4）不推；四语 ch7 联络表(land+port)+4 REVIEW+决定账+PROGRESS 推 mh-jobs。**下趟**＝下一含工作台章定版重录（ch8 §三.7 横幅 scoped 撤待审提额 / ch5 5-1+5-4 两态 / ch9 v185 背景重录 / ch10 / OP-3·4·5 开场快剪），一趟一章；全部完后四语过十一项重审+重拼全片→写 SUMMARY-GP1。**GP-1 未收官，勿据旧『收官』停工。**

# 第 31 趟（2026-10-12 Mac mini 无人值守）· ch7 工作台章定版重录 v185（review1 §二.3 + §三.5 + §一）
- **接手核对**：git status + 读齐 PROGRESS/loop-tail/RULING-b-review1/-c-rework/-d-funnel/-e-v185-live/DECISIONS/storyboard/QUEUE。trip30 ch3 已定版，下趟＝ch7。开工即改首行「返工进行中」，开工 verify **17/17 PASS**。
- **选题**：ch7 压着三处未结 review1 项——§二.3（7-1 两段高亮，trip21 明文待 ch7）+ §三.5（7-4 字幕 undone）+ §一（7-4 漏斗 v185）。
- **取证（只读探针，不写库）**：`_probe-ch7-dom.mjs`（揭晓校名条/下载钮选择器）、`_probe-ch7-74-stable.mjs`（7-4 卡稳定态真显 ⏳ Admission complete）、`_probe-ch7-74-txt/langs.mjs`（四语卡文本）。读 partner v185 源定病根（L7311 s.status 读 students.stage 恒 NULL；L6641 gate_open 覆盖）。
- **改法**：见首行 + D-31-1。§二.3 rec.mjs +hl2；§三.5 字幕四语改 + 重配音（未改产品码，走兜底）。
- **录制闭环**：安全闸空跑往返 → st-pt08-jw202(一次) + 每片前 st-pt07-pay-cleanup → 录 8 → 末 st-pt0708-reset-cleanup → 收工 verify 17/17。
- **自验**：8 片 res/audio/no-@gmail/hl(含 hl2) 全过；亲验 en-land 全 5 镜 + zh/ru/fr 联络表 + ru/fr 7-4 真帧（四语状态行逐字对账）；§十一对账四语写 REVIEW-*-shots.md。
- **DB**：开工+收工 verify **17/17 PASS 0 FAIL**，零残留。
- **改了**（主仓库，点名 JOB-GP1 b7a4ad4，不推）：rec/rec.mjs(+hl2)、rec/shots-v1.json(7-1 hl/hl2、7-4 cap)、captions-v1.json(7-4 四语)、rec/_probe-ch7-*.mjs(4 新)、REVIEW-{en,zh,ru,fr}-shots.md、DECISIONS.md。voice/7-4 四语重配、成片不入 git；ch7 v1 在 _v1/、dist 覆盖 v2。四语 ch7 联络表+4 REVIEW+决定账+PROGRESS 推 mh-jobs。
- **留业主（已知产品问题，入 SUMMARY）**：中介端推荐生列表卡**徽章**对已入学生恒显蓝「Documents approved · matching」——根因 `s.status = r.stage || 'pending'`（partner v185 L7311）读废弃列 students.stage（全库恒 NULL，与缺陷2 漏斗同根）；真实中介对已付/已入学生也看到此矛盾徽章。卡状态行（cloudTl.completed）另算、真显「Admission complete」正确。本趟未改产品码（review1 §三.5 兜底不改码）。
- **下趟**：ch8/ch5/ch9/ch10/OP-3·4·5，一趟一章；全部完后十一项重审+重拼全片→写 SUMMARY-GP1。GP-1 未收官。

【上一趟（第30趟）首行存档】最后一趟：2026-10-12 第30趟 返工：**做了**＝ch3 工作台章（state 章）v185 底座四语横竖定版重录，一并落 review1 §三.8（3-1/3-8 节奏）+§四（草稿残留复核）+§一（工作台 v185）。**§三.8 节奏＝录制层实现「后期剪掉等待的那几秒」**：rec.mjs 加 `preOff` 开关（把导航/加载/真提交放镜外 offCamera 跑、不计入字幕窗口帧，等结果落定才开录）。3-1 旧病＝点完按钮后镜尾 openWizard 切走、高亮环落向导空白处→删 3-1 openWizard、移到 3-2 offCamera pre（3-1 全窗口框按钮·亲验尾帧仍框按钮；3-2 开录即向导 step1 高亮 Semester）。3-8 旧病「app_no 落段尾」（trip12 记）→真 submit+等 app_no 全放 offCamera，开录 app_no 已在画面（亲验首帧 t0 即显 MH-xxxxxx）。**§四**＝每变体前后跑 st-ch3-cleanup 还原 pt-01 基线草稿（Ayesha Malik/step2）+真 submit 后即 st-ch3-mark-test 标 is_test；8 变体=8 次真 submit（cleanup-before-each 保配额恒 9→10 成功），verify #17 开工+收工 PASS。**§一**＝3-9 卡「Invested ¥0」无负数（缺陷1 销账）。8 片全 res OK+audio yes+no @gmail+9镜×8 hl 全 resolve。时长 land/port：EN60.23/60.25·ZH70.52/70.46·RU70.69/70.55·FR69.59/69.51s。亲验 en-land(3-1尾/3-2/3-8/3-9)+ru-land(3-5/3-8/3-9)原始帧：§三.8 三镜达标、¥0 无负数、AI 预检琥珀条四语本地化(产品渲染)、演示生 Demo Aisha 无真 PII、护照 DE1234567 样号、邮箱掩码、无 beta、页头平台 WhatsApp/Email 不遮。ch3 开工+收工 verify **17/17 PASS 0 FAIL**，baseline 守住（scoped 复位，无全量 rebuild）。v1 成片在 _v1/ 留底、dist 覆盖 v2。**全片 bookend/film/trailer 本趟不重拼**（待全部工作台章完后统一拼）。主仓库点名提交 JOB-GP1 不推；四语 ch3 联络表(land+port)+4 REVIEW+决定账+PROGRESS 推 mh-jobs。**下趟**＝下一含工作台章定版重录（ch7 7-4/ch8 横幅/ch5 5-1·5-4 两态/ch10/OP-3·4·5 快剪），一趟一章；全部完后四语过十一项重审+重拼全片→写 SUMMARY-GP1。**GP-1 未收官，勿据旧『收官』停工。**

---
# 第30趟详记：
## 第 30 趟（2026-10-12 Mac mini 无人值守）· ch3 工作台章定版重录 v185（review1 §三.8 + §四 + §一）
- **接手核对**：git status + 读齐 PROGRESS/loop-tail/RULING-b-review1/-c-rework/-d/-e/DECISIONS/storyboard/QUEUE/CHOREOGRAPHY。trip29 ch1 已定版，下趟＝下一含工作台章（ch3）。开工即改首行「返工进行中」，开工 verify **17/17 PASS**。
- **选题**：按 trip29「下趟」与 review1 §八 挑 ch3（state 章，含 §三.8 节奏 3-1/3-8 + §四 草稿残留 + §一 工作台 v185 背景）。review1 未标 ch3 任何字幕缺陷→字幕/配音一字不改，纯节奏/底座/残留返工。
- **§三.8 做法（rec.mjs +preOff，见 D-30-1）**：先录 en-land 测量——timeline 实证 3-1 旧 openWizard 致尾帧高亮环落向导空白（亲验），3-8 preOff 后 app_no 窗口 t0 即在画面。据实改 3-1（去 openWizard）/3-2（移入 offCamera pre）/3-8（preOff）后重录 en-land 复验达标，再批量录其余 7 变体。
- **录制闭环**：每变体 st-ch3-cleanup（清+还原草稿）→ 真 submit 录 → st-ch3-mark-test（标 is_test）；全 8 变体后最终 cleanup。cleanup-before-each 保每次配额 9→10 submit 成功出新 app_no。
- **自验**：8 片 res/audio/no-@gmail/hl 全过；亲验 en-land+ru-land 关键原始帧（§三.8 达标/¥0 无负数/AI 琥珀四语/demo 无真 PII/无 beta/页头不遮）；§十一对账四语写入 REVIEW-*-shots.md。
- **DB**：ch3 state 章，开工+收工 verify **17/17 PASS 0 FAIL**（含往返+§四#17），零残留。
- **踩坑**：node 从仓库根跑 require 相对路径失败（cwd 复位）——改 cd rec 目录或绝对路径。批量录用带引号位置参数 `run(){...--lang "$1" --orient "$2"}`（避 LEDGER-3 $combo 分词）。
- **改了**（主仓库，点名 JOB-GP1，不推）：rec/rec.mjs、rec/shots-v1.json、REVIEW-{en,zh,ru,fr}-shots.md、DECISIONS.md。成片/voice 不入 git；v1 在 _v1/、dist 覆盖 v2；全片不重拼。四语 ch3 联络表+4 REVIEW+决定账+PROGRESS 推 mh-jobs。
- **下趟**：ch7/ch8/ch5/ch10/OP-3·4·5，一趟一章；全部完后十一项重审+重拼全片→写 SUMMARY-GP1。GP-1 未收官。

---
# 上一趟（第29趟）首行存档：
最后一趟：2026-10-12 23:20 第29趟 返工：**做了**＝接 trip28（ch2 定版 v185 已出），本趟做 ch1 工作台章定版重录（review1 §一）。ch1 读-only（1~7 镜注册/入驻 UI 产品自身渲染、1-8 已登录 hub），review1 未标 ch1 任何字幕缺陷→字幕一字不改，纯 v185 底座整章四语横竖定版重录。病灶＝1-8 背景 hero，v184 缓存帧显 `TOTAL PAYMENTS PROCESSED ¥-9,000`（负数，缺陷1；亲看 v184 ch1-contact-land-en 实证）。v185 底座（含 trip28 offCamera 等待）重录后 1-8 自动显 **¥0**。四语 land 1-8 原始帧逐张亲验：四语全 ¥0（负数销账）、STUDENTS SUBMITTED 9、APPROVED/одобрено/approuvé/已通过 徽章橙框、无负数、无 beta、注册号画面 no @gmail+邀请码打码+SPECIMEN+无真 PII、页头平台 WhatsApp/Email 不遮。8 片全 res OK+audio yes+no @gmail+8 镜 hl 全 resolve。§十一对账四语写入 REVIEW-*-shots.md。时长 EN49.43·ZH49.45·RU51.22·FR49.62s(land)。ch1 全程只读，开工+收工 verify 17/17 PASS 0 FAIL。踩坑：批量录 `$combo` 未分词污染 TAG（LEDGER-3 复犯），TaskStop 杀后台改带引号位置参数函数重录。v1 成片在 _v1/ 留底，覆盖 dist 为 v2。**全片 bookend/film/trailer 本趟不重拼**（待全部工作台章完后统一拼）。主仓库点名提交 JOB-GP1 不推；四语 ch1 联络表(land+port)+4 REVIEW+决定账+PROGRESS 推 mh-jobs。**下趟**＝下一含工作台章定版重录（ch3 3-1·3-8 节奏+§四草稿残留/ch7 7-4/ch8 横幅/ch5 5-1·5-4 两态/ch10/OP-3·4·5 快剪），一趟一章；全部完后四语过十一项重审+重拼全片→写 SUMMARY-GP1。**GP-1 未收官，勿据旧『收官』停工。**

---
# 第29趟详记：
## 第 29 趟（2026-10-12 Mac mini 无人值守）· ch1 工作台章定版重录 v185（review1 §一）
- **接手核对**：git status + 读齐 PROGRESS/loop-tail/RULING-b-review1/-c-rework/-d-funnel/-e/DECISIONS/storyboard。trip28 ch2 已定版、缺陷2 已 v185 上线。首行开工即改「返工进行中」（16:00 误读旧收官教训不复犯）。开工 verify **17/17 PASS**。
- **选题**：挑 ch1——读-only、review1 §一 点名 1-8 背景负数、无 ch1 字幕缺陷→纯 v185 重录。亲看 v184 `ch1-contact-land-en.png` 实证 1-8 hero 显 ¥-9,000。
- **做法**：rec.mjs（trip28 已切 v185+offCamera 等待）× 4 语 × 2 画幅＝8 片 → prod-ch 合成 → gp1-finish contact 联络表（帧取字幕中点）。字幕/配音/shots/captions 一字未改。
- **自验**：四语 land 1-8 原始帧亲验 ¥0（负数全销账）+ 9 submitted + 徽章橙框 + 无负数/beta + 注册号脱敏；§十一对账四语 REVIEW-*-shots.md。8 片全 res OK+audio yes+no @gmail。
- **DB**：ch1 只读，开工+收工 verify **17/17 PASS 0 FAIL**，零置态/零写库。
- **踩坑**：`for combo in "en port"` + `set -- $combo` 在 Bash 工具未分词 → TAG 污染 `en port---lang-ch1`、compose 崩（LEDGER-3 trip23 同学费复犯）；TaskStop 杀后台、改 `run(){...--orient "$2" --lang "$1"}` 带引号位置参数重录，全 8 片正常。
- **改了**（主仓库，点名 JOB-GP1，不推）：REVIEW-{en,zh,ru,fr}-shots.md、DECISIONS.md（rec/out/* gitignore 不入库）。成片/voice 不入 git；四语 ch1 联络表+4 REVIEW+决定账+PROGRESS 推 mh-jobs。v1 在 _v1/ 留底，dist 覆盖 v2；全片不重拼。
- **下趟**：下一含工作台章（ch3/ch7/ch8/ch5/ch10/OP-3·4·5）定版重录，一趟一章；全部完后十一项重审+重拼全片→写 SUMMARY-GP1。GP-1 未收官。

---
# 上一趟（第28趟）首行存档：
最后一趟：2026-10-12 22:20 第28趟 返工：**做了**＝v185 上线后(RULING-20261012e)起做被缺陷2 卡住的定版重录第一章 ch2。①录制底座 rec.mjs 切 v184→v185(线上同版)+加 offCamera 等待(offers≥5 且 gate_open≥6, 因漏斗/「匹配中」标签靠异步 RPC 加载, 录早了定格错态 9/0/0/0 与「已提交·等待审核」)——惠及全部后续工作台章。②review1 §三.1(2-2)：只读实证工作台**无「名额已用/剩余」显示**→改高亮并描述屏上真有的录取漏斗(v185 真值 9→3→2→1·5 offer·人均0.6)。③§三.2(2-4)：实证 `.partner-student-status-approved` class **永不存在**(stage 列恒 NULL→class 恒 pending；真「材料已通过·匹配中」是 gate_open 覆盖标签, 6 张)→hl 改按真标签文本逐语言高亮、字幕改述真档。2-2/2-4 四语字幕+配音重做(shots-v1/captions-v1 三源同步, en/zh 逐字一致)。四语横竖重录 v185(8 片, 全 res OK+audio yes, no @gmail, hl 全 resolve)→合成→联络表(帧取字幕中点)。四语 land 联络表逐张亲验:漏斗无负数全0、2-4 框真「匹配中」、¥0 保留(§一.3)、无 beta、演示生无真 PII。§十一对账四语写入 REVIEW-*-shots.md。时长 EN27.66·ZH29.34·RU28.23·FR27.68s(land)。ch2 全程只读, 开工+收工 verify 17/17 PASS。v1 成片在 _v1/ 留底。**全片 bookend/film/trailer 本趟不重拼**(待全部工作台章完后统一拼)。留给业主产品问题2 条(工作台无名额显示 / 卡徽章色恒 pending 蓝)入账待写 SUMMARY。主仓库点名提交 JOB-GP1 不推；联络表+4 REVIEW+决定账+PROGRESS 推 mh-jobs。**下趟**＝下一含工作台章定版重录(ch1 1-8/ch3 3-1·3-8 节奏/ch5 5-1/ch7 7-4/ch8 横幅/ch10)或 OP-3/4/5 开场快剪(素材现已不阻塞)，一趟一章；全部完后四语过十一项重审+重拼全片→写 SUMMARY-GP1。**GP-1 未收官，勿据旧『收官』停工。**
---
# 第28趟详记：
## 第 28 趟（2026-10-12 Mac mini 无人值守）· 录制底座切 v185 + ch2 工作台章定版重录
- **接手核对**：git status 见 NEEDS_OWNER_DECISION.md 被删 + 新出 RULING-20261012d-funnel.md/-e-v185-live.md + 原请示单改名 -resolved-20261012-213841.md → 缺陷2 已裁(选A)、v185 已由业主卡1380 推送上线(线上 0eb0c78)、缺陷2 解除阻塞。loop-tail 查明 16:00 那趟两分钟即停＝误读旧「收官」(返工授权当时刚发未读)——本趟首行开工即改「返工进行中」、收工改完整「做了+下趟」，不复犯。开工 verify **17/17 PASS**。
- **录制底座切 v185**（rec.mjs，jobs 工装非产品码）：FILE v184→v185；加 offer+gate offCamera 等待（见 D-28-1）。
- **选题/范围**：按 RULING-20261012d §三.3 / -e「带工作台的章四语横竖定版重录」，挑第一章 ch2（工作台整屏、含 review1 §三.1/.2 两处字幕返工、只读不写库）。
- **§三.1/.2 两处字幕返工 + 四语重录重出**：详见 DECISIONS D-28-1。只读实证用 `_probe-ch2-dom.mjs` / `_probe-ch2-sel.mjs`（均新建、只读）。
- **自验**：四语 land 联络表逐张亲眼复验（2-2 漏斗 9/3/2/1 无负数全0、2-4 框真「匹配中」标签、字幕↔屏文一致、¥0 保留、无 beta、演示生无真 PII、页头平台 WhatsApp/Email 不遮）；§十一对账四语写入 REVIEW-*-shots.md；8 片真帧 hl 全 resolve、全片 no @gmail。
- **DB**：ch2 只读，收工 verify **17/17 PASS 0 FAIL**。零置态/零写库。
- **改了**（主仓库，不推）：rec/rec.mjs、rec/shots-v1.json、captions-v1.json、rec/tts-gp1.mjs、rec/_probe-ch2-dom.mjs(新)、rec/_probe-ch2-sel.mjs(新)、REVIEW-{en,zh,ru,fr}-shots.md、DECISIONS.md。成片/voice 不入 git（ch2 v1 在 _v1/ 留底，本趟覆盖 dist v2）；四语 ch2 联络表 + 四 REVIEW + 决定账 + PROGRESS 推 mh-jobs。
- **下趟**：下一含工作台章定版重录或 OP-3/4/5 快剪，一趟一章；全部完后四语十一项重审 + 重拼全片 → 写 SUMMARY-GP1。GP-1 未收官。

---
# 上一趟（第27趟）首行存档：
最后一趟：2026-10-12 20:18 第27趟 返工：**做了**＝缺陷2 业主已裁(RULING-20261012d 选 A·先修产品再录)→ 修中介端工作台「录取漏斗/人均 offer」对云端学生算错，partner v184→v185。根因：_getPartnerStats 云端分支读废弃列 students.stage(全库零写入恒 NULL)→漏斗全 0、offer 恒 0、与学生卡矛盾。改按卡面同口径数页面已加载的真 offer 数据 stu._offers(get_agent_student_offers RPC):offer 份数=行数/拿通知书=letter_uploaded_at/已付=letter_paid_at/录取完成=completed_at；avg 零生兜底 0.0；版本串+index.html 四件套齐 v185。全部 diff 仅 4 处逻辑块，TOTAL PAYMENTS PROCESSED 不动(§一.3)。闸全过：①探针算期望 9→3→2→1·offer5·人均0.6；②v185 真登录 guide_partner 四语截图漏斗全 9/3/2/1·5·0.6(shots/GP1/funnel/)；③回归 diff仅4块+四语数字遮罩后文本逐字相同+唯一 console.error 是 v184 同存 file:// 产物+0生态无NaN人均0.0。零 DB 写入，开工+收工 verify 17/17 PASS 0 FAIL。主仓库点名提交(JOB-GP1-PF 开头)**不推**；写 jobs/JOB-GP1/NEEDS_OWNER_DECISION.md「v185 漏斗修复已就绪，请 Claude 审核后由业主推送上线」复制推 mh-jobs(停下情形④)。**本趟结束等审**；v185 上线、线上确认后循环重开。**下趟**＝做 review1 被缺陷2 卡住的定版重录(ch1/2/3/5/7/8/10 带工作台的镜四语横竖、2-2/2-4/7-4/ch8 横幅/节奏 3-1/3-8/5-1、OP-3/4/5 开场快剪)，完后四语过十一项重审写 SUMMARY-GP1；**v185 上线前不录定版**。GP-1 未收官。
---
# 第27趟详记：
## 第 27 趟（2026-10-12 Mac mini 无人值守）· 缺陷2 业主选 A → 修中介端漏斗产品码 v185
- **接手核对**：git status 见 NEEDS_OWNER_DECISION.md 被删 + 新出 RULING-20261012d-funnel.md(20:00) + 原请示单改名 -resolved-20261012-200057.md → 业主已对缺陷2 裁决(选 A:先修产品再录)，缺陷2 解除阻塞，循环不停于缺陷2。开工 verify **17/17 PASS**。首行即改「返工进行中」(trip26 误停教训不复犯)。
- **授权范围(裁决 §一)**：只改 partner v184→v185、只改工作台录取漏斗/人均 offer 对云端学生算法；TOTAL PAYMENTS PROCESSED 与 Invested on this student 不动(§一.3)；不改其它四端与首页。
- **病根复核**：_getPartnerStats 云端分支(v184 L6074-79) `st=stu.status||stu.stage` 读废弃列 students.stage(云端生恒 NULL，真实 stage 现算在 student_global_stage())且 return 前不计 offer/付款 → 漏斗全 0、offer 恒 0。
- **改法(裁决 §一.4 路径 a=只改前端，第一条即行)**：学生卡已把真 offer 加载进 stu._offers(get_agent_student_offers RPC，v184 L7312-19)。改按卡面同口径数：offer 份数=行数/gotLetter=任一 letter_uploaded_at/paid=任一 letter_paid_at/enrolled=任一 completed_at(卡面 Enrollment 第4步同字段 L5234)。avgOffersPerStudent 零生兜底 '0'→'0.0'(闸3)。版本串 [VER]+MH_PORTAL_VER=185；index.html 4 处重定向→v185。**diff 仅这 4 处逻辑块**。详见 DECISIONS D-27-1。
- **闸(裁决二，全过)**：①`_probe-rework-stats.sql` 只读算期望 9→3→2→1·offer5·人均0.6(与裁决估计一致)；②`_probe-funnel-v185.mjs` 真登录 guide_partner 四语(EN/ZH/RU/FR)截图漏斗全 9/3/2/1·5·0.6(踩坑:切 ru/fr 会异步取词典包并重载推荐生瞬时清 _offers，加 per-lang 轮询 offers 回 5 再读)；③回归:diff 仅 4 块、四语面板数字遮罩后文本逐字相同(funnelLabels 全 identical)、唯一 console.error 是 v184 同存 file:// 产物(非本次引入)、`_probe-funnel-zero.mjs` 0 生态实测无 NaN·人均0.0·面板空串。前后截图 shots/GP1/funnel/ (v184:9/0/0/0·0·0.0 ↔ v185:9/3/2/1·5·0.6)。
- **DB**：全程零写入；开工+收工 verify **17/17 PASS 0 FAIL**。
- **改了**（主仓库，点名提交 JOB-GP1-PF，**不推**）：partner-portal/maxhouse-partner-portal-v185.html(新)、partner-portal/index.html、jobs/JOB-GP1/{NEEDS_OWNER_DECISION.md 新内容, NEEDS_OWNER_DECISION-resolved-20261012-200057.md, RULING-20261012d-funnel.md, rec/_probe-funnel-v185.mjs, rec/_probe-funnel-zero.mjs, DECISIONS.md}。截图 shots/GP1/funnel/ + 回执 JOB-GP1-PF.md + NEEDS_OWNER_DECISION 副本 + 决定账推 mh-jobs。
- **停下**：写 NEEDS_OWNER_DECISION(停下情形④，需推主仓库)等 Claude 审 + 业主用卡推送上线。本趟结束。

---
# 第26趟详记：
## 第 26 趟（2026-10-12 Mac mini 无人值守）· 返工 §五 开场快剪 OP-2 四语横竖
- **接手核对**：读齐 PROGRESS/loop-tail/RULING-20261012b-review1/-c-rework/-gp1/DECISIONS/QUEUE。loop-tail 查明 16:00 那趟两分钟即停＝误读旧「收官」（返工授权当时刚发未读）——本趟首行开工即改「返工进行中」、收工改完整「做了+下趟」，不复犯。开工 verify **17/17 PASS**。
- **选题/范围裁决**：按 trip25「下趟」与 review1 §八 挑 §五 开场快剪。只做 OP-2（6-1/6-2 两份盲 offer，不受缺陷2 阻塞）；OP-3/4/5（3-8/7-0/7-1 工作台/漏斗素材）阻塞留后。详见 DECISIONS D-26-1。
- **实现**（零改产品码/迁移）：keypointStrip 叠层 + buildQuickCut（card 2.5s + ch6 原始帧 b-roll 静音叠标题条 + 全程配音，卡总时长不变）。见 D-26-1。
- **重出/自验**：四语 bookend→film→trailer；全片/速览时长见首行；8+8 真 Chrome 播放 pageErr0；四语 land+port card/b-roll 中帧逐张亲验（双盲守住、无 beta、demo 无真 PII、标题条一字一致）；montage 四语存 mh-jobs。
- **DB**：纯成片工装，零写入/零置态，开工+收工 verify 17/17 PASS 0 FAIL。
- **改了**（主仓库，不推）：rec/gp1-overlays.mjs、rec/gp1-finish.mjs、REVIEW-{en,zh,ru,fr}-shots.md、DECISIONS.md。成片/voice 不入 git；OP-2 快剪 montage 四语+四 REVIEW+PROGRESS+决定账推 mh-jobs。dist OP/full/trailer 覆盖为含快剪 v2（v1 早在 _v1/ 留底）。
- **下趟**：不受缺陷2 阻塞部分全做完 → 写 NEEDS_OWNER_DECISION（缺陷2）停下、复制推 mh-jobs。GP-1 未收官。

---
# 第25趟详记：
## 第 25 趟（2026-10-12 Mac mini 无人值守）· 返工 §三.4 ch5 5-4「回到审核中」真态化
- **接手核对**：读齐 PROGRESS/loop-tail/RULING-b-review1/-c-rework/-gp1/DECISIONS/QUEUE。loop-tail 查明 16:00 那趟两分钟即停＝误读旧「收官」（返工授权当时刚发未读）——本趟首行开工即改「返工进行中」、收工改完整「做了+下趟」。开工 verify **17/17 PASS**。
- **选题**：按 trip23/24「下趟」与 review1 §八顺序挑 §三.4（5-4，详情弹窗、不含工作台漏斗、不受缺陷2 阻塞）。详见 DECISIONS D-25-1。
- **真态机制（亲读 partner v184 源+迁移，零改产品码）**：徽章 `badge-${slot.status}`，slot.status 由 `get_partner_student_doc_statuses` verdict 定；该 RPC（0104 supersede，0207 未重定义＝现网最新）对存在更晚同类件的 rejected 裁决予以取代。给 pt-03 真·新建更正版 transcript 即令 transcript 从 rejected 真变 reviewing。
- **可靠置态/复位（新建两脚本）+ 往返实证**：见上首行与 D-25-1。verify 17/17 往返守住、收工 DB clean。
- **shot 5-4 改**：去 setInterval 伪造→高亮真 `.badge-reviewing`、expect/forbid 强制真态、_state 标注、pre 开弹窗。字幕配音不改。
- **帧捕获延后**：两态不可单 pass 兼得 + ch5 过渡版，5-4 帧随 ch5 定版重录（缺陷2 裁后）两态录制一并做。本趟落「证真态机制+改 shot+可靠置态/复位」。
- **改了**（主仓库，不推）：states/st-pt03-reupload.sql(新)、states/st-pt03-reupload-reset-cleanup.sql(新)、rec/_probe-pt03-docs.sql(新·只读)、rec/_probe-pt03-review.mjs(新·只读登录探针)、rec/shots-v1.json(5-4)、rec/CHOREOGRAPHY.md、REVIEW-en-shots.md、REVIEW-zh-shots.md、DECISIONS.md。零成片改动。回执/对账/决定账推 mh-jobs。

---
# 上一趟（第24趟）首行存档：
最后一趟：2026-10-12 18:29 第24趟 返工：**做了**＝§三.3 ch5 5-2 EN 字幕返工（review1 §三.3）。旧 EN「The reason is written in English…」声称画面有英文退回理由，但退回详情只渲染「Modification requested」裁决芯片、无自由文本（ZH/RU/FR 已在 D-16-5 改述真实画面，EN 当初以"英文芯片自洽"未改；review1 §三.3 明令照改）。EN 改为「The transcript was returned — the Maxhouse review team requested a change.」与三语对齐。缓存帧重烧（详情弹窗帧、不含漏斗、不碰 DB）：改 shots-v1.json capEN[5-2]+captions-v1.json en[5-2]→重配 EN 5-2 配音（3.3→4.4s，仍在 6.51s 视窗内不越界）→prod-ch 缓存帧重合成 EN ch5 横竖（32.02/32.09s）。抽段中帧横竖亲验：高亮框 "Maxhouse review team·Modification requested" 行、字幕不溢出、no @gmail、演示生 Islam Rahim 无真 PII。联络表 ch5-contact-{land,port}-en.png 重出。开工+收工 verify 17/17 PASS 0 FAIL（零 DB 写入）。**⚠ ch5 过渡版**：5-1 工作台 hero 缓存帧仍显旧 ¥-9,000（缺陷1 数据层已修=¥0，但缓存帧录于修前）+缺陷2 全0漏斗（产品bug待裁），ch5 最终版待缺陷2 裁决后对已修数据重录全章。**下趟**＝§三.4（5-4 置态真上传更正件→审核中再框，需新建 pt-03 scoped 置态+可靠 reset，专趟）或 §五 OP-2(6-1/6-2) 开场快剪。仍受缺陷2阻塞（含工作台漏斗）：§三.1/.2/.5/.7/.8+ch1/2/3/7/8/10 工作台帧+ch5 5-1；最终缺陷2 NEEDS_OWNER_DECISION 待后续。**GP-1 未收官，勿据旧『收官』停工。**

---
# 第24趟详记：
## 第 24 趟（2026-10-12 Mac mini 无人值守）· 返工 §三.3 ch5 5-2 EN 字幕（缓存帧重烧）
- **接手核对**：读齐 PROGRESS/loop-tail/RULING-20261012b-review1/-c-rework/-gp1/DECISIONS。loop-tail 查明「上趟两分钟结束」＝16:00 那趟误读旧『收官』即停（返工授权 RULING-c 当时刚发未读到）——本趟首行开工即改『返工进行中』、收工改完整『做了+下趟』，不复犯。开工 verify **17/17 PASS**（baseline 守住）。
- **选题**：按 trip23「下趟」与 review1 §八 顺序，挑 §三 余下不受缺陷2阻塞镜中最安全的 §三.3（5-2，纯字幕/配音、不碰 DB）。§三.4（5-4 真上传，需新建置态+可靠 reset）trip23 已标「建议专趟做」→留下趟。
- **实证现状**：5-2 的 zh/ru/fr 已在 D-16-5 改述真实画面并重配音、RU/FR ch5 在 trip18/19 已用新字幕录过；唯 EN capEN 仍是旧的"英文退回理由"错述。故 §三.3 ＝只补 EN。
- **缓存帧重烧（见 D-24-1）**：改 shots-v1.json(capEN+action)+captions-v1.json(en)→mv 旧 5-2.m4a 后 tts 仅重配 5-2（EN 母版其余音频不动）→新配音 4.85s<5-2 视窗 6.51s，不越界进 5-3→prod-ch 缓存帧重合成 EN ch5 横竖。新时长 land 32.02s/port 32.09s。
- **亲验**：5-2 段中帧横竖均——高亮 .reviewer-row-rejected 框 "⚠ Maxhouse review team · Modification requested"（材料 Academic transcript · REJECTED），字幕↔屏上芯片同指；no @gmail、无真 PII。REVIEW-en-shots.md 追加 ch5 §三.3 段（§十一对账）。
- **DB**：全程只读，收工 verify **17/17 PASS 0 FAIL**。零置态/零写库。
- **⚠ ch5 过渡版记账**：只 banked 5-2；5-1（工作台 hero，缺陷1缓存帧¥-9,000+缺陷2全0漏斗）仍阻塞，ch5 最终版待缺陷2 NEEDS_OWNER_DECISION 裁后重录全章。
- **改了**（主仓库，不推）：rec/shots-v1.json、captions-v1.json、REVIEW-en-shots.md、DECISIONS.md。成片/voice/durations 不入 git；EN ch5 联络表推 mh-jobs。第一版 ch5 EN 成片早在 _v1/ 留底，本趟覆盖 dist 为过渡版。

---
# 上一趟（第23趟）首行存档：
最后一趟：2026-10-12 18:20 第23趟 返工：**做了**＝§三.6 ch9「增值服务名」四语重出。根因＝增值服务区(PREMIUM SERVICES)只在推荐生列表卡渲染、不在详情弹窗(探针实证#studentDetailModal内0个.partner-premium-block)，旧CONTEXT开弹窗遮住列表→高亮回退弹窗后首卡行→9-2/9-3框错行且不在视口；改rec.mjs CONTEXT[9]不开弹窗、滚首卡增值服务区、9-2 hl→nth-of-type(2)Audit Service¥1,500行/9-3→nth-of-type(3)Human-assisted Search¥600行。9-2/9-3字幕按产品vapay真名真说明四语重写(9-2解除2offer上限+优先推荐位30天/9-3 Maxhouse顾问定制学校清单)+重配音，横竖四语重录重合成(en22.8/zh23.8/ru26.4/fr24.3s)+联络表。逐张亲眼复验(en/zh/ru/fr land全+ru-port 9-3全分辨率+原始帧)：各镜框对应真行不越界、字幕↔行同指、no @gmail、无真PII。新建REVIEW-{en,zh,ru,fr}-shots.md(§十一对账)。ch9只读、verify 17/17全程守住。踩坑：①zsh未对$combo分词致乱TAG重录②ugrep `|grep -E "->|res="`管道SIGPIPE杀prod-ch致mp4没更新→去管道重合成(LEDGER-3)。**下趟**＝§三余下不受缺陷2阻塞镜：ch5 §三.3(5-2缓存帧重烧字幕四语，不碰DB)或§三.4(5-4置态真上传更正件→审核中再框，需可靠reset)；§五OP-2(6-1/6-2)可做。仍受缺陷2阻塞的工作台漏斗章(§三.1/.2/.5/.7/.8+ch1/2/3/7/8/10工作台帧)定版重出+最终缺陷2 NEEDS_OWNER_DECISION待后续。**GP-1 未收官，勿据旧『收官』停工。**

## 第 23 趟（2026-10-12 Mac mini 无人值守）· 返工 §三.6 ch9 增值服务名四语重出 + 根因修复
- **接手核对**：读齐 PROGRESS/loop-tail/RULING-20261012b-review1/-c-rework/DECISIONS。上一趟（16:00）教训＝误读旧「收官」即停——本趟首行已改「返工进行中」不复犯。开工 verify **17/17 PASS**（ch9 只读，baseline 守住）。
- **只读取证产品真名**（review1 §三.6「读 i18n 与界面文字」，partner v184）：Audit Service ¥1,500（解除基础版 2offer 上限+优先推荐位+30天服务期）/ Human-assisted Search ¥600（Maxhouse 顾问定制专属学校清单）/ Exposure boost 从¥4,500（9-4 本就对，保留）。旧 9-2「unlimited unlocks」/9-3「concierge」皆非产品真名→按真名重写。
- **根因修复（D-23-1）**：增值服务区 `_v107renderPremiumBlock` 在 `renderPartnerStudentsSection` 内渲染，**只在推荐生列表卡、不在详情弹窗**（探针实证 #studentDetailModal 内 0 个 .partner-premium-block；全页 9 个 block=9 张卡各一）。旧 CONTEXT 开详情弹窗→弹窗遮列表→高亮回退弹窗后首卡行→9-2/9-3 框错且不在视口（抽帧实证旧高亮落在「withdrawn notice」行，增值服务区根本不在画面）。v1 ch9 亦潜伏此缺陷。改：rec.mjs CONTEXT['9'] 不开弹窗、滚首卡增值服务区；9-2 hl→.partner-premium-block>div:nth-of-type(2)（Audit 行）、9-3→nth-of-type(3)（Search 行）。
- **四语重出**：字幕四语重写（captions-v1.json en/zh/ru/fr + shots capEN/capZH）→ 重配音（删 9-2/9-3 旧声、tts 补，各 lang 2 new 全 in-range）→ rec ch9 land+port×4 → prod-ch 合成 8 片（en22.8/zh23.8/ru26.4/fr24.3s）→ gp1-finish --chapter 9 联络表四语。**两处踩坑**：①首轮循环 zsh 未对 $combo 分词→TAG 乱名+错 orient，废弃重录；②compose 误用 `| grep -E "->|res="`（ugrep 把 - 当选项→SIGPIPE 杀 prod-ch，mp4 没更新显旧片），去 grep 管道重合成修复（LEDGER-3）。
- **逐张亲眼复验**（en/zh/ru/fr land 全 + ru-port 9-3 全分辨率 + en-land 原始帧）：9-1 框 PREMIUM SERVICES 标题、9-2 框 🚀 Audit Service ¥1,500、9-3 框 🤝 Human-assisted Search ¥600、9-4 框 📡 Exposure boost，各不越界；字幕↔所框行指同一服务。四语 no @gmail、无真 PII（演示生 Serikova Aizhan）；页头平台 WhatsApp/Email 不遮（D-14-3/D-15-1）；RU/FR 服务名英文回退（D-18-4）照录入 SUMMARY。对账表 REVIEW-{en,zh,ru,fr}-shots.md 新建（§十一，ch9 段）。
- **DB**：ch9 全程只读，收工 verify **17/17 PASS 0 FAIL**。零置态/零写库。
- **改了**（主仓库，不推）：rec/rec.mjs、rec/shots-v1.json、captions-v1.json、rec/_probe-ch9-rows.mjs(新)、rec/_probe-ch9-diag.mjs(新)、REVIEW-{en,zh,ru,fr}-shots.md(新)、DECISIONS.md。成片/voice 不入 git；ch9 四语联络表 + 四 REVIEW-*-shots + 决定账推 mh-jobs。
- **下趟**：§三 余下不受缺陷2阻塞镜——ch5 §三.3（5-2 缓存帧重烧字幕四语）或 §三.4（5-4 置态真上传更正件→审核中再框，需可靠 reset）；§五 OP-2(6-1/6-2) 可做。仍受缺陷2阻塞的工作台漏斗章 + 最终 NEEDS_OWNER_DECISION 待后续。**GP-1 未收官。**

## 第 22 趟（2026-10-12 Mac mini 无人值守）· 返工 §二 ch6 RU/FR 重出（完成 §二 四语）+ §三 逐镜漏斗审计
- **接手核对**：读齐 PROGRESS/loop-tail/RULING-20261012b-review1/-c-rework/DECISIONS。上一趟（16:00）教训＝误读旧『收官』即停——本趟首行已改『返工进行中』不复犯。开工 verify **17/17 PASS**（baseline 守住）。
- **ch6 RU/FR 重出（D-22-1）**：资产核实 captions 四语齐、ru/fr 6-3/7-1 配音 17:09 已随 §二重配；录制 ch6 ru/fr land+port（4 镜高亮全 resolve、四片 no @gmail、HIDE_INIT 盖 beta 链接）→ 合成 ch6-{land,port}-{ru,fr}.mp4（ru 26.5/26.7s、fr 26.0/25.9s）→ 联络表（gp1-finish 加 `--chapter` 只出 ch6，不碰仍阻塞的工作台章旧表）→ 逐张亲眼复验 + ru-land 6-7 全分辨率抽帧证 **beta 链接不可见**、盲码无校名、接受钮高亮、Partner Hub 左标签。收工 verify **17/17 PASS 0 FAIL**。**→ §二 四语全部重出完毕**。
- **§三 逐镜漏斗审计（D-22-2，trip21 遗留的「逐镜核实」）**：读第一版 en ch5/ch9 联络表判定——**不受缺陷2 阻塞**：ch9 9-1..9-4（内联 PREMIUM SERVICES 行，漏斗滚出画面）→ §三.6(9-2/9-3)；ch5 5-2/5-3/5-4（viewReferredStudent(3) 详情弹窗，不含漏斗）→ §三.3(5-2 缓存帧重烧字幕四语)、§三.4(5-4 置态重录需可靠 reset)。**仍阻塞**：ch5 5-1、ch7 7-4、ch2 2-x、ch1 1-8、ch3 3-1/3-8、ch8、ch10 的工作台漏斗帧。
- **DB**：ch6 全程只读，baseline 17/17 全程守住。零置态/零写库。
- **改了**（主仓库，不推）：rec/gp1-finish.mjs（stageContact 加 `--chapter`）、DECISIONS.md。成片/voice 不入 git；ch6 ru/fr 联络表推 mh-jobs。
- **下趟**：ch9 §三.6（读 i18n 真服务名改 9-2/9-3 字幕+四语重配音+重录）或 ch5 §三.3/5-2，一趟一章专做；§五 OP-2 可做；含漏斗章定版重出 + 最终缺陷2 NEEDS_OWNER_DECISION 待后续。**GP-1 未收官。**

## 第 21 趟（2026-10-12 Mac mini 无人值守）· 返工 §二 第6章去「点解锁→校名揭晓」
- **接手核对**：第20趟做完 §一(缺陷1修/缺陷2定性=产品漏斗bug待裁决)+§四(草稿残留)。本趟按 §八 顺序接做 §二。开工 verify **17/17 PASS**。
- **只读实证**（_probe-ch6-blind.mjs，不写库）：盲态录取弹窗 `.btn-offer-accept`「✓ Accept this program」存在可见→6-7 可直接高亮无需解锁；`.cloud-offer-unlock`=内测链接「🔓 Unlock to view (beta: status flip only, no payment)」；`.admission-id-tag`=SCH-1AD6C8 盲码无校名。
- **§二 改法（review1 §二 1~5 全做）**：删 6-4/6-6（连 _p130_SchoolCache 注入）；6-3/7-1 四语字幕改+重配音；rec.mjs 加 HIDE_INIT 盖 beta 链接（踩坑见 D-21-1：改 setInterval+MutationObserver）；TRAILER_CH ch6 `['6-2']`。详见 DECISIONS D-21-1。
- **重出 ch6 EN+ZH**（各横竖，review1 §八「英文、中文先行」）：录制→合成→联络表→**逐张亲眼复验全过**（beta 链接确认不可见、盲码无校名、全片 no @gmail、字幕↔画面一致）。
- **DB**：ch6 全程只读，baseline 17/17 全程守住。零置态。
- **改了**（主仓库，不推）：rec/shots-v1.json、captions-v1.json、rec/rec.mjs、rec/gp1-finish.mjs、rec/_probe-ch6-blind.mjs(新)、storyboard-v1.md(v1.3)、DECISIONS.md。成片/voice/联络表：成片voice不入git；联络表推 mh-jobs。
- **下趟**：ch6 RU/FR 重出 → §三/§五 中不受漏斗阻塞的部分 → 最终缺陷2 NEEDS_OWNER_DECISION。

---
# 以下为第20趟及更早（返工开工前）记录
**上一趟（第20趟）做了**：只读查清——负数金额 ¥-9,000/¥-3,000 = DEMO 数据（基线造了真实 ¥0 优惠码付款链从不建的假 payment_order，amount-discount=-3000×3），已照 review1 §一第2条改成真实流程表征（删 3 假单＋pt-08/09 补 coupon_redemption＋pt-07 改『已接受+通知书已传+未付』合法录前态），活库＋build-core＋verify＋两个 ch7 复位脚本全同步，verify 16/16 PASS（含复位幂等往返）。**查实缺陷2 = 产品算法 bug**：漏斗 0 letter/0 paid/0 enrolled/0 offers 与卡面矛盾，根因是漏斗读废弃列 students.stage（真实生恒 NULL、全库零写入）且对云端生硬编码 paid=0/offers=0——任何真实中介都会看到空漏斗，非演示数据可修（填 stage=造假、改硬编码=动产品码，均禁）。照 §1.3/§八：先做完不依赖它的部分，最后写 NEEDS_OWNER_DECISION 停下。**本趟还做了 §四**：清掉 ZH ch2 的『草稿·DRAFT』残留——根因 ch3 向导云自存经 unique(partner_uid) 覆盖基线 pt-01 草稿；已还原 Ayesha Malik 基线+折进 st-ch3-cleanup+加 verify #17（17/17 PASS）+加 st-ch3-mark-test.sql（提交后即标 is_test）；查实 ch3 真提交不发任何邮件/通知。**下趟**：§二 ch6 去『点解锁→校名揭晓』→ §三可独立字幕 → §五开场快剪；凡含工作台漏斗的章节重出待缺陷2 裁决。**GP-1 未收官，勿据旧『收官』停工。**

## 第 20 趟（2026-10-12 Mac mini 无人值守）· 返工开工 · review1 §一根因 + 修复缺陷1
- **接手核对**：上一趟（16:02）读到旧 PROGRESS 首行『收官』即停、未读返工裁决——本趟首行已改『返工进行中』，不复犯。读齐 RULING-20261012c-rework（返工范围/顺序）+ RULING-20261012b-review1（复核意见）。
- **§八第1步 = review1 §一只读查清（D-20-1）**：db-run.sh 只读探针 + 源码精读，判两个缺陷：
  - **缺陷1 · 负数金额 = DEMO 数据**（§0.3 可修）。基线 payment_orders 仅 3 行假 ¥0 单(amount=0,discount=3000)，get_agent_boost_stats.paid_total=sum(amount-discount)=-3000×3=hero -9,000。真实 coupon_agent_pay_offer 只写 letter_paid_at + coupon_redemption、不建 payment_order（活库 coupon_redemptions=0、letter_paid_at=t 实证基线用错表征）。
  - **缺陷2 · 漏斗全 0 与卡面矛盾 = 产品算法 bug**（§二第6条②·要改产品码）。漏斗读废弃列 students.stage（9 个演示生全 NULL，全库 migration+五端口 JS 零写入，真实 stage 由 student_global_stage() 现算）且对云端生硬编码 paid=0/offers=0。真实中介必见空漏斗 → **不伪造、不改码，照 §1.3 最后写 NEEDS_OWNER_DECISION**。
- **修复缺陷1（D-20-2）**：新增 states/st-rework-paylane-cleanup.sql 迁活库（删 3 假单＋pt-07 改未付态＋pt-08/09 补核销，幂等）；改 build-core.sql（源头真值）、verify.sql #6/#7（真实流程断言，总数仍 16）、st-pt0708-reset-cleanup.sql（复位到新基线、不再重建 ¥0 单）、st-pt07-pay-cleanup.sql（录前态并清解锁）。活库跑迁移→verify 16/16 PASS→跑复位→verify 16/16 PASS（往返幂等实证）。负数从数据层根除，hero=¥0、卡 Invested=¥0。
- **改了**（主仓库，不推）：states/{build-core,verify,st-pt0708-reset-cleanup,st-pt07-pay-cleanup,st-rework-paylane-cleanup}.sql、rec/_probe-rework-stats.sql、rec/_probe-coupon-id.sql、DECISIONS.md。本趟零录制（workbench 章重出待缺陷2 裁决）。
- **下趟**：§四 草稿残留 → §二 ch6 → §三独立字幕 → §五快剪；workbench 漏斗章重出 + 最终 NEEDS_OWNER_DECISION 待后续。

# JOB-GP1-03 进度交接（**视频制作已收官 · EN·ZH·RU·FR 四语全齐**）
- **§四 清录制残留（D-20-3）**：referral_drafts unique(partner_uid) 致 ch3 向导云自存覆盖基线 pt-01 草稿（活库探针:surname/email 空、_demo 丢、step=3）→ ZH ch2 空白『草稿·DRAFT』残留卡。还原基线(Ayesha Malik/step2/_demo=pt-01)折进 st-ch3-cleanup + verify #17 + 新增 st-ch3-mark-test.sql(提交后即标 is_test 安全网)。活库还原后 verify 17/17 PASS。查实 submit_referral 仅 insert students、无邮件/站内通知（触发器为配额/app_no/重提闸，均不发信）。

## 第 19 趟（2026-10-12 Mac mini 无人值守）· RU 全片合成 + FR 全程 → GP-1 视频制作收官
### A. RU 全片合成（D-19-1/2/3）
- **gp1-finish ru 卡面**：KEYPOINT_TITLE/RECAP_LINES 逐字取 captions-v1.json ED-1.ru 俄文回顾串(① Одна подача — много вузов ② Ваш студент остаётся вашим ③ Никаких сборов платформы ④ Заполняет вуз — доставляем вам，OP/ED 一字一致)；BRAND_CARD.ru/CATALOG_TITLE.ru「Десять коротких глав」/RECAP_EYEBROW.ru「КРАТКО」；capFor 加 ru/fr 读 captions-v1.json(OP-2..5 正文+ED-2 说明本语，en/zh 不动)。
- **合成**：bookend OP 59.7s/ED 14.7s；film full-land/port 467.4s(14 段,masterDur==unitSum 零漂移)；trailer 187.2/187.5s(6 段)。item-8 ED-ru 横竖=`...?src=video-ru`。真 Chrome 播放全 readyState4/seek 近尾/pageErr0。五卡(OP-1/5/6、ED-1/2)肉眼复验俄文无豆腐块、品牌紫橙、OP/ED 四条一字一致。
- **分段 OOR**：trailer seg05=42.8s(超40，[6-2,6-6,7-0,7-1,7-3])——collapse 把 7-3 孤段并回所致(RU 配音更长落点不同)；接受(两害取其轻，孤段<20更糟)。film 仅 ED 尾段 14.7s(刻意)。
### B. FR 全程（D-19-4/5）
- **工装 prep**：prod-ch 加 CH_TITLE_FR(+CH_TITLE_FOR fr)；_patch-fr-shots.mjs 为 3-5/3-6 加 pre_fr(AI 预检法文样例)+8-3 act_fr(提额理由法文)；gp1-finish 卡面加 fr(标题取 ED-1.fr)。capFor 已通用。FR voice 59件+durations、captions 58/58 有 fr 齐。
- **逐章录制**：每章 verify→(置态)→录横竖→(复位)→verify。读-only(1/2/5/8/9/10)直录；置态章复用语言无关 scoped 件——ch3=st-ch3-cleanup(真 submit app_no MH-7CTJXC，两版各 DELETE1×2+COMMIT→verify16)；ch4=st-pt04-docs-full 置态+st-pt04-reset-cleanup(UPDATE1+DELETE1,两版 verify16)；ch6=st-pt06-reset(UPDATE1,两版 verify16)；ch7=录前空跑证复位可靠→st-pt07-pay-cleanup+st-pt08-jw202 置态→录→st-pt0708-reset-cleanup(真¥0付 DELETE1+基线¥0单 INSERT1,两版 verify16)。**全程 baseline 16/16 守住**。
- **真帧肉眼复验**：ch1 门禁「Connexion partenaire / Nouvelle agence ? Inscription」+章节条「Chapitre 1 Inscription et activation」；ch3 3-8 app_no MH-7CTJXC 橙框+Demo Aisha+3-9「en attente」；ch6 6-6 揭晓全 demo 联系(maxhouse_demo/demo@maxhouses.net/+86…0000)「L'université est révélée」无真 PII、6-7 SCH-1AD6C8 盲码；ch7 7-0 ¥0.00 橙框内+划除¥3,000·MAXHOUSE−¥3,000+masked agency.demo@example.com/MH-NEPTRN。20 录屏 DOM 扫描全 ✅ no @gmail。
- **item-7 FR**：_scan-fr-forbidden.mjs 扫 74 条 FR 串 → 0 命中(5 类禁用词+真名校名)，PASS。
- **FR 合成**：bookend OP 56.0s/ED 13.9s；film full-land 460.3/port 458.9s(13 段零漂移)；trailer 179.9/178.8s(6 段)。item-8 ED-fr=`...?src=video-fr`。真 Chrome 全过。OP-6「Dix courts chapitres」+10 章 FR 标题、ED-1「EN BREF」+4 行=OP 标题一致，无豆腐块。
- **分段 OOR**：film seg12=45.4s([8-4,9-1..9-4,10-2..10-4])——与 **ZH film seg12=44.9s(已过自审发货)同一先例**，collapse 并孤段，接受记账。ED 尾段 13.9s(刻意)。
### C. 四语对账 + 章节条左标签
- **对账 0 缺**：EN/ZH/RU/FR 各 20 章 mp4 + 4 bookend + 2 full + 2 trailer；分段 full(en/zh/fr 26=13×2、ru 28=14×2)+trailer(12=6×2)；联络表各 20 张(en 21)推 ~/mh-jobs/shots/GP1/<lang>/。full-land 时长 EN443/ZH459/RU467/FR460s。
- **章节条左标签 ru/fr 保「Partner Hub」**：= 产品 FR 门禁页头字面「ESPACE PARTENAIRES · PARTNER HUB」+与已发货 RU 一致；仅 ZH 本地化为「合作伙伴端」。业主眼验闸(铁律15)可一句话要求 RU+FR 同本地化(仅重烧章节条,代价小)。
- **改了(主仓库,不推)**：rec/gp1-finish.mjs(ru+fr 卡面、capFor ru/fr)、rec/prod-ch.mjs(CH_TITLE_FR + capFor ru/fr 已在 D-18-1)、rec/shots-v1.json(3-5/3-6 pre_fr、8-3 act_fr)、rec/_patch-fr-shots.mjs(新)、rec/_scan-fr-forbidden.mjs(新)、DECISIONS.md。成片/voice 不入 git/mh-jobs。
### D. 收官状态
- **GP-1 视频制作收官**：四语横竖四件套全齐在本机 guide/dist/partner/。EN 九项自审全过(trip15,REVIEW-en-self.md)；RU/FR 逐趟做 item-7 禁用词扫+item-8 QR 解码+真帧脱敏复验+真 Chrome 播放。DB 全程 baseline 16/16 守住。
- **下一步=写 SUMMARY-GP1.md(PUSH_OK=yes)即停**。不开 GP-2：不传 R2、不动 Cloudflare、不推主仓库。

## 第 18 趟（2026-10-12 Mac mini 无人值守）· 开录俄语 RU → RU 十章横竖齐 10/10
- **工装两修（RU 片本会带错内容，先修再录）**：
  - **D-18-1 字幕源**：prod-ch.mjs capFor() 对 ru/fr 原直返 capEN（注释称 ru/fr 全片阶段再处理，实为 film 只拼接不重烧→照原注释 RU 永久英文字幕）。改 ru/fr 分支从 captions-v1.json 取 c[lang] 译文；en/zh 仍从 shots-v1.json 原样取（EN 母版+ZH 基线逐字节不变）。首帧实证修好（ch1 字幕俄文）。
  - **D-18-2 章节条标题**：加 CH_TITLE_RU（照 EN 母版逐章译+回译自检，从简控宽防省略框溢出）+ CH_TITLE_FOR ru 分支。同 ZH 走 CH_TITLE_ZH 处理。章节条「Глава N  <RU标题>」逐帧复验无溢出。
- **D-18-3 镜级 RU 变体**：3-5/3-6 加 pre_ru（琥珀 AI 预检卡俄文样例 issues，产品 _wzRender 渲染 RULING §1.2）；8-3 加 act_ru（#qrReason 俄文自由文本）。经 rec/_patch-ru-shots.mjs 落 shots-v1.json。
- **D-18-4 RU UI 俄/英混排 = 真实产品**：v184 的 RU = REP_I18N ru 词典 + I18N_RU + LL(zh,en) 两语助手；LL 动态拼接串（Quota raise pending / Your referral performance / STUDENTS SUBMITTED 等）在 ru 回退英文，词典覆盖处显俄文 → 画面俄英混排。照 RULING §二.1 照录真实画面；修它须改端口 i18n 码（§0.2 禁，亦 §二.6② 停下情形），**不改、记账、继续**。业主上线前亲验可另判。
- **D-18-5 8-4 已批卡保持英文**：RU 下待审卡本回退英文，base pre 命中（真帧 box 2200x127），注入英文已批卡与上下文一致；不加 pre_ru。旁白字幕仍俄文。
- **逐章录制（D-18-6）**：每章 verify16/16→(置态)→录横竖→(复位)→verify。
  - 读-only/零DB 章（1/2/5/8/9/10）直录（baseline 不动）。
  - 置态章复用 ZH 趟 scoped 件（**语言无关**）：ch3=st-ch3-cleanup（真 submit 耗名额 9→10，真 app_no MH-Y68WT2，录后单删复位）；ch4=st-pt04-docs-full 置态 + st-pt04-reset-cleanup 复位（app_no MH-EXET28 不覆写）；ch6=录后 st-pt06-reset（两 offer unlocked_at 清 + student_response 回 pending）；ch7=st-pt07-pay-cleanup+st-pt08-jw202 置态 + st-pt0708-reset-cleanup 复位（录前先空跑状态往返证复位可靠=16/16 再录）。
  - 真写库镜（ch3 submit / ch4 submitted_at / ch6 unlocked_at / ch7 ¥0 真付 letter_paid_at+核销）均录后 scoped 复位，**每章 verify 16/16，全程基线守住**。无全量 rebuild（本机 faces 空 0/201，D-16-4）。
- **真帧肉眼复验（抽帧）**：ch1 门禁「Вход для партнёров」/入驻表单俄文/工作台「Партнёр · одобрено」（+英文回退 Quota raise pending 真实产品）；ch3 琥珀卡「Напоминания предварительной проверки」+我注入 RU issue + app_no MH-Y68WT2 橙框；ch6 6-6 揭晓「🔓 Demo University · 演示大学 · Wuhan/武汉 · SCH-1AD6C8」全 demo 联系（+86…0000/demo@maxhouses.net/maxhouse_demo）无真 PII；ch7 7-0「Плата за разблокировку письма о зачислении」¥0 大字橙框内（§3.5）+划除 ¥3,000·MAXHOUSE−¥3,000、masked agency.demo@example.com/MH-NEPTRN；ch8 8-3 目标30+「Ожидаем больше студентов…」+Отмена俄文；ch4 已发邀请两行 aizhan.demo@/agency.demo@example.com 全掩码、Отозвать俄文。
- **脱敏（铁律9）**：20 录屏 DOM 扫描全 ✅ no @gmail；画面层演示邮箱 firstname.demo@/agency.demo@/aizhan.demo@example.com；邀请码 MAXHOUSE-PARTNER-XXXX 掩码；SCH-/MH-/PA- 为非密标识。
- **item-7（RU 禁用词扫）**：rec/_scan-ru-forbidden.mjs 扫 74 条 RU 串（caption ru + keypoint ru + CH_TITLE_RU + AI 注入）对 5 类禁用词 + 真实名校名 → **0 命中，RU 过**。
- **交付**：~/guide/dist/partner/ch1..10-{land,port}-ru.mp4（各带音轨/1920x1080·1080x1920）；联络表 ~/mh-jobs/shots/GP1/ru/ch1..10-contact-{land,port}-ru.png（20 张）。
- **DB**：全程 baseline 16/16 守住（置态章 scoped 置态+复位，ch7 录前空跑证复位）。
- **成片现状**：EN 全齐(清关) · ZH 全齐 · **RU 十章横竖齐 10/10**（本趟）· FR 待录。
- **改了**（主仓库，不推）：rec/prod-ch.mjs（D-18-1/2）、rec/shots-v1.json（D-18-3）、rec/_patch-ru-shots.mjs（新·工具）、rec/_scan-ru-forbidden.mjs（新·工具）、DECISIONS.md。**成片/voice 不入 git/mh-jobs**。
- **下趟**：RU 全片合成——gp1-finish 的 KEYPOINT_TITLE/BRAND_CARD/CATALOG_TITLE/RECAP_LINES/RECAP_EYEBROW 补 ru 分支（照 storyboard §一 四条重点 ru 标题，EN/ZH 不动）→ bookend/film/trailer --lang ru → OP/ED/full/trailer-ru + 20-40s 分段 → item-8 jsQR 解 ED-ru（期望 ...?src=video-ru）→ 真 Chrome 播放复证。再 FR（FR 复用 capFor 已通用，需补 CH_TITLE_FR + 3-5/3-6 pre_fr + 8-3 act_fr + gp1-finish fr 卡面）。

## 第 17 趟（2026-10-12 Mac mini 无人值守）· ZH 全片合成 → ZH 四件套全齐
- **gp1-finish 加 lang 感知（D-17-1）**：bookend 卡面硬编码英文本地化为 zh（照 storyboard §一「四条重点·定稿」中文标题 + CH_TITLE_ZH，逐字取、不自造、不改四条重点口径）。KEYPOINT_TITLE/RECAP_LINES/BRAND_CARD/CATALOG_TITLE 改 {en,zh} 两层；recapCard 加 eyebrow 形参（EN「IN SHORT」不变／zh「要点回顾」）；OP-6 列表改用 CH_TITLE_FOR(n,'zh')。EN 路径（LANG 默认 en）逐字节不变。
- **ZH 合成（D-17-2）**：bookend/film/trailer --lang zh。full-{land,port}-zh 459.4/458.3s(13段)、trailer 182.7/181.5s(6段)、OP 59.16s、ED 12.62s；分段 out-of-range 仅 ED 尾段(12.6s，同 EN 13s 先例有意保留)。短段并回：groupSegments 把 <20s 内容短段并回上段（ED 尾段不动）；film stage 加清 full-*-seg 旧段（防段数变动残留，为 RU/FR 防残留）。
- **item-8（D-17-3）**：jsQR 真帧解 ED-zh 横竖 = `https://www.maxhouses.net/partner-portal/?src=video-zh`，与 RULING §3.8 一致 ✅。
- **验证**：六张 OP/ED 卡(OP-1/3/5/6、ED-1/2 land)逐张肉眼复验——中文无豆腐块、品牌紫橙、OP-5 最长标题换行正、OP-6 十章中文齐、ED-1 四点中文=OP 标题一致、eyebrow=要点回顾、ED-2 QR+「扫码注册…」。真 Chrome 播放 full/trailer/seg01 land+port 全 readyState4/seek 近尾/pageErr=0；unitSum==master 零漂移；分段 land/port 各 full 13 + trailer 6。
- **DB**：本趟**零 DB 操作**（纯合成，baseline 16/16 自 trip16 未动）。
- **成片现状**：EN 全齐(trip15 清关) · **ZH 全齐**(本趟) · RU/FR 待录（资产就绪）。

## 第 16 趟（2026-10-12 Mac mini 无人值守）· 开录中文 ZH（ch1+ch2）
- **章节条本地化（D-16-1）**：gp1-overlays.chapterBar 加 `lang` 形参（默认 en，EN 母版逐字节不变）+ BAR_I18N（zh 左标签「合作伙伴端」/前缀「第 N 章」；ru/fr 预留）；prod-ch 加 CH_TITLE_ZH（照 storyboard 10 章名）+ CH_TITLE_FOR，chapterBar 调用传 LANG。抽 ch1 首帧肉眼复验中文正常无豆腐块。
- **ZH ch1（注册与开通，D-16-2）**：照 EN trip13 三登录态编排仅 `--lang zh`。零 DB 写入（baseline 不动，无需 rebuild）。成片 ch1-{land,port}-zh.mp4（49.46/49.48s，8 镜，1920x1080/1080x1920 带音轨）；联络表 shots/GP1/zh/ch1-contact-{land,port}-zh.png 逐张亲验（8 格齐、1-1→1-8 字幕↔画面一致、邀请码 MAXHOUSE-PARTNER-XXXX 掩码、演示邮箱 firstname.demo@example.com、零 @gmail）。
- **ZH ch2（工作台）**：CONTEXT 同 EN（2-5 toggleStuNotifPanel）。零 DB 写入。成片 ch2-{land,port}-zh.mp4（28.16/28.12s，5 镜）；联络表亲验（工作台/名额/进度/五档徽章/通知 五镜齐、中文 UI、仅演示生名、零 @gmail）。
- **item-3 页头平台联系**：ZH 片同 D-15-1 口径（平台自有 WhatsApp/+49…/Service@maxhouses.net 保留不遮，铁律15 人眼闸保留）。
- **DB**：开工 verify 16/16 PASS；ch1/ch2 零 DB 写入，baseline 未动。
- **成片现状（ZH）**：1·2·3·4·5·6·7·8·9·10 = **10/10 齐**。全量 rebuild 本机禁用（faces 空 0/201，D-16-4），有置态章一律 scoped 复位。


## 第 15 趟（2026-10-12 Mac mini 无人值守）· EN 英文母版九项自审全过 → EN 清关
- **item-2 收口**：ch2/ch5/ch8/ch9/ch10 横竖联络表逐张亲眼看图（接 trip14 已验 ch1/3/6/7+ch4页头）→ 10 章×横竖 20 张全验。每格画面与该镜字幕一致；演示生邮箱 = agency.demo@example.com（MASK），参考码 PA-xxxx/盲码 SCH-xxxx 为非密标识，全片零 @gmail。
- **item-3 自处理定案（D-15-1，解除 D-14-3 挂起）**：登录后 portal 页头常驻平台自有联系（WhatsApp/电话 `+49 152 24910967` + `Service@maxhouses.net`，maxhouses.net 平台自有域）= 平台自有公开客服联系，非学生/第三方 PII、非对手校、非双盲破墙。逐条比对 RULING §2.6 四种停下情形**全不命中**（不缺权限/不动产品码/非品牌承诺/不碰线上）→ CC 自处理+记账，**选 A 保留不遮**。item-3 口径收窄为本意（铁律6 零信任 PII）。**铁律15 保留**：业主上线前亲验成片可一句话改判 B（遮蔽，届时扩 MASK 重录 ch2..10 或后期打码）。
- **item-4 对账表 + 修引号标签（D-15-2/3/4）**：出全镜对账表 `REVIEW-en-caption-button-audit.md`（引号标签镜逐字对账/动作描述镜达意核/陈述镜不涉）。两处引号标签原为意译、与真控件不符 → 逐字改齐真控件（v184 实证：1-1 登录链接「New agency? Register →」、3-1 列表钮「Submit New Student Referral」；ZH 本就一致不改）。按 §2.2 重配 EN 音（删 1-1/3-1 m4a 重生，时长 4→3.6 / 1.44→1.834s）→ 用**缓存帧**（不重录、不碰DB、不碰portal）经 prod-ch 重烧字幕+重混 → 重出 ch1/ch3 EN 横竖 4 片 → gp1-finish 重拼全片(443.2/443.1s,13段)+速览(177.2/177.6s,6段)+重生 ch1/ch3 联络表。抽帧肉眼复证 1-1 字幕=画面控件逐字一致；真 Chrome 播放 full/trailer land+port+seg01 全 readyState4/seek近尾/零 pageErr。
- **item-8 二维码解码（D-15-5）**：/tmp 装 jsqr@1.4.0+pngjs（代理，不入 git），对成片 ED-{land,port}-en.mp4 第10s 抽帧 jsQR **真帧解码** → 横竖均 = `https://www.maxhouses.net/partner-portal/?src=video-en`，与 §3.8 逐字一致。
- **九项状态**：1✅(录制时闸) 2✅ 3✅(选A·人眼闸保留) 4✅ 5✅ 6✅ 7✅(EN+中;RU/FR随录建扫) 8✅(EN;RU/FR/ZH随录解) 9✅ → **全过，EN 清关，可开录中俄法**。
- **改了**（主仓库，不推）：shots-v1.json(capEN 1-1/3-1)、captions-v1.json(en/ru/fr 1-1 + en 3-1)、REVIEW-en-self.md、REVIEW-en-caption-button-audit.md(新)、DECISIONS.md。**成片/voice** 不入 git/mh-jobs。
- **DB**：本趟**零 DB 操作**；baseline 16/16 自 trip14 未动（本趟纯合成/自审，用缓存帧，不录制）。

## 第 14 趟（2026-10-12 Mac mini 无人值守）· EN 自审前置合成 + 开审
- **OP/ED 叠层卡成片**（新 rec/gp1-finish.mjs，复用 gp1-overlays 的 brand/keypoint/recap/qr 卡）：OP-1 品牌卡 / OP-2..5 四条重点卡（卡面=四条重点逐字文案，文字未改）/ OP-6 目录卡（列10章）；ED-1 四条回顾（4✓）/ ED-2 二维码（qrcode 生成 ...?src=video-en + 网址 + 「邀请码见引导页」）。逐卡定格到配音时长+0.5s，混本语配音，编码同 prod-ch(crf21/aac)。横竖各出，卡逐张肉眼复验品牌紫橙正。
- **全片拼接 + 分段**：OP 卡 + 各章 mp4 按镜界切子片 + ED 卡 → `full-{land,port}-en.mp4`(443.2s) + `segments/{orient}/full-en-segNN.mp4`(13段)。分镜边界用 prod-ch 段时长公式重算(与各章成片实测 diff≤0.07s)，splitChapter 末镜对齐真尾。贪心聚 20~40s，ED 强制独立成 13s 收尾段。
- **速览(招募片)**：照 RULING §1 镜单(OP-1~6→1-1/1-7/1-8→2-1/2-4→3-1/3-8→4-1/4-5→6-2/6-6→7-0/7-1/7-3→ED-1/ED-2) → `trailer-{land,port}-en.mp4`(177s) + 6 段。删 6-5、第6/7章段改 6-2/6-6→7-0/7-1/7-3 已落。
- **验证**：真 Chrome 播放 full/trailer land+port + seg01 全 readyState4、seek 近尾、零 pageErr；全段逐段 probe 有 A+V、段和=master；OP/ED 卡 + ch6/ch7 联络表 + 6-2 字幕带 + 7-0 ¥0 橙框 + 页头区 皆肉眼复验。
- **联络表**：gp1-finish `contact` stage 生成全 10 章×横竖共 20 张(每镜段中一帧网格)推 shots/GP1/en/。drawtext 未编入此 ffmpeg → 无镜号标注，镜序见 stage 输出。
- **九项自审(REVIEW-en-self.md，进行中)**：见该文件。**item-3 发现**最关键（D-14-3，待业主一句话定遮蔽口径）。
- **成片**(不入 git/mh-jobs)：~/guide/dist/partner/{full,trailer,OP,ED}-{land,port}-en.mp4 + segments/。改了(主仓库，不推)：rec/gp1-finish.mjs(新)、DECISIONS.md、REVIEW-en-self.md(新)。
- **DB**：本趟**零 DB 操作**(纯合成/自审，不碰库，基线 16/16 不动)。

## 第 13 趟（2026-10-12 Mac mini 无人值守）

## 第 13 趟（2026-10-12 Mac mini 无人值守）
- **ch1 注册与开通（EN 横竖成片，~49.4s，8 镜，真帧肉眼复验、零 @gmail）→ EN 十章齐 10/10**：
  - 本章跨三登录态，一趟内走通、**全程零 DB 写入**（录前 verify 16/16 → 录 land → 录 port → 录后 verify 16/16，基线零漂移，无需 rebuild）。
  - **1-1..1-4 真·未登录门禁**：harness 对 ch1 开场跳过自动登录，停在真门禁。1-1 整屏登录卡(EN)；1-2 高亮「New agency? Register →」；1-3 注册盒邀请码框(占位 `MAXHOUSE-PARTNER-XXXX`=掩码，非真码)；1-4 高亮「Register」钮(不点，避开真 signUp)。
  - **1-5..1-7 产品 render 喂样例(RULING §2.1c，ch8 先例)**：实证 `guide_ptReg` 邮箱未验证、无法真登录(被「请先验证邮箱」拦) → 1-5..1-7 改用产品自身 `renderOnboardingView()`(入驻表单，样例预填 Demo Agency Reg/Pakistan/firstname.demo@example.com) / `renderPendingView()`(审核中琥珀卡「Under review」)直渲，零自造界面。
  - **1-8 真登录已批工作台**：shot `login:'guide_partner'` 镜前真登录(已批伙伴可登) → `renderActiveView` 工作台，高亮 hero「Demo Agency · Partner agency · approved」。只读。
  - **harness 加固(rec.mjs)**：抽 `doLogin(key)`(任意账号先 goto 回门禁再登)、`CH==='1'` 不自动登录、shot 级 `login` 字段镜前切登录态——供后续跨登录态/多账号章复用。
  - 交付：成片 ~/guide/dist/partner/ch1-{land,port}-en.mp4(1920x1080 / 1080x1920 带音轨)；联络表 ~/mh-jobs/shots/GP1/en/ch1-contact-{land,port}-en.png(逐张看过，8 格齐、无泄露)；主仓库 commit(不推)。
  - 自审待办(REVIEW-en-self §4)：1-1 字幕引号内「Register your agency」≠真按钮「New agency? Register →」，EN 自审阶段统一(去引号，口播词不变→voice 不重生)。
- **成片现状（EN）**：1·2·3·4·5·6·7·8·9·10（**10/10 齐**）。

## 第 12 趟（2026-10-12 Mac mini 无人值守）
- **ch3 提交第一个学生（guide-pt-01 向导，EN 横竖成片已出，~69s，9 镜，真帧肉眼复验、零 @gmail）**：
  - 3-1 列表「Submit New Student Referral」→ 3-2 向导 step1 计划(开学季/资助/层次/专业) → 3-3 step2 档案(DOB/护照号，step2 输入无 id 用 label 文本选择器) → 3-4 step3 材料上传槽 → **3-5 AI 预检琥珀条** → **3-6 护照姓名核对琥珀条** → 3-7 退出三选一(存草稿入口) → 3-8 真 submit 出真 app_no → 3-9 列表卡「审核中」。
  - **3-5/3-6 照 RULING §1.2 用产品自身渲染喂样例**（ch8 先例）：wizard step3 pre 注入 `state.wiz.docs[槽]=[{path:'demo/referral-drafts/槽/..'}]` + `state._aiDraftHints[path]={verdict:'fail'|'unsure',issues:[真口吻英文样例]}` → `_wzRender()` → 产品 `_aiHintBandHtml` 琥珀条「Pre-check reminders ⚠ + 问题 + 产品自带 footer」+ sticky `.ai-agg` 真渲染。零 EF/零桶/零自造。**关键坑**：草稿判认领条件 `indexOf('/referral-drafts/')>0` 须有前缀（前导斜杠=0 不命中）。见 DECISIONS D-12-1。
  - **3-8 真 submit**：清 docs/hints 过 Q1+AI 闸 → `_wzFinalize`(check_collision+submit_referral 真 RPC) → 真 app_no(横 MH-XJ4XDA / 竖 MH-R8JT4M) 高亮。真 submit ~8s，段偏长。
  - **图纸死选择器全校正**：`.ai-hint`/`.amber-box`/`#wzInput_dob`(step2 无此 id)/`.partner-student-status-reviewing`(真 class=`.partner-student-status-pending`)。
- **复位（本机脸库缺口·D-12-2）**：3-8 真 submit 的 guide-pt-ch3(is_test=false) **不走 rebuild-partner.sh**——本机 jobs/JOB-G6 脸库缺 129/201 张(LEDGER-4 双机分割)，全量 rebuild 的 assign-faces 必崩；且 cleanup 的 is_test 闸遇 is_test=false 整体回滚。新建 `states/st-ch3-cleanup.sql`(scoped 单删 guide-pt-ch3，不碰 9 基线生/脸)。录 land→删→verify16/16→录 port→删→verify16/16。
- **交付**：成片 ~/guide/dist/partner/ch3-{land,port}-en.mp4；联络表 ~/mh-jobs/shots/GP1/en/ch3-contact-{land,port}-en.png；主仓库 commit e301615(不推)。
- **成片现状（EN）**：2·3·4·5·6·7·8·9·10（**9/10**）；**缺 1**。


## 第 11 趟（2026-10-12 Mac mini 无人值守）
业主 2026-10-12 下 RULING-20261012-gp1：视频做到收官、上线前停；分镜与产品对不上时 CC 自处理记账不停（四种情况才停）。本趟从该裁决接着做。
- **ch6 多校录取（pt-06 Bilal 两盲 offer）= 照 RULING §1 重做，EN 横竖成片已出**（~42s，6 镜，1920x1080 / 1080x1920，带英文旁白字幕，真帧肉眼复验、零 @gmail）：
  - 6-1 两盲 offer 卡 → 6-2 开录取弹窗(盲码 SCH-1AD6C8 + 专业 + 开学 + 奖学金，无校名) → 6-3 奖学金行 → 6-4 点解锁(无旁白·真写 unlocked_at) → 6-6 校名揭晓(Demo University·演示大学 + 联系块) → 6-7 接受该专业按钮。删 6-5。
  - **6-6 校名揭晓用产品自身 reveal 渲染喂演示校数据（铁律14-P2 + RULING §2.1c，ch8 先例）**：源码+真机实证证明 partner 端 beta 解锁只翻 unlocked_at、服务端不去盲（get_agent_unlocked_offer_school 对未付款 offer 返回 []），真校名要付款才放。故 6-6 把真·演示大学数据注入产品自己的 _p130_SchoolCache 再调 openCloudAdmissionModal 重绘——像素与已付款学生(pt-09)同源，非自造。见 DECISIONS D-11-1。
  - **6-7 字幕去掉「倒计时」**：真机 pending 盲 offer 无倒计时元素（倒计时块仅 accepted+letterUp+!paid 才渲染），四语字幕改为陈述画面真有的「接受该专业 + 开学日期 + 奖学金」，6-7 音频四语重配。见 DECISIONS D-11-2。
  - **harness 加固**：MASK 脱敏加 MutationObserver（re-render 即刻补扫）+ 抓泄露前强制 sweep + sweep 间隔 120→80ms——消除「弹窗重开后、下次 sweep 前」的 @gmail 瞬露窗口（ch6-2 首录曾因此报泄露，修后零泄露）。
- **DB 全程守住 16/16**：ch6 land/port 各录一次（6-4 真写 unlocked_at），**录后各 rebuild 复位 verify 16/16 PASS**。
- **ch7 多校通知书/建档 = 照 RULING §1 加 7-0 + 重录，EN 横竖成片已出**（~42s，5 镜，带英文旁白字幕，真帧复验、零 @gmail）：
  - **7-0（新·¥0 优惠码）**：pt-07 通知书付款单真机驱动「Pay now→¥3,000→优惠码 MAXHOUSE→应付 ¥0(橙框≥2s)→勾同意→确认(真写 letter_paid_at)」；确认走 `coupon_agent_pay_offer` RPC 实证走通（确认后下载钮出现、offer 转 paid）。旁白/字幕/四语配音**复用原 6-5**（直接拷音频，字幕一字未改）。
  - **7-1..7-4 重录**：7-0 确认后 pt-07 转 paid → 7-1 下载通知书（校名 Demo University 此处是真·服务端去盲，因已付款）；7-2 pt-08 JW202；7-3 pt-09 建档进度；7-4 pt-09 列表卡。全改**按名字解析 viewReferredStudent(N)**（硬编码 2/3/4 已随 rebuild 失效）。
  - 置态 st-pt07-pay-cleanup.sql（授权删 pt-07 自家 ¥0 单 1 行）+ st-pt08-jw202.sql；录后各 rebuild 复位 verify 16/16 PASS。G-3 D1 遮蔽：当前 v184 付款单无 PayPal/half-price 元素，无需遮。OP-4 快剪改用 7-0；storyboard 升 v1.1。见 DECISIONS D-11-3/4。
- **下一步（下趟）**：ch3（3-5 AI 预检用产品渲染函数喂样例，3-6 护照核对同理；真 submit 录 app_no 后 rebuild）、ch1（注册从零，需 no-login 路径 + guide-pt-reg 账号）；EN 十章齐 → 开场/片尾 overlays → 全片+速览拼接(20-40s 分段) → 联络表 shots/GP1/en → REVIEW-en-self.md 九项自审 → 过了录中俄法 → GP1-04/05 收官 → SUMMARY-GP1.md。
- 成片现状（EN）：2·4·5·**6(新)**·**7(新,含7-0)**·8·9·10（8/10）；**缺 1·3**。

---
## 【历史·第 10 趟】停审待拍板（已被 RULING-20261012-gp1 解除）
第 10 趟零 DB 写入、只读探针验证 ch3 向导全链 + ch6 源码复核发现两冲突写了 NEEDS_OWNER_DECISION。业主已于 2026-10-12 以 RULING 拍板（ch6 ¥0 移 7-0、ch3 AI 预检用产品渲染），请示单改名 -resolved。

---
## 【历史】第 9 趟新成片：第 5、7、8 章（横+竖，带英文旁白字幕，真帧肉眼复验、零 @gmail 泄露）

## 一句话（给业主）
这趟又录好了三章操作演示：「材料被退回怎么补传」「录取通知书 / JW202 下载与建档完成」「名额快用完怎么申请提额」。都是横屏竖屏两版、带英文配音字幕，画面里学生真邮箱全部打码。录完数据库一键还原，自检 16/16 全过。还顺手把脱敏做得更严（现在任何角落出现的真邮箱都自动盖掉）。剩「多校录取解锁」「提交第一个学生」「机构注册」三章没录。

## 本趟实际完成（已验证）
1. **ch5 材料被退回（pt-03 Rahim Islam）**：5-1 列表卡→5-2 退回理由(Maxhouse 退回·英文原因)→5-3 点「换版」选 SPECIMEN 文件(前端暂存不写库)→5-4 徽章转「Under review」(前端示意·不写库)。**零数据库写入**。横 31.8s / 竖 32.1s。
2. **ch7 通知书/JW202/建档（pt-07 Nilufar / pt-08 Abena / pt-09 Dmitri）**：7-1 录取弹窗下载「Admission Letter」→7-2 下载「JW202 Form」→7-3 建档进度条(Accept✓/Letter✓/JW202✓/Enrollment✓)→7-4 列表卡「Admission complete」。录前置态 `st-pt07-letter.sql`+`st-pt08-jw202.sql`(传 SPECIMEN 到既有 specimen/ 对象，非真上传)，**录后 rebuild 复位 16/16**。横/竖各 28.5s。
3. **ch8 名额与提额（Demo Agency）**：8-1 统计卡「已提交 9」→8-2 打开「Referral quota reached」弹窗(传真值 used:9/quota:10，修掉 _qrOpenRaise 冷调出的 undefined/NaN)→8-3 填 30+理由、高亮 Submit(不真提交)→8-4 横幅转「Quota raise approved: now 30」(前端示意)。**零数据库写入**。横/竖各 30s。
4. **harness 三项加固（rec.mjs，复用于后续章）**：
   - `file` 动作原语：`{t:'file',sel,path}` → setInputFiles 选本地 SPECIMEN(ch5-3 换版用)。
   - `waitFor` 字段：镜前 runPre 后等指定选择器可见(≤9s)再高亮——解两级弹窗(detail→#admissionModal)异步开启的时序，ch7 用它稳稳等出下载按钮。
   - **MASK 脱敏升级为 TreeWalker 全文本节点扫描**：原只盖「叶子元素」文本，漏了「含子节点元素的直系文本节点」里的 @gmail(ch7-2 pt-08 详情里学生邮箱曾漏 1 次)；改成 TreeWalker 遍历 document.body 所有文本节点，@gmail 不论嵌套层级一律盖成 agency.demo@example.com。ch7 重录后 land+port 全 ✅ 无泄露。
5. **两级弹窗真机实证（ch7，写进本文件下方）**：`openCloudAdmissionModal(lane,idx,offerId)` 填 `#admissionModalBody`、给 `#admissionModal` 加 `.show`；offerId 是运行时 uuid(rebuild 变)，pre 里用 setInterval 从 detail 的 school-card onclick 现抓现开。下载钮渲染条件 = `letter_paid_at 非空 && (letter_uploaded_at||jw202_uploaded_at)`(源 L5544 `_renderCloudAdmissionBody`)——只上传不付款不出钮；pt-07/08/09 基线已 `letter_paid_at`，故置态只补 uploaded_at 即现钮。

## 成片进度表（正式成片，本机 ~/guide/dist/partner/，不进 git/桶）
| 章 | 横 | 竖 | 趟 |
|---|---|---|---|
| 2 | ✅ | ✅ | trip7 |
| 4 | ✅ | ✅ | trip8（动作章首杀）|
| 5 | ✅ | ✅ | **trip9** |
| 7 | ✅ | ✅ | **trip9** |
| 8 | ✅ | ✅ | **trip9** |
| 9 | ✅ | ✅ | trip5 |
| 10 | ✅ | ✅ | trip6 |
| **1 / 3 / 6** | — | — | **待录** |
| 开场OP/片尾ED/拼接/海报/缩略图/联络表 | — | — | 待章节齐 |

## 下一趟（剩 ch6 / ch3 / ch1 + 收尾）
每章铁律：开工先 verify 16/16（不过先 `bash jobs/JOB-GP1/rebuild-partner.sh`）→置态→录 land+port→复位(rebuild)→verify。
- **ch6 多校录取（pt-06 Bilal，两盲 offer）= ⚠图纸与现实冲突·需业主拍板（铁律14-P2）**。trip9 已把 ch6 全链真机 + 源码读通（只读探针，零写库，verify 16/16 复核过）：
  - **可录的真流程（无冲突）**：6-1 卡「2 offers」→开 detail；6-2 两张盲 `.school-card.school-card-clickable`(offerId=运行时 uuid，本轮 09c33dd3…/16e071e9…，rebuild 变；pt-06 本轮=viewReferredStudent(3))，盲态显 专业/学费/奖学金/截止、**校名遮成 SCH-1AD6C8 / SCH-8E561C**；6-3 比两份奖学金；6-4 `#admissionModal` 内 `.cloud-offer-unlock`(onclick=`_cloudAdmUnlock()`)→**揭晓 Demo University**；6-7 `.btn-offer-accept`(onclick=`_cloudAdmRespond('accepted')`)接受。unlock 与 accept **都写 pt-06 自家 offer**，录后必 rebuild 复位(verify #5 两盲 pending)。
  - **冲突点 = 6-5/6-6「优惠码 MAXHOUSE → 应付 ¥0」**：真机里 **unlock 不收款**——按钮原文 L5642「解锁查看（内测：仅状态翻转，不收款）」，`_cloudAdmUnlock`→`_agentUnlockOffer`(只翻 unlocked_at)→重开弹窗揭晓校名，**全程无付款单、无优惠码框**。¥0 的 MAXHOUSE 优惠码是**另一条链**：录取通知书付款 `_cloudAdmPay()`(L5107)→`#paymentModal`→`#couponInput` 打 MAXHOUSE→`SCHOOL_PAYMENT_AMOUNT=3000` 减到 ¥0；而这颗「💳 Pay now to view & download」钮(L5637)**只在 offer 已接受且学校已出通知书、尚未付款时**才出现。pt-06 是盲 offer，没接受、没通知书 → **在 pt-06 身上根本到不了优惠码 ¥0 画面**。全库唯一有 ¥0 MAXHOUSE 付款单的是 pt-07(verify #7，但已 letter_paid，付过了，不会再弹付款框)。
  - **→ 请业主三选一**：(A) ch6 去掉 ¥0 优惠码镜，只录「盲比→解锁揭晓→接受」，¥0「不收费」卖点改放别处/片尾；(B) 授权把 6-5「¥0 优惠码」镜改录在**真付款链**上——临时把某生(建议 pt-07)的 `letter_paid_at` 置空(Demo Agency 自家 offer，录后 rebuild 复位)，开其录取通知书付款弹窗真打 MAXHOUSE→¥0，接受学生主角切成 Nilufar(旁白不点名，弹窗聚焦金额/优惠码)；(C) 改分镜。**CC 不自修、不自造付款界面(铁律14-P2+铁律15)**，等拍板。
- **ch3 提交第一个学生（pt-01 草稿 Ayesha）= 向导开法待实证**：trip9 探针实测 `openReferralForm`/`_wzOpen`/`_wzNext`/`openAddStudentModal` 都在，但 `_wzGoStep`/`_wzSubmit`/`submitReferral` **undefined**；直接 `openReferralForm()`**没弹出可见 modal**(`.modal-bg.show`=空)，`[id^=wz]` 元素在但 hidden。下趟先定位向导真开法(可能需先进 pt-01 草稿上下文或别的入口)、步进(`_wzNext` 连点?)、各步 input id、提交函数。之后打字填表+传 SPECIMEN+提交→真 app_no(写 pt-01)；MRZ 合成护照 OCR 不触发则按 storyboard §2.6 预授权改静态高亮。录后 reset 回草稿。
- **ch1 注册从零**：harness 现**强制登录 guide_partner**，ch1 需「不登录」路径——rec.mjs 要加 `--nologin` 分支或 ch1 专用录法(gateShowRegister→注册→资质打字→传 2 SPECIMEN→审核中→切 guide_partner 录 APPROVED)。先删 guide-pt-reg 账号(注册才走得通)，录完 rebuild 重建 reg。**最复杂，建议放最后或留待下趟**。
- 齐后：开场 OP / 片尾 ED（gp1-overlays）→ 整片拼接 full/quick → 联络表 → 写 `JOB-GP1-03.md` + `SUMMARY-GP1-A.md`(REVIEW=yes) + `~/mh-verify/rGP1-STOP.txt`=WAIT_REVIEW 停审。

## 两级弹窗 / ch7 实证索引（供下趟 ch6 复用）
- 学生卡→`viewReferredStudent(N)`，N=列表显示序(非 pt 号)。本轮基线真机映射：N=2 Nilufar(pt-07)、N=3 Abena(pt-08)、N=4 Dmitri(pt-09)、N=8 Rahim(pt-03)。**rebuild 后顺序可能变，录前用 DB 名字→viewReferredStudent 现对**。
- detail 内 `[onclick*="openCloudAdmissionModal"]` = school-card，eval 其 onclick 开 `#admissionModal`。
- 下载钮 `.admission-doc-btn-letter` / `.admission-doc-btn-jw`；建档进度 `.offer-progress`(含 ✓Enrollment)；揭晓胶囊 `.admission-id-tag--unlocked`；校名联系块 `_p130_ContactBlock`(含 @gmail，靠 MASK TreeWalker 盖)。

## 合规
未改五端 HTML(只读 partner v184)；未碰 JOB-G*/GS*/GP0 原文件；未碰 R2/CF；未起后台任务；node 走代理。写入仅 ch7 置态(pt-07 letter / pt-08 jw202，指既有 specimen/ 对象)，**录后 rebuild 清回基线 verify 16/16 PASS**；ch5/ch8 零 DB 写入(前端暂存/示意)。画面脱敏：真帧复验 + 程序 @gmail 探测双证，本轮全章 ✅ 无泄露。本轮**不推主仓库**、未写 NEED_PUSH；主仓库仅点名 commit 自己的文件。
