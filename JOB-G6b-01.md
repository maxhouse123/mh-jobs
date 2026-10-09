# JOB-G6b-01 · 定向补非洲脸与南亚男（**本趟未抓满，可续**）

日期 2026-10-09 ｜ 无人值守 ｜ Mac mini

## 首段先说缺口（重要）
到本趟结束，补抓的脸**还没凑够**：非洲男还缺 **2 张**、非洲女还缺 **1 张**、南亚男还缺 **1 张**。原因＝AI 造脸网站（thispersondoesnotexist）**这趟后半段严重限速**（1.5 秒一张变成好几十秒一张，甚至取不到），所以只从 1800 抓到 **2021 张**（上限是 2400，还剩 379 张的额度没用）。**没有动用「近似组顶替」**——按业主裁决 R4，只有抓满 2400 仍不够才允许顶替，现在还没到上限，所以下一趟继续抓即可。非洲籍学生目前**一个都不会**被配到非非洲脸（本趟不配，等脸齐了在 G6b-02 一次配）。

## 这趟做了什么
1. 续抓来源 A：累计 raw 从 1800 → **2021**（+221 新，progress.txt 已记）。
2. 粗筛（照 R3 只看中央脸区最暗的那批）＋大图复看（每格≥256px、每表12格，脚本 `make-g6b-sheets.py`）：
   - 第一批 200 张里挑出 **2 张合格非洲脸**：
     - `g6b-96be7`（**非洲女**，戴头巾、不戴眼镜，看着26-30）
     - `g6b-0d080`（**非洲/混血男**，头带、不戴眼镜，看着26-30）
   - 第二批（限速只拿到 21 张）：全是欧洲/地中海脸，**0 张**可用非洲或南亚脸。
3. 2 张新脸已裁成 512×512、≤80KB（`crop-faces.py`，实测 35.7KB / 36.5KB），写进 `faces-catalog-v2.json`（现 203 行），新脸大图 `shots/G6b/faces-new.jpg`。

## 目标对照（命令实测）
```
usable C/A now: {"CM":10,"CF":5,"CFyoung(不戴镜18-30)":3,"AM":4}
```
| 组 | 目标 | 现有 | 还缺 |
|---|---|---|---|
| 非洲男 C-M | ≥12 | 10 | **2** |
| 非洲女 C-F | ≥6 | 5 | **1** |
| 　其中不戴镜18-30 | ≥3 | **3** | 已达 ✓（含给 Lina 的候选，但最年轻的看着26-30，若下一趟抓到更年轻18-24的女脸优先给 Lina） |
| 南亚男 A-M | ≥5 | 4 | **1** |

## 闸3判据现状
- 新脸无重复 md5、全部 512×512、≤80KB ✓（2 张）
- 三组计数达标：**未达**（见上表），已按要求在首段写明缺口 ✓

## 下一趟从这里接（G6b-01 续）
1. 原生终端已挂代理即可；直接续跑：`cd ~/mh-verify/faces-work && bash fetch-a.sh 150`（分多段，每段 150 张约 4-6 分钟；若又限速就隔几分钟再来一段，累计别超 2400）。
2. 每段后：`cd /Volumes/Dev/MAXHOUSE && python3 jobs/JOB-G6b/make-g6b-sheets.py`（只筛 inspected.txt 之外的新脸），CC 看 `~/mh-verify/faces-work/g6b-sheets/g6b-*.jpg` 大图挑非洲/南亚脸。
3. 挑中的：`python3 jobs/JOB-G6b/crop-faces.py <md5前缀...>`，再按本趟办法 append 进 faces-catalog-v2.json、刷新 faces-new.jpg，并把这批文件名 append 到 inspected.txt。
4. 凑够 C-M≥12 / C-F≥6(不戴镜≥3) / A-M≥5 即停抓；**抓满 2400 仍不够才**用近似组（非洲缺口取 D/E 里最深肤色，南亚男取 D/E 男脸），并在 G6b-02 回执首段写明人数。
5. 齐了就进 **G6b-02**：写 faces-map-v2.json 重配 50 人（Lina=C-F 最年轻不戴镜；主角 7 人不戴镜；已合格的尽量不动）、跑装脸（新对象 `g6b-face-NNN.jpg`）、换 photo.jpg 素材、mismatch-after=0、闸 H。

## 产物
- 本机：`~/mh-verify/faces-work/raw/`（2021 张）、`inspected.txt`（已含全部已看过的）、`g6b-sheets/`、`guide/dist/faces/` 新增 2 张（这两目录 git 忽略）。
- 主仓库（已 commit 未推）：`jobs/JOB-G6b/make-g6b-sheets.py`、`crop-faces.py`、`faces-catalog-v2.json`（+2脸）、`_new-faces-round1.json`。
- `~/mh-jobs`：本回执 + `shots/G6b/faces-new.jpg`（已推）。
