# JOB-G6-02 回执 · 把 AI 人脸真装进演示数据（已执行、已验证、已 rebuild 安全化）

日期 2026-10-09 ｜ 无人值守 ｜ 本机 Mac mini（真卷 /Volumes/Dev/MAXHOUSE）

## 一句话
上一趟把装脸工具做好只彩排没真跑；**这趟真跑了**——50 张 AI 人脸真传上去、50 名演示学生的头像在数据库里全部换成了 AI 脸（50/50 已核）。另外把装脸脚本**改成「重建演示数据后脸不会丢」**（rebuild 安全），并挂到两条重建流水线末尾，学校端实测通过。换脸这件事（G6-02）**做完了**。学生端的录制前置「重建流程」里有一步（跟换脸无关）出错了，记在最后当下一趟第一件事。

## 这趟真做了什么（大白话）

### 一、真装脸（50 人全换成 AI 脸）
- 跑 `bash jobs/JOB-G6/assign-faces.sh`：先把 50 张裁好的 AI 脸传进 `student-documents` 桶（每人一张，键 `<学生id>/photo/g6-face-NNN.jpg`，只新增、不覆盖任何真照片），再改数据库里这 50 人的「个人照片」行指针指向新脸。
- 真实输出：
```
UPLOAD done: uploaded=50 skipped(exists)=0 failed=0 total=50
UPDATE 40   <- 40 人原本有 photo 行，改指针
INSERT 0 10 <- 10 人原本没 photo 行，新增一条
 pointing_g6_update | inserted_g6 | cast_total
                 50 |          10 |         50   <- 50 人全部指向 AI 脸
COMMIT
```
- 数据库复查（`_probe-castfaces.sql`）：is_test 学生 50 人、**50 人全有 g6 AI 脸、0 人没照片**。✅

### 二、改成「重建后脸不会丢」（rebuild 安全化，重要）
- **为什么要改**：原脚本把「哪个学生用哪张脸」按学生的 uuid 写死。但演示数据每次重建时，有 **15 名 guide 演示生**（学生 A/B、中介、3 名被荐生、8 名学校演示生）会被删掉重建、换一个新 uuid——按老 uuid 认人就对不上了，脸会丢。
- **怎么改**：
  - `make-stable-map.mjs` 生成 `faces-map-stable.json`：这 15 人改成**按稳定的邮箱别名**认人（如 `guide-sch-05`），另外 35 人 uuid 本来就不变、照旧按 uuid。
  - `assign-faces.mjs`（新）：每次运行**先查当前 uuid**（邮箱别名→当前 uuid），再幂等传脸、再生成 SQL 改**最新那条** photo 行（不再依赖会变的 doc_id）。整笔带 is_test 守卫。
  - 挂到 `jobs/JOB-G0/rebuild.sh`（学生线）和 `jobs/JOB-GS2/rebuild-school.sh`（学校线）末尾，重建完自动装脸。
- **学校端实测证明它真有效**：跑了一遍学校线重建，8 名演示生的 uuid **全变了**（如 guide-sch-05 从 bc038724… 变成 4dff4d0b…），脚本**按邮箱别名把脸自动重装到新 uuid**（输出 `uploaded=8 skipped=42`，`pointing_g6=50/50`）。重建后再查闸 H 学校端，脸照样在。✅

## 闸的真实结论
- **闸 H 学生端**（`gate-H-student.mjs`，真登 guide_stuA）：顶栏头像 `has-image`，真签名图片 URL（不是首字母、不是勾）。✅ 绿
- **闸 H 学校端**（`gate-H-school.mjs` / `probe-sch-identity.mjs`，真登 schX 看候选池+详情）：候选池 7 人里 **6 人显示 AI 脸、1 人显示首字母**。
  - 那 1 人 = **guide-sch-05**。原因查清了：这个演示生的 `submitted_at` 是空的（还没"提交"），产品的**双盲规矩本来就不让学校看未提交学生的照片**（服务端函数 `_mh_school_can_see_student` 挡的）。
  - **这不是换脸的 bug**（换脸前他也是首字母），而且任务书 §0.2(a) 明令我**只能改头像那一列、不能动 submitted_at**，所以这张脸我装不上也不该硬装——这是产品正确行为。回执如实记在这里。其余 6 名学校演示生 + 学生端 + 中介端全是 AI 脸。
- **闸 Q 二维码**（`gate-Q-g6.sh`，源级解码）：学生端、学校端片尾二维码都解出 `https://www.maxhouses.net/`。✅ 绿（G6-03 已做）。

## 还差什么 / 下一趟从哪接（重要）
1. **⚠ 学生端录制前置「重建流程」有一步出错**：这趟也跑了学生线重建（`jobs/JOB-G0/rebuild.sh`）想顺带验收 rebuild 安全，结果**卡在第 4 步 g0-02**——报 `apply: did not advance to step3`（学生 A 的"申请向导"从第 2 步没能进第 3 步）。
   - **跟换脸无关**：换脸数据完好无损（复查仍 50/50 有脸，学生 A 头像照样显示）。这是录制用的演示数据重建脚本里"学生从头走申请向导"那段的老问题（CLAUDE.md 里提过的 0030/0032 申请序列这条脆弱链路）。
   - **影响**：它挡着 **G6-05（学生端录制）**，因为录制要先把学生线演示数据重建好。**下一趟 G6-05 开工第一件事就是查这个**（大概率是向导某一步的 UI/时序，或该版本学生端 portal 的某个按钮/序列）。学校线重建是好的、不受影响。
2. **G6-04（学校端录制）**：按 `chapters-with-avatars-school.json` 只重录 7 章（c05/06/07/08/10/12/13）+ 片尾重拼 + 传私有桶。还没开始。
3. **G6-05（学生端录制）**：重录 9 章（c05~c13）×四语 + 片尾重拼 + 传 R2。还没开始（先解 1）。
4. **G6-06**：上线真验收官。

## 这趟改了哪些文件
- 主仓库（**只 commit 未推**，1 笔，`975651c` JOB-G6-02 开头）：
  - 新增 `jobs/JOB-G6/assign-faces.mjs`、`jobs/JOB-G6/make-stable-map.mjs`、`jobs/JOB-G6/faces-map-stable.json`、`jobs/JOB-G6/gates/probe-sch-identity.mjs`
  - 改 `jobs/JOB-G6/assign-faces.sh`（走新的 rebuild 安全流程）、`jobs/JOB-G0/rebuild.sh`、`jobs/JOB-GS2/rebuild-school.sh`（末尾挂装脸）
- 本机不入 git：`jobs/JOB-G6/node_modules`（软链到 ~/mh-verify/g6node，给 ESM 找 @supabase/supabase-js 用）、`_assign-resolved.sql`（每次自动生成）、几个 `_probe-*.sql`/`_dl-check.mjs` 临时探针、`guide/dist/faces/`（50 张脸）。
- 两处小尾巴（都无害、如实记）：①有 2 名 is_test 学生各还留着一条**更旧的**非 g6 photo 行（docx/pdf，不是当前显示的那条；产品按最新行显示，显示的是 g6 脸）；②学校线重建后，旧 uuid 下的 8 个旧脸对象成了没人引用的孤儿对象（**没删**，符合 §0.3 不删桶对象）。
- 钥匙/密码/业主码：一律没进回执、没进仓库；.env 由脚本自读，CC 没读。

## 下一步一句话
下一趟先修学生线重建 g0-02（向导 step2→step3），修好后进 G6-04 学校端录制、G6-05 学生端录制。换脸（G6-02）与片尾二维码（G6-03）已完成。
