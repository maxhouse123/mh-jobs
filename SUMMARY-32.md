PUSH_OK=yes

# SUMMARY-32 · 第三十二轮收官 · 学校报名对接（在华学生 + 学校端详情三态 + 桌面启动器）

本轮六包（32-00…32-05）全做完、闸全绿。CC 只 add+commit，**主仓库未推**——请业主收官用卡1241 推送（`PUSH_OK=yes` = 已认证可推）。本轮**零迁移、零 SQL 执行、无需手贴任何 SQL**。

## 一、要业主推的（主仓库本地领先远端 6 笔，全是本轮 JOB-32-xx，正常）
用卡1241 的四段式推：①`git log origin/main..HEAD --oneline`（应见下面 6 笔）②`git push origin main` ③推后 `git log origin/main..HEAD` 应空 ④`git status` 应 clean。
- `f75d736` 32-00 脚本入仓（旧态红 R1-R4 + 线上走查 + 图纸），无代码改动
- `eacc535` 32-01 共用组件 v1.2
- `819ac0d` 32-02 student v405 + partner v175
- `a1385ed` 32-03 school v244
- `bedcdac` 32-04 admin v241
- `28a10f5` 32-05 桌面启动器 tools/robot-launcher/

## 二、版本 / md5 账（本轮产物）
| 文件 | 版本 | md5 |
|---|---|---|
| school-portal/maxhouse-school-portal-v244.html | v244（新） | e54daa24bcb130c72c66c686916bc93f |
| student-portal/maxhouse_student_portal_v405.html | v405（新） | 1defc4e19ab7eab8da1bcfbaf0c82bfc |
| partner-portal/maxhouse-partner-portal-v175.html | v175（新） | 1923451f9eff0629c9443f2e6edf7bde |
| admin-portal/maxhouse-admin-portal-v241.html | v241（新） | ef2c81332301a12599915dfff0bd547c |
| assets/mh-filing-form-v1-2.js | v1.2（新） | c763ec607311840a77ca3f0afdc9e4d5 |
| assets/mh-filing-form-v1-1.js | v1.1（不动） | ab42a271b41ca3fb037fdefc164f169f |
| assets/mh-filing-form-v1.js | v1（不动） | fa84e1299159c8c9ed7bb3e4050bb0a3 |
| reviewer-portal/maxhouse-reviewer-portal-v46.html | v46（**审核端不动**） | 2d4269e9c570481b99b95d70a3691082 |
| tools/robot-launcher/{install.sh, launcher.command.tmpl, selftest.sh, README.md} | 新增 4 文件 | — |

四件套（文件名/头注/[VER]探针/index 重定向）每端齐；新函数前缀 `_v244`/`_v405`/`_v175`/`_v241`；v1、v1.1 原样保留可回滚。

## 三、六包一句话
- **32-00** 开工核对 8 基线 md5 全对（含机器人 v3）；线上只读走查（stuA 无待建档任务、partner1 无已接受 offer 推荐卡、schX=SCH-1AD6C8 非武纺）；旧态 R1-R4 先跑红 9/9、0 报错。
- **32-01** 共用组件 v1.2：在华信息段（附录 B 原文四语、条件显隐即时、签证有效期须晚于今天）+ `missingFor` 统一出口（与机器人 v3 checkPack 对齐）+ 红字点名 `err.requiredField` + HSK 显示（hsk1-6→「HSK N」/hsk7-9→「HSK 7-9」/none→「无」）；`__selftest` 33/33；R1 转绿 4/4；v1/v1.1 md5 不变；零外部资源。
- **32-02** student v405 + partner v175：各仅改引用到组件 v1.2（+[VER]+版本探针补正）；两端外部语言包一字未动；N1 零移除；green 6/6。
- **32-03** school v244：学生详情「本校录取状态」三态（已发录取 / 已在候选池未发录取「打开该任务发录取」/ 都没有保持现状），消掉「已在任务里却叫先进任务」的矛盾；台账超 60 秒先重载再画；中英 6 新键；green 10/10；N1 零移除。
- **32-04** admin v241：导出建档包加 `student.in_china_now` + `china` 块（附录 A-2）+ `meta.json`（附录 A-3，启动器读）；「缺 N 项」统一改用 `MHFilingForm.missingFor`；在华 + 不在华两份桩包机器人 `check` 都 PACK_OK；green 10/10；N1 零移除。
- **32-05** 桌面双击启动器 tools/robot-launcher/：install.sh（装机器人 v3+recon+占位到 ~/MAXHOUSE-robot，幂等/覆盖前备份，playwright 优先软链）+ launcher.command.tmpl（七步全流程，支持 --dry）+ selftest.sh + README；临时 HOME 自测 19/19，绝不碰真桌面；真装真跑留卡1242。

