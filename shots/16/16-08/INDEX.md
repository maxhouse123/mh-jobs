# JOB-16-08 shots — reviewer portal R5 icon + revoked/deleted queue-drop (N2 red→green)

All data synthetic (【测试】 names, fake doc ids). Topbar user area masked. Judged by on-screen text/geometry only.

- `icon-v39.png` — v39 baseline: DOCX-TEST-1 (a `.docx` file, doc_type='transcript') shows the RED "PDF" icon badge — follows doc_type, not extension (RED).
- `icon-v40.png` — v40 fix: same row shows a green "DOCX" icon badge — follows the real file extension (GREEN).
- `queue-v39.png` — v39 baseline: after settle, the revoked (REV-TEST-1) and deleted (DEL-TEST-1) rows both REMAIN in the queue (RED).
- `queue-v40.png` — v40 fix: after background prefetch, both REV-TEST-1 and DEL-TEST-1 rows are DROPPED from the queue (GREEN).
- `card-v39.png` — v39 baseline: clicking 查看 on a revoked row shows the OLD generic wording "无权查看(该材料未派给你)" (RED).
- `card-v40.png` — v40 fix: clicking 查看 on a deleted row (captured before prefetch dropped it) shows the human message "🚫 这份材料已被删除，不能再查看" (GREEN); in the final settled run both rows are already dropped by prefetch.
