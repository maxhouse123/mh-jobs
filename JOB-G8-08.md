# JOB-G8-08（卡1360）· Cloudflare zone 设置收尾

区域：maxhouses.net（zone id 3dad665936b18cbac6ddb6e5f1002c1c）
调用方式：`bash jobs/cf-api.sh`（令牌从主仓 .env 读，CC 不碰钥匙）
时间：2026-10-10（after 时间戳 14:23 UTC）

## 一句话结果
这次令牌权限够了，五项全部读到了。四项本来就是 on（没动），只有一项（智能分层缓存 tiered cache）原来是 off，已 PATCH 成 on 并复读确认。HTTP/3 验证通过。**本来就 on 的四项按要求一个没改。**

## 逐项前后值
| 项 | 之前 | 现在 | 操作 |
|---|---|---|---|
| settings/http3 | on | on | 不动（本来就开） |
| settings/0rtt | on | on | 不动（本来就开） |
| settings/early_hints | on | on | 不动（本来就开） |
| settings/brotli | on | on | 不动（本来就开） |
| cache/tiered_cache_smart_topology_enable | **off** | **on** | PATCH {"value":"on"} 成功 |

注：G8-01（cf-before.json / cf-settings-before.json）当时那把令牌缺 Zone Settings 读写权，所以四项读成 UNKNOWN、tiered cache 改不动。本轮（卡1360）用的令牌权限已足，五项全读到、唯一 off 的那项也改成了。

## 真实命令输出

读（GET）五项：
```
http3        : {"result":{"id":"http3","value":"on","modified_on":"2026-08-22T15:33:55.282728Z","editable":true},"success":true}
0rtt         : {"result":{"id":"0rtt","value":"on","modified_on":null,"editable":true},"success":true}
early_hints  : {"result":{"id":"early_hints","value":"on","modified_on":null,"editable":true},"success":true}
brotli       : {"result":{"id":"brotli","value":"on","editable":true},"success":true}
tiered_cache : {"result":{"editable":true,"id":"tiered_cache_smart_topology_enable","value":"off"},"success":true}
```

改（PATCH tiered_cache_smart_topology_enable，body {"value":"on"}）：
```
{"result":{"editable":true,"id":"tiered_cache_smart_topology_enable","modified_on":"2026-10-10T14:23:04.696498Z","value":"on"},"success":true}
```

改完复读（after，存 JOB-G8-08-cf-settings-after.json）：tiered_cache_smart_topology_enable 已 = on，其余四项仍 on。

## 验证（HTTP/3）
带浏览器 UA 的 `curl -sI https://www.maxhouses.net/guide/student/`，响应头里有：
```
alt-svc: h3=":443"; ma=86400
```
`h3` 在 alt-svc 里 = HTTP/3 已开（这行就是 HTTP/3 的迹象）。Early Hints 的 Link 预连接头 G8-01 已放进 _headers，本轮按卡要求未再改。

## 没做到的 / 权限问题
无。本轮读、改、复读、验证全通，没有 9109 / 10000 无权限报错，不需要重试，也没碰缓存规则、没清缓存。

## 产物
- ~/mh-jobs/JOB-G8-08-cf-settings-before.json（五项 before 原始 JSON）
- ~/mh-jobs/JOB-G8-08-cf-settings-after.json（五项 after 原始 JSON）
- 本回执 ~/mh-jobs/JOB-G8-08.md

主仓库一个文件都没改、没 commit、没 push。