## 四、闸账
- 旧态先红→绿：R1（组件在华段/红字点名/HSK/missingFor）R1 转绿 4/4；R2（school 三态）转绿；R3（admin 导出 china+meta+缺项）转绿；R4（机器人 check）两桩包 PACK_OK。
- N1 授权移除：本轮清单为空；四端 + 组件任何 id/handler/function 消失 = 闸红——**零移除**（各包已逐条对照，function 计数不减）。
- P3 静态断言：随各包 tests/ 脚本入仓，全绿。
- 闸8 无头真渲染：组件 __selftest 33/33（四语零裸键零 undefined）；student/partner 在华桩出段、非在华桩不出、提交带 `p_data.china`；school 三态各显对应态、按钮目标任务号正确、台账过期重载一次；admin 两桩包 PACK_OK + 缺签证号时缺项计入且导出灰。中英/四语各遍过。
- 组件 __selftest：33/33，0 报错。
- 机器人 PACK_OK：在华 + 不在华两份桩包均 PACK_OK。
- shell-lint：install.sh / launcher.command.tmpl / selftest.sh 过 `bash -n` + `zsh -n`（本机无 shellcheck，已在自测输出注明以此二者代替）。
- secret-scan：启动器目录零密码/密钥/邮箱/token。
- 迁移零破坏：本轮零迁移、零 SQL。

## 五、32-00 线上走查表（业主最关心的 MH-BPEA7Q 在最后）
| 走查项 | 看到了什么 |
|---|---|
| 学生端 stuA | 真登成功；当前**没有待建档任务**，无「补充信息表」入口 → 表单/材料/联想三项 N/A；0 报错 |
| 中介端 partner1 | 真登成功；**未见带「补充信息表」按钮的已接受 offer 推荐卡** → N/A；0 报错 |
| 学校端 schX 学校代码 | 页头 = **SCH-1AD6C8**，**不是武纺 SCH-BFB599** |
| 学校端 录取办理方式设置 | 未见该区块（该校 filing_system 可能=none 或本机门态，属该校数据非故障）；0 报错 |
| ★ **MH-BPEA7Q 学校端现在显示什么** | **本轮无法复核 = N/A**。本机 accounts.json 的 schX=SCH-1AD6C8，而 MH-BPEA7Q 那条 offer 是**武纺 SCH-BFB599** 发的；学校端台账只拉本人 school_members 名下的 offer（policy `school_own_offers_select`），故 SCH-1AD6C8 账号**看不到也不显示** MH-BPEA7Q（它不属这个学校）。要肉眼确认那条从「未发 Offer」变成「学生已同意」，**需用武纺登录账号**在线上看（业主本人，或把武纺账号加进 accounts.json 再跑一次走查）。写卡的 Claude 的 P1 只读 SQL 结论仍是：该 offer sent_by=SCH-BFB599、student_response=accepted，截图里的「未发 Offer」很可能拍于发 offer 之前。 |

## 六、未放行清单（本轮没做/留后续）
1. **启动器真装真跑**：写真 ~/Desktop、开真 Chrome、连真报名网站——本轮只在临时 HOME `--dry`（图纸 §0.5 授权），留业主收官后**卡1242**。
2. **MH-BPEA7Q 武纺账号线上复核**：需武纺登录态，本机账号非武纺，留业主本人看（见上表）。
3. **导出数据血缘缺口**（32-04 记）：`filing_url` / `school_name_zh` 的真值 RPC 未返，导出时走了兜底默认值（`https://wtu.17gz.org` / 占位名）；真值接通留**第三十三轮**。
4. **机器人两点观察**（32-05 记，均未改只读机器人）：① `check` 恒退出码 0，只以输出文字 PACK_OK/PACK_PROBLEMS 判定（启动器已按此抓文字）；② 机器人 CLI 自调用靠 `import.meta.url === path.resolve(argv[1])`，调用路径有软链祖先（/tmp、/var）时命令行静默不跑（启动器已用 `pwd -P` 消符号链规避）。建议后续轮把机器人自调用判定改成比 realpath。

## 七、给业主的 6 条验收（先推再看）
1. **学生端**：「目前在中国」为是的学生，补充信息表多出「在华信息」一段；签证类型选 X1 要填签证号 / 有效期 / 签发地，选「无签证」这三项消失，选「居留许可」多出「居留事由」。
2. **学生端**：只填一位家属就提交，红字写「请填写：家庭成员 2 · 姓名」。
3. **学生端**：平台已有信息块里 HSK 显示成「HSK 2」这种写法（不再是 hsk2）。
4. **学校端**：已在任务里但没发录取的学生，详情写「已在任务 ADM-…（任务名）的候选池」并有「打开该任务发录取」，点了直接进该任务。
5. **学校端**：已发过录取的学生，详情显示录取状态与所属任务。
6. **管理端**：在华学生导出的建档包里有在华信息；zip 里多一个 meta.json。
（启动器真体验：装机（卡1242）后双击桌面图标、按三步操作走一遍。）

## 八、第三十三轮建议包（必含项）
- **at0086 机器人**：等武昌理工开放报名后做（当前该校未开放）。
- **AI 预填补充信息**：用已有材料自动预填补充信息表，减少人工。
- **平台常量真值**：把导出兜底的 `filing_url` / `school_name_zh` 等接通真值 RPC（销 32-04 数据血缘缺口）。
- **启动器用满一周后的体验返修**：收集运营真用反馈再打磨。
- **历轮挂账**：机器人自调用改 realpath 判定；REJ-1（拒绝弹窗类别选择器）；admin LS 桥收敛；配额云化；quota 视图 mock；withdraw_referral 线上 400 复现定性；vendor/tesseract LFS 评估。
