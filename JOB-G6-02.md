# JOB-G6-02 回执 · 人脸库封顶 + 装脸工具全就位（已彩排未执行）

日期 2026-10-09 ｜ 无人值守 ｜ 本机 Mac mini（真卷 /Volumes/Dev/MAXHOUSE）

## 一句话
这趟先把造脸库按业主裁决**抓满上限 1800 张并收口**（G6-01 完工），再把「给 50 名演示学生换 AI 人脸」的**整套装脸工具做好、拿假执行彩排过**（G6-02 的脑力活全干完）。真正往数据库写那一下**这趟没做**——留到下一趟一条命令跑掉，因为写库 + 之后要真登三端查头像（闸 H）是个大活，不在趟尾赶工，免得写一半被掐断。所有半成品都已 commit 到本机，下一趟从「执行」接着干即可。

## 做了什么（大白话）

### 一、造脸库收口（G6-01 完工）
1. **续抓到上限**：按裁决 R2，从上次的 950 张继续抓来源 A（thispersondoesnotexist，走代理，每 1.5 秒一张，按图去重），分三批 950→1230→1520→**1800 张即停**（裁决定的上限）。三批**全程 0 失败、0 重复**。
2. **每批只看最暗 25%**（裁决 R3 省时法）：每批约 70 张最暗的脸拼成联络表，一张张肉眼挑非洲男。三批共新挑出**非洲男 4 张**（编号 39522 / 1713f / 77786 / f3803；77786 偏混血带帽，已注明）。
3. **非洲男累计 9 张**（上限内能挑到的就这些）。按真实演员需求算，非洲男要 **12** 个（不是原估的 10——因为赤道几内亚等也归了非洲）。差的 **3 张**按裁决 R4 用「肤色最近的现有脸」顶上（见下「分派」）。
4. 脸库账本 `faces-catalog.json`：原图 1800 张、可用脸 **201** 张，各组对照真实需求**除非洲男外全部达标**。
5. 总联络表 `~/mh-jobs/shots/G6/faces-final.jpg`（201 张可用 AI 脸，按组排，可公开）。

### 二、人脸分派（G6-02 第 1 步，确定性）
- `make-faces-map.py` 按国籍归外貌组（南亚/东亚/非洲/中东北非/拉美/欧洲中亚）、对齐性别、**一人一张脸绝不复用**，生成 `faces-map.json`，50 人全覆盖。
- **46 人精确匹配**；**4 人按裁决 R4 用最近肤色（最深的中东北非 D 组男脸）顶上、标 `near_group`**：
  - 巴基斯坦男 1 人（南亚男真脸只有 4，需 5）；
  - 非洲男 3 人（加纳 / 赤道几内亚 / 尼日利亚；非洲男真脸 9，需 12）。
  - 被顶上的都在 `faces-map.json` 里标了 `near_group:true` 和 `near_from`。
- 50 张脸已**裁成 512×512、压到 ≤50KB、去 EXIF**，存 `guide/dist/faces/`（不入 git）。

### 三、装脸工具（G6-02 第 2 步，已就位、已彩排、**未真跑**）
- **改库前留底**（裁决 R5）：只读导出 50 人现有 photo 行 → `avatars-before.json`（32 张真照片 / 8 张占位 PDF / 10 人没有 photo 行；全部 is_test=true）。要回滚照这份还原即可。
- `sb-upload-faces.mjs`：用 supabase-js 把脸传进 `student-documents` 桶，键 `<学生id>/photo/g6-face-NNN.jpg`。**只新增、幂等**（已存在就跳过），**绝不覆盖学生真照片对象**。钥匙脚本自读 .env，CC 不碰。
- `assign-faces.sql`：`begin;…commit;`，每条都带 **is_test=true 守卫**（有一条非测试学生就整笔报错回滚）；40 人改 photo 行指针（file_path→新脸、file_name→photo.jpg、size_kb→新值），10 人没 photo 行的新增一条（照演示生样式）。幂等可重跑。
- `assign-faces.sh`：先传脸、再跑 SQL，一条命令。
- **彩排凭证**（把 commit 换成 rollback 真跑了一遍，零写入）：

```
BEGIN
INSERT 0 50      <- 50 人进临时表
DO               <- is_test 安全检查通过（没报错）
UPDATE 40        <- 40 人改指针
INSERT 0 10      <- 10 人新增行
 pointing_g6_update | inserted_g6 | cast_total
                 50 |          10 |         50   <- 50 行全指向新 AI 脸
ROLLBACK         <- 什么都没真写
```

## 闸的真实结论
- **G6-01 进度闸**：可用脸 201 ≥ 需求（各组达标；非洲男 9 真脸 + 3 近肤色顶上 = 12 满足）。✅
- **闸 H（头像）**：**仍是红**——脸还没真装进库（这趟只彩排没写）。下一趟真跑 `assign-faces.sh` 后，再真登三端查，才能转绿。
- **闸 Q（二维码）**：源级已绿（上一趟 G6-03 已改），成片阶段 G6-04/05 复核。

## 还差什么 / 下一趟从哪接（重要）
1. **真执行装脸**：`bash jobs/JOB-G6/assign-faces.sh`（先传 50 张脸，再真跑 SQL，预期 UPDATE 40 + INSERT 10）。这是**真写库**，但：只碰 is_test 学生、只改头像那一列、有留底可回滚、已彩排。
2. **挂 rebuild**：把 `bash jobs/JOB-G6/assign-faces.sh` 加到 `jobs/JOB-G0/rebuild.sh` 和 `jobs/JOB-GS2/rebuild-school.sh` 末尾；被荐生重建后 id 会变，按申请编号/邮箱重对（faces-map 目前按 student_id，重建后需刷新）。
3. **跑闸 H 转绿**：真登学校端（guide_sch3/schX 浏览池+候选池+档案）、学生端（guide_stuA 顶栏+档案）、中介端（guide_agent 被荐生详情），数「首字母回落 0 / 非人脸图 0 / AI 脸数=在屏头像数」。rebuild 两次后再跑仍绿。
4. 之后进 **G6-04/05**（只重录有头像的章 + 片尾重拼）、**G6-06**（上线真验）。

## 这趟改了哪些文件
- 主仓库（JOB-G6 开头，**只 commit 未推**，共 4 笔）：
  - `356913b` faces-catalog.json（抓满 1800 收口）
  - `07a1ce7` make-faces-map.py + faces-map.json（分派）
  - `18ce26d` avatars-before.json + 两个只读 probe（留底）
  - `fa7d0b5` assign-faces.sql/.sh + sb-upload-faces.mjs + faces-upload-plan.json + 两个 probe（装脸工具）
- 本机不入 git：`~/mh-verify/faces-work/`（raw 1800 张等）、`~/mh-verify/g6node/`（supabase-js）、`guide/dist/faces/`（50 张裁好的脸）。
- 钥匙/密码/业主码：一律没进回执、没进仓库；.env 由脚本自读，CC 没读。

## 下一步一句话
下一趟：`bash jobs/JOB-G6/assign-faces.sh` 真装脸 → 挂 rebuild → 跑闸 H 转绿 → 进 G6-04/05。
