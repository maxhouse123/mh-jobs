# JOB-G2-01 回执 · R2 上传工具 + 上传

**一句话结论：四语成片、海报、整片、速览、og 图、清单，全部 271 MB 共 123 个文件都传上 R2 了，每个都在公开网址上真能取到。**

## 做了什么
1. **新建上传工具 `jobs/r2-put.sh`（+ 帮手 `jobs/r2-put.mjs`）**，仿 db-run.sh：
   - 由脚本自己读仓库根 `.env` 的 R2_*（我这边从不读 .env，也不打印任何密钥）。
   - 两种上传方式：你的 .env 里 `R2_UPLOAD_MODE=wrangler`（已用浏览器登录的那套），本次全程走它；若写的是 s3 但令牌不通/网络不通，会自动改用 wrangler 并在日志注明。
   - 按文件后缀自动设类型：mp4→video/mp4、webp→image/webp、png→image/png、json→application/json、vtt→text/vtt。
   - 缓存策略：带版本号路径（v1/…）下的文件设「一年 + immutable」，`manifest.json` 设「5 分钟」。
   - 每传一个就经公开域名 `media.maxhouses.net/<key>` 发一次 Range 请求核对（200/206 + 大小一致）。
   - 安全阀：只允许往 `guide/` 前缀写；除 `guide/_probe/` 外任何删除一律拒绝；并发 4、失败重试 2。
   - 自带 `--selftest`（守卫自检，6 项 ALL_PASS：拒非 guide 前缀、拒根目录、拒 .. 穿越、拒删普通对象、拒删非 guide、放行 guide 写与 _probe 删）、`--rm-probe`（只清 _probe）、`--check`（只报可用模式）。

2. **上传**：`guide/dist/` 整棵树 → `guide/student/v1/`。
   - 结构：`v1/<语言>/cNN.mp4`、`full.mp4`、`quick.mp4`、`cover.webp`、`posters/cNN.webp`，外加 `v1/manifest.json` 与 `v1/og.png`。
   - **结果：122 个对象 + og 单传 = 123 个，全部 OK，总体积 271.4 MB，0 失败。**

3. **清理**：传前的单文件连通性测试对象（guide/_probe/_g2test.json）已删，确认公开网址返回 404。线上 `guide/_probe/` 无其它可枚举残留（wrangler 无对象枚举接口；如你的就绪探针留了别的 _probe 对象，可用 `bash jobs/r2-put.sh --rm-probe guide/_probe/<名字>` 指名删）。

## 关卡判据（全过）
① 清单里每个文件 Range 200/206、长度一致 ✅（123/123）
② 公开域名随机抽 8 个（en/c07.mp4·zh/c12.mp4·ru/full.mp4·fr/quick.mp4·en/posters/c01.webp·zh/cover.webp·og.png·manifest.json）全 206 且 Content-Type 正确 ✅
③ 总体积 271.4 MB（写入回执）✅
④ `--selftest` 对非 guide/ 前缀与删除请求全部拒绝 ✅
附：抽查头部确认 `en/c07.mp4` = `cache-control: public, max-age=31536000, immutable` + `accept-ranges: bytes`；`manifest.json` = `public, max-age=300`。

## 红线自查
只往 `guide/` 前缀写、不删任何已有对象（只删了自己的测试探针）；不读 .env、不打印密钥；未碰 R2 以外的外部服务。

## 主代码仓库提交
`b8e22ce JOB-G2-01 …`（仅两个工具文件；成片不入库）。主仓库 push 在 G2-03 闸全过后一并做。
