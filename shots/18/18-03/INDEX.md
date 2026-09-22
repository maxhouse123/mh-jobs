# JOB-18-03 partner v165→v166 red→green shots

READ-ONLY verification, real partner1 login. Synthetic (fake) two-name strings — no real PII. No DB write, no upload, no tokens/JWTs/emails.

- `v165-r2-toast-RED.png` — R-2 warning via showFormWarning→showToast: shared `#toast`, red `.error`, 2200ms, displaced by competing toast (RED).
- `v166-r2-softtoast-1s-GREEN.png` — dedicated `#r2SoftToast` at ~1s: amber #FFF7ED / border #F59E0B / text #9A3412, own 8500ms timer (GREEN).
- `v166-r2-softtoast-4s-GREEN.png` — same amber toast still visible at ~4s, not displaced by a competing showToast (GREEN).
- `v165-roster-no-verdict-RED.png` — `_r2RosterHtml('passport',[])`: only ⚠ filename rows, NO two-name verdict line (RED).
- `v166-roster-two-names-GREEN.png` — same call: verdict line with ZHANG SAN / LI SI under the roster title (GREEN).

Gate C (no-spin) is a code-path reproduction (real path is DB-write-gated/forbidden); see gate-partner-result.json evidence.