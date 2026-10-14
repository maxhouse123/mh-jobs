# 请示单 · 挡内部目录已就绪，请 Claude 审核后由业主用卡推送；附 G-9 dry-run 结果

停点：GP2-00（停点一）。日期：2026-10-14（第 1 趟）。CC 未碰线上 / R2 / Cloudflare / 未推主仓库。

## 做了什么
1. 盘清部署：Cloudflare Pages + Git 集成、输出目录＝仓库根、push 自动部署；现有配置只有 `_headers`，无 `_routes.json`/`_redirects`；现有 Functions 只有 `share/` 与 `guide/school/`。
2. 分类顶层「该公开 / 不该公开」，curl 抽查线上现状：`/jobs/**`、`/supabase/**`、`/migrations/**`、`/tools/**`、`/.claude/**`、`/.gitignore`、根级 `selftest-*.mjs`、`gen-audit-1C.mjs` **现在就线上 200（泄露）**。
3. 建挡法 `functions/_middleware.js`（新文件，仅此一个）：对 11 个内部顶层目录 + 11 个根级散落文件一律返回品牌 404，公开路径 `next()` 放行。为何用根中间件而非逐目录函数：`.claude` 点目录逐目录函数挡不住、散落文件逐个建函数易漏，单文件更完整（决定账 D-GP2-1-3）。
4. 本机 `wrangler pages dev` 逐条验证：**16 条内部路径全 404、所有公开页/资源/`share` 全 200**，被挡路径返回品牌 404 页非文件内容。截图在 `~/mh-jobs/shots/GP2/local/`。
5. G-9 `cleanup-apply.sh --dry-run`（只读）：`GUARD_OK delete=34 (pub=28 priv=6) bytes=202784780`、24h 保护 0——与预期 pub=28 priv=6 一致。

## 要业主的卡做什么（逐条）
> 关键背景：挡法提交 `d26edb1` 叠在 66 条既有未推提交（JOB-GP1 等）之上；`jobs/` **现在就在线上泄露**（既有洞），挡法是在同一次原子部署里关掉它，无新增暴露窗口。

**① 推挡法并验（把挡法送上线）**
- 原生终端挂代理后：
  ```
  cd /Volumes/Dev/MAXHOUSE && git fetch origin
  git log origin/main..HEAD --oneline | head          # 过目：顶部应是 9c086a5 / d26edb1 / e236a6a
  git push origin d26edb1:main                         # 推到挡法这一笔(含其下 66 条 JOB-GP1 + GP2-00a)，原子部署、挡法随之生效
  ```
- 说明：挡法 `d26edb1` 在提交栈里位于 JOB-GP1 之上，`push d26edb1:main` 会把其下所有提交一并送上线，但挡法在**同一个 Pages 部署**里同时生效 → 关掉既有 `jobs/` 洞、新上线的 `jobs/` 内容立即被 404 挡住，**无净新增暴露**。
- 若坚持「挡法严格单独先上线」：改为 cherry-pick 挡法到 origin/main 作为唯一新提交推送（会让后续 `git push origin main` 需处理分叉）——CC 可另备步骤，但推荐上面的原子方案。等 1~2 分钟部署。

**② 验线上**（挂代理 curl，`-L`）
- 应 **404**：`/jobs/QUEUE-G8.md`、`/supabase/functions/_shared/cors.ts`、`/migrations/0069_offer_live_unique.sql`、`/tools/audit_refs.py`、`/.claude/commands/recon.md`、`/.gitignore`、`/selftest-OP.mjs`、`/gen-audit-1C.mjs`、`/docs/`、`/scripts/backup-db.sh`、`/tests/README.md`、`/shots/`、`/assist/logo-blue.jpg`、`/promo-video/`、`/CLAUDE.md`、`/.env.example`。
- 应 **200**：`/`、`/partner-portal/`、`/student-portal/`、`/school-portal/`、`/admin-portal/`、`/reviewer-portal/`、`/guide/student/`、`/guide/school/`、`/vendor/tesseract/tesseract.min.js`、`/share/`。

**③ 推其余本机提交**（挡法已验 404 后）
  ```
  git push origin main                                 # 送上 9c086a5(截图工具) 及今后 JOB-GP2 提交
  git log origin/main..HEAD --oneline                  # 应为空
  git status                                           # 应 clean（别的线的未跟踪文件不算）
  ```

**④ G-9 收尾**（挡法与内容都上线、且本机 dry-run = `GUARD_OK` pub=28 priv=6 时）
  ```
  cd /Volumes/Dev/MAXHOUSE && bash jobs/JOB-G9/cleanup-apply.sh --apply
  ```
  删 34 个被顶替旧对象（pub 28 + priv 6），脚本自带守卫 + 删后复验。

**⑤ 装 done 裁决重启循环**：`jobs/JOB-GP2/RULING-<日期>-gp2-00-done.md`，循环重启后 CC 接 GP2-01。

## 怎么验（上线后）
见 ②。另：挡法上线后 CC 可只读 curl / 无头浏览器复验，并写进下趟回执。

## 万一不对怎么退
- 公开页被误挡 / 任一公开路径非 200：`git revert d26edb1` 后 `git push origin main` 回滚挡法（只回滚这一个文件，不影响其它提交），线上恢复原状；CC 据现象修 denylist 再来。
- 挡法不生效（内部仍 200）：多半是 Pages 未重新构建 Functions，重推触发部署；仍不行则回 CC 查 `functions/` 是否被 `_routes.json` 排除（现无该文件）。

## 相关文件
- 挡法：`functions/_middleware.js`（提交 d26edb1）
- 回执：`~/mh-jobs/JOB-GP2-00.md`、本请示单副本 `~/mh-jobs/JOB-GP2-NEEDS_OWNER_DECISION-<ts>.md`
- 截图：`~/mh-jobs/shots/GP2/local/`
- 决定账：`jobs/JOB-GP2/DECISIONS.md`（D-GP2-1-3）
