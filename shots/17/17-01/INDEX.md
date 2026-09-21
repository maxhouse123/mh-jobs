# JOB-17-01 gate-3 screenshots — MHViewer2 v2.1.1 real-page PDF viewer

All PDFs/images are synthetic (kit2/pdf/c3.pdf 3-page, kit2/demo/synthetic.png) — no real student content.
Element-level shots are the `[data-mhv2="root"]` viewer element only. Full-page shots live under
~/mh-verify/shots/JOB-17/17-01/ (private).

## Per-portal PDF viewer (new versions: reviewer v41 / school v234 / admin v216)
| Portal | fit-width | zoomed | rotated | fit-page | narrow |
|---|---|---|---|---|---|
| reviewer | reviewer-pdf-fitwidth.png / reviewer-new-pdf-01-open.png | reviewer-pdf-zoomed.png / reviewer-new-pdf-12-zoomed.png | reviewer-new-pdf-11-rot.png | reviewer-new-pdf-05-fitpage.png | reviewer-pdf-narrow-en.png / reviewer-pdf-narrow-ru.png (390px) |
| school | school-pdf-fitwidth.png / school-new-pdf-01-open.png | school-pdf-zoomed.png / school-new-pdf-12-zoomed.png | school-new-pdf-11-rot.png | school-new-pdf-05-fitpage.png | (reviewer only) |
| admin | admin-pdf-fitwidth.png / admin-new-pdf-01-open.png | admin-pdf-zoomed.png / admin-new-pdf-12-zoomed.png | admin-new-pdf-11-rot.png | admin-new-pdf-05-fitpage.png | (reviewer only) |

## Corrupt PDF (expectError path)
- reviewer-new-pdf-corrupt-error.png
- admin-new-pdf-corrupt-error.png (extras stay usable on the bad file)

## Image no-regression (same component, data-pdf absent)
- reviewer-image.png / reviewer-img-0[1-7]-*.png
- school-image.png / school-img-0[1-7]-*.png
- admin-image.png / admin-img-0[1-7]-*.png

## Full-page (private, ~/mh-verify/shots/JOB-17/17-01/)
- reviewer-pdf-full.png / school-pdf-full.png / admin-pdf-full.png
