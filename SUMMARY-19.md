# SUMMARY-19 · 第十九轮收官（只修不加）

**主题**：中介端登录角色门 + 温和提醒改真卡片 + 审核端未登记类型入册 + 慢件服务端计时上屏 + 学生端判词引号随语言 + 历史存储孤儿只查证。

**范围纪律**：只修不加；未改共用查看器 / 学校端 / 管理端 / precheck-ai / admin-doc；未碰 .env；未造新测试账号；未改真实用户数据或角色；watermark-doc 不加保温定时任务；本轮全程无迁移；**CC 未推主仓库、未部署**。全程无 `~/mh-verify/r19-STOP.txt`（无「必须停」触发）。

---

## 一、三端新版本 + md5（主仓库 7 笔 commit，待业主卡1145 推）

| 端 | 版本 | 文件 md5 | 备注 |
|---|---|---|---|
| partner | **v167**（19-01） | `89b4acf172d4f43996467b7096c8cb9b` | 登录角色门 + 温和提醒改真卡片 |
| reviewer | **v45**（19-03，线上目标） | `c2cf1f26cffee208cfba137b430b18a6` | 中途 v44（19-02）`8f8707a85de12d56fd0dd4c4cc1a8408` |
| student | **v398**（19-04） | `e88cc0044c44db113054ac633ad64549` | 材料名判词引号随界面语言 |
| admin | v218（不动） | 基线 `73b36f0a…` | 本轮未改 |
| school | v234（不动） | 基线 `a2d2e593…` | 本轮未改 |

**云函数**：watermark-doc **v34**（19-03，源码 md5 `adf9c70efdf51ca0ea3148c99570b3f2`）—— **改源码不部署，待业主卡1146 跑 `jobs/JOB-19-03/deploy-watermark.sh`**（JWT 校验保持开）。precheck-ai / admin-doc / send-invite-email 一行未改。

## 二、迁移清单

**本轮全程无迁移。** 19-00 探针② 已证：`public.partners` 表无 INSERT 策略、学校角色 uid 本就插不进自己的 partners 行（与业主观察的 `save_my_draft` 被 42501 拒一致）→ 19-01 迁移 0213 的触发条件为假 → **0213 不写**（角色门是纯 UX/纵深防御补丁）。**下一空号仍 0213。**

## 三、待业主手贴的 SQL 清单

**无。** 本轮无迁移、无 SQL Editor 手贴卡。

## 四、每包一句话

- **19-00**：基线 md5/HEAD 全等核对 + 六探针（角色表示/partners 策略/showFormWarning 调用点/未登记类型/watermark 静态分段/存储孤儿）+ 五处旧病真页面复现（先红）+ N1 旧版按钮清单；探针②证 0213 不需写。
- **19-01**：partner **v167** 登录角色门 `_v167Gate`（有 partners 行放行 / 无任何角色放行进注册 / 有他端角色→signOut 拒，四语「该账号无中介权限」；登录+注册+会话恢复三路都走门）+ 温和提醒 `showFormWarning` 从红条垫片改**真琥珀卡片**（白底/左上⚠/×/停 5.5s/不被 toast 顶/后卡不覆盖）；`_r2SoftToast` 两处并入同卡。三层自验 35/35 + 真页面全绿 + N1 空。
- **19-02**：reviewer **v44** 未登记类型 `studyProof/studyPlan` 入册（**选甲**：只写 zh、与现役 25 条同构；zh 脚本从 admin v218 `ADM7_KINDS` 按码原样读出「在读证明」「学习计划」，icon 照 school 上传格，cls/minutes 照现役最近类）+ 预取日志标签 `[v42]→[v44]`。P3 13/13。
- **19-03**：watermark-doc **v34**（源码，待部署）加专用计时头 `x-mh-wm-timing`（各段 ms + `boot_age` 冷启动龄 + `served`）+ `console.log [wm v34 timing]`，修 19-00⑤ 唯一可修点（四级角色判定串行→并行），(b)(c) 无空间照实说明；reviewer **v45** 在每份查看 `[v43] wm timing` 旁加打 `[v45] wm server` 行（直读/云函数两路读头，无头打 `server=n/a`）。鉴权/派单/缓存语义一字未改，JWT 保持开。
- **19-04**：student **v398** `_v706HumanizeIssue` 材料名判词包裹引号随界面语言 —— **zh「」/ en ""/ ru «»/ fr « »**；只改这一处引号，替换范围/判词/判定不动、不重判。真页面四语红绿全过 + P3 22/22 + N1 空。
- **19-05**：历史存储孤儿**只查证、出清单、不删**——`student-documents` 桶 1 个 `recommendation` 槽合成件（第十六轮 online-walk 残留，documents 含软删皆无此路径）+ 只读确认 SQL。
- **19-06**（本收官）：从 18-06 复制改出线上走查（五端 [VER] 目标改第十九轮 + schX 登中介端拒绝测试 + partner1 Q1 卡片有才判），本机对现役线上单探一遍如实记录（4 条红均为「未推送前」预期红）+ 写本 SUMMARY-19。

## 五、每项「旧版红 → 新版绿」截图文件名

