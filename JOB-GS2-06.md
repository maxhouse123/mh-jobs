# JOB-GS2-06 回执 · （可选）Resend 发信域名验证 —— 本包跳过

日期 2026-10-06 ｜ 无人值守会话

## 结论：跳过（不算失败）
按 QUEUE-GS2 GS2-06 的前置条件：「`.env` 有 `RESEND_API_KEY`，且 `jobs/cf-api.sh` 的令牌有 DNS 编辑权限；任一不满足 → 本包只写跳过原因，不算失败。」

卡1324 的探测结果写在 `jobs/JOB-GS2/precheck.txt`：
```
DNS=no
RESEND_KEY=yes
```

- Resend 钥匙：**有**（`RESEND_KEY=yes`）。
- Cloudflare 令牌的 DNS 编辑权限：**没有**（`DNS=no`）。

因为开通「高校邮箱自助领码」必须往 `maxhouses.net` 加 Resend 要求的 DKIM/SPF/MX 等 DNS 记录，而当前令牌没有 DNS 编辑权限，**无法只加不改地写入 DNS 记录**，所以本包按规矩跳过，没有动任何 Cloudflare / DNS / Resend 设置，也没有发测试邮件。

## 影响（沿用 GS-1 结论，无变化）
- 学校引导页的「高校邮箱自助领码」入口仍按设计降级显示「正在配置中，请联系 MAXHOUSE 领码」，不报错、不崩。
- 要开通自助发信，需要：①给 Cloudflare 令牌加 DNS 编辑权限（或业主在 Cloudflare 面板手动加 Resend 给的几条 DNS 记录）；②再在 Resend 后台把 `maxhouses.net` 验证通过。这两步之一完成 DNS 后，可另起一卡继续 GS2-06 的验证 + 发信自测。

## 边界
全程未动 Cloudflare / DNS / Resend；未创建 `jobs/resend-api.sh`（本包跳过，留到具备 DNS 权限时再按清单做）；未触任何红线。
