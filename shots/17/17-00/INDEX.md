# JOB-17-00 · READ-ONLY browser repros — public screenshot index

Round 17 has NOT bumped versions; these repro the CURRENT/OLD versions
(reviewer v40 / school v233 / admin v215 / partner v163 / student v396).
All repros are read/render/observe only — no upload, no submit, no write RPC, no DB mutation.
Doc bytes intercepted via page.route and fulfilled with kit2/pdf/c3.pdf (synthetic 3-page PDF).
Sensitive text masked.

| filename | port / version | what was clicked / triggered | red/green |
|---|---|---|---|
| A-reviewer-v40-pdf-RED.png | reviewer v40 | clicked a 👁 查看 doc-preview button; bytes routed to c3.pdf so a PDF renders | RED (J00: no MHViewer2 2.1.1 toolbar; PDF drawn as raw pdf.js canvas stack; MHViewer2.version=2.0.0) |
| B-reviewer-v40-click-RED.png | reviewer v40 | clicked first 查看 of an UN-prefetched (3rd+) student group | RED (2 fresh doc-byte downloads fired within 3s of click; not instant) |
| B-reviewer-v40-click-GREEN.png | reviewer v40 | clicked a 查看 whose doc WAS already prefetched (1st/2nd group) | GREEN (0 new requests; served from prefetch cache, 286ms) — control/contrast |
| C-partner-v163-copy-GRANTED.png | partner v163 | 已发邀请 list → per-row 复制链接 (clipboard granted) | RED (writeText fires but button label stays 复制链接; no visible 已复制/toast) |
| C-partner-v163-copy-DENIED.png | partner v163 | same, with navigator.clipboard.writeText forced to reject | RED (nothing visible) |
| D-student-v396-mismatch-tone.png | student v396 | soft MRZ name-mismatch warning (showFormWarning, no upload) | AMBER/soft (form-toast variant:warning; wording softened to 提醒 in JOB-16-04) |
| D-partner-v163-mismatch-tone.png | partner v163 | same soft mismatch warning (partner showFormWarning shim) | RED-toned (routes to showToast(...,'error') = .toast.error; asymmetry vs student's amber) |

## Notes
- A-school-v233 / A-admin-v215: SKIP (no write-free stub path to open their PDF preview without a real doc row);
  BUT source confirms BOTH also render PDF via `<iframe>` (school openCloudDocPreview ~L22845, admin _v162AdmDocRender ~L6692),
  i.e. also "no MHViewer2 PDF toolbar" — same structural gap as reviewer, would also be J00 RED once openable.
- D: OCR cannot read a synthetic MRZ locally (no ICAO-MRZ-capable generator in kit2/kit) → mismatch branch not
  reachable from a local synthetic upload → authoritative 先红后绿 deferred to 17-04 gate3 (marked UNRECONFIRMED N2).