| 包 | 红（旧版/现役） | 绿（新版） |
|---|---|---|
| 19-01 角色门 | `shots/19/19-00/A-v166-schX-in-register-RED.png` | `shots/19/19-01/gate-schX-rejected-GREEN.png` / `gate-stuA-rejected-GREEN.png` / `gate-reviewer1-rejected-GREEN.png` / `sessionrestore-schX-ejected-GREEN.png` |
| 19-01 温和提醒卡片 | `shots/19/19-00/B-v166-q1-red-toast-1s.png` | `shots/19/19-01/card-q1-amber-GREEN.png` |
| 19-02 未登记类型标题 | `shots/19/19-02/v43-title-RED.png` | `shots/19/19-02/v44-title-GREEN.png` |
| 19-04 判词引号随语言 | `shots/19/19-04/red-{zh,en,ru,fr}.png` | `shots/19/19-04/green-{zh,en,ru,fr}.png` |
| 19-06 收官线上走查 | `shots/19/walk/schX-partner-login.png`（现役 v166 schX 进空白注册表=预期红） | 业主推送后重跑转绿 |

（19-03 watermark-doc/reviewer v45 为云函数+诊断日志改，无页面视觉件截图；真·30 份线上计时表由业主部署后跑 `wm-timing-probe.mjs` → `~/mh-jobs/JOB-19-03-timing.md` 产出。）

## 六、未放行清单（等业主动作，非本轮遗留缺陷）

1. **主仓库 7 笔 round-19 commit 未推** → 业主卡1145 推（认本文件 `PUSH_OK`）。
2. **watermark-doc v34 未部署** → 业主卡1146 跑 `deploy-watermark.sh`（自带 OPTIONS/401/reviewer1 取件三探针）。
3. **线上真·30 份慢件计时表未产** → 部署后跑 `wm-timing-probe.mjs`。
4. **存储孤儿 1 个未删** → 见第八节，业主手删。

## 七、要业主亲眼看的（推送/部署后线上验收）

1. **学校账号（schX）登中介端被挡**：v167 上线后，用学校账号登中介端 → 停在登录页、四语「该账号无中介权限」、不进任何机构/学生内容（现役 v166 会进空白注册表，见 `schX-partner-login.png`）。
2. **中介端糊图 Q1 提醒是卡片**：选一张糊图触发「这份文件可能被拒」→ 弹出**白底、左上琥珀 ⚠ 图标的卡片、分行、停 5 秒以上、× 能关、不被后续提示顶掉**（非旧红条 2.2s）。
3. **审核端未登记类型标题四语**：队列里 `studyProof/studyPlan` 材料标题显示正式中文名 **「在读证明」/「学习计划」**（审核端本就 zh-only，不再是兜底裸码）。
4. **学生端英文界面旧判词的引号**：切英/俄/法，看无犯罪证明栏那条旧判词的材料名引号随语言（en `""` / ru `«»` / fr `« »`；中文仍「」）。
5. **审核端控制台 `[v45] wm server` 行**（**watermark-doc v34 部署后**）：审核端每份查看在 `[v43] wm timing` 旁多打一行 `[v45] wm server … boot_age=…s served=…`。

## 八、要业主手删的存储路径（19-05，只查证不删）

**1 个孤儿**（`student-documents` 桶）：
```
43668ae4-96b6-4518-9725-0b1ade089e92/recommendation/1789916981387_j0sl_r16-online-synth.png
```
（220489B，上传 2026-09-20；第十六轮 online-walk 合成推荐信残留，`public.documents` 含软删皆无此路径引用 → 纯存储残留，删它不影响任何真实/软删档案。）
- 手删二法：①控制台 Storage → 桶 `student-documents` → `…/recommendation/` → 勾该文件 Delete；②`select storage.delete_object('student-documents','43668ae4-…/recommendation/1789916981387_j0sl_r16-online-synth.png');`
- 删后跑 `jobs/JOB-19-05/confirm-deletion.sql` 见 `remaining_rows=0`。

## 九、第二十轮建议包

1. **watermark-doc 慢件计时结论（承 19-03）**：19-00⑤ 静态分析已证「能修的仅四级角色判定串行→并行（已修）；(b) 缓存命中无多余取件；(c) 图片/PDF 烧录必须整份字节，无流式空间」。**真根因待线上计时表坐实**：业主部署 v34 后跑 `wm-timing-probe.mjs`，看 `boot_age` 是否占大头——**若冷启动占大头，按 §0.10 只落保温建议（EF 预热 / 常驻实例 / 提前签发原件直链绕开渲染），不加保温定时任务**（本轮已守此纪律）。建议列为第二十轮首包。
2. **学生端 zh 词典 `doc.studyProof/doc.studyPlan` 是英文**（19-02 裁决⑤记）：学生端 zh 语言包里这两码存的是英文 `Proof of study / Study plan`，**中文界面的学生看到的是英文栏目名**（审核端 v44 已入正式中文名，学生端本轮未改词典）。建议第二十轮补学生端 zh 词典这两键为「在读证明」「学习计划」。
3. **既有 backlog 顺延**（非本轮范围）：REJ-1（拒绝弹窗缺类别选择器）/ 配额云化 / admin LS 桥收敛 / 三张审计表 outcome 白名单 CHECK / withdraw_referral 线上 400 复现 / vendor tesseract LFS 评估。

---

PUSH_OK=yes
