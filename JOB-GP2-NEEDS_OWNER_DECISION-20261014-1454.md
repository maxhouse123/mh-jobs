# 请示单（停点一·第 2 版）· 挡内部目录 + _routes.json 已就绪，请 Claude 审核后由业主用卡推送

本单覆盖上一版（已被改名 -resolved）。承 RULING-20261014b-gp2-00-routes。做完 GP2-00b，停在停点一。

## 一、要上线的挡法提交（只这两个文件，分两笔，业主卡先单推这两个文件）
挡法涉及的文件只有两个：`functions/_middleware.js`、`_routes.json`。它们分散在两笔提交里：
- `d26edb1` —— 新建 `functions/_middleware.js`（挡法首版，第 1 趟）
- `a850824` —— 新建 `_routes.json` + 改 `functions/_middleware.js`（加取证头 x-mh-block:1，第 2 趟）

> 说明：`a850824` 之后、这两笔之间还夹着 `9c086a5`（截图工具，jobs/JOB-GP2/）、`590354e`（上版请示单）等**非挡法**提交。按 RULING 七节，业主卡应「在临时工作区从 origin/main 起，只拣出这两个文件的最终内容做一笔提交」单独送上线，而不是把中间那些 jobs 提交也一起推。两个文件的**最终内容** = 本机当前工作区（HEAD=a850824）的 `functions/_middleware.js` 与 `_routes.json`。

本机校验已过：`_routes.json` JSON 合法（version1 / include24 / exclude空 / 末尾通配符 / «100 条）；`functions/_middleware.js` `node --check` 通过。

## 二、线上怎么验（业主卡照此逐条验，先验挡法再推其余）
设 `S=https://www.maxhouses.net`。

1. **内部路径 → 404 且带 `x-mh-block: 1`**（挑 4 条代表，全要过）：
   ```
   curl -sI "$S/jobs/QUEUE-G8.md"   | grep -iE '^HTTP|^x-mh-block'   # 期望 404 + x-mh-block: 1
   curl -sI "$S/supabase/config.toml" | grep -iE '^HTTP|^x-mh-block' # 期望 404 + x-mh-block: 1
   curl -sI "$S/CLAUDE.md"          | grep -iE '^HTTP|^x-mh-block'   # 期望 404 + x-mh-block: 1
   curl -sI "$S/.env.example"       | grep -iE '^HTTP|^x-mh-block'   # 期望 404 + x-mh-block: 1
   ```
   （若 HEAD 被 CF 处理得看不到头，改用 `curl -s -D - -o /dev/null "$S/jobs/QUEUE-G8.md" | grep -iE '^HTTP|^x-mh-block'`。）

2. **公开页/资源 → 200 且不带 `x-mh-block`**：
   ```
   for p in / /partner-portal/ /student-portal/ /school-portal/ /admin-portal/ /reviewer-portal/ /guide/student/ /favicon.ico; do
     echo -n "$p "; curl -s -D - -o /dev/null "$S$p" | grep -iE '^HTTP/|^x-mh-block' | tr '\n' ' '; echo
   done
   # 每条期望 2xx（首页 200）且这一行里看不到 x-mh-block
   ```

3. **/share/ 与 /guide/school/ 仍经各自函数**（不能只看 200）：
   ```
   curl -s "$S/guide/school/admin/api/ping"
   # 期望原样回 {"error":"forbidden","reason":"access_required"}（403）——这是 guide/school 中间件验 Access 的专有响应；
   # 若回品牌 404 页或带 x-mh-block，说明 /guide/school/* 被挡法误吞，停止、回退。
   curl -s -D - -o /dev/null "$S/share/og-brand.png" | grep -iE '^HTTP/|^content-type'
   # 期望 200 image/png（share 函数透传），且无 x-mh-block。
   ```

4. 线上验过 1~3 全绿后，再推本机攒下的其余 JOB-GP1 / JOB-GP2 提交；最后才 `--apply` G-9（见三）。

## 三、G-9 尾巴（业主卡最后一步，CC 只跑过 dry-run）
本机 `bash jobs/JOB-G9/cleanup-apply.sh --dry-run` 原样结果：
```
GUARD_OK delete=34 (pub=28 priv=6) bytes=202784780
protected_24h still holding: 0 pub
```
与预期 public=28 private=6 一致。**仅当业主卡再跑一次 dry-run 仍是 GUARD_OK、pub=28、priv=6 时**，才 `--apply`。数字不符就停、不 apply。

## 四、回退法
- 挡法推错 / 误挡公开页：业主卡在临时工作区把 `_routes.json` 删除、`functions/_middleware.js` 还原为 origin/main 上一版（或整体 `git revert` 那一笔挡法提交），推上去即恢复「无挡法」原状（内部目录会重新可公开，但不影响五端口与公开页）。
- 单文件级回退：只删 `_routes.json` → 恢复 Pages 自动路由（函数作用域回到全站 /*，挡法仍生效，只是没有作用域优化）；只还原 `functions/_middleware.js` → 挡法失效但路由优化仍在。
- G-9 若 `--apply` 后发现误删：G-9 自带的保护/清单在 `jobs/JOB-G9/`，按该线自身的回滚说明处理（本线不碰 R2）。

## 五、本机已知事实（供审核）
本机 `wrangler pages dev` 3.114.17 **不认 `_routes.json`**（对所有路由都跑函数）——判据：裸 `/jobs`（不被 `/jobs/*` 匹配）本机仍 404+x-mh-block。故 `_routes.json` 的作用域裁剪**只能在线上（第二节第 2、3 条）验**：公开页不带 x-mh-block 即证它们未经函数。挡法本身（第二节第 1 条）与 _routes.json 无关，本机已逐条验过。

做完本单结束本趟，循环停。等业主卡装 `RULING-<日期>-gp2-00-done.md` 重启循环，接 GP2-01。
