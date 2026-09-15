#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# JOB-5-04 学校端登录门: 邮箱补 autocorrect/inputmode(原已有 autocapitalize=none) + 密码补 autocorrect + 眼睛. base v228 -> v229. 零迁移.
import sys, os, hashlib
SRC="/Volumes/Dev/MAXHOUSE/school-portal/maxhouse-school-portal-v228.html"
DST="/Volumes/Dev/MAXHOUSE/school-portal/maxhouse-school-portal-v229.html"
BASE_MD5="745c914b8ef4cf5ac6d9a014904084c7"
FORCE=("--force" in sys.argv)
def stop(m): print("STOP: "+m); sys.exit(1)
raw=open(SRC,"rb").read()
got=hashlib.md5(raw).hexdigest()
if got!=BASE_MD5: stop("基底 md5 不符 期望=%s 实测=%s"%(BASE_MD5,got))
print("闸1 基底 md5 OK: "+got)
if os.path.exists(DST) and not FORCE: stop("产物已存在, 重跑加 --force")
text=raw.decode("utf-8")

HEADER=('<!-- maxhouse-school-portal-v229 (2026-09-15): JOB-5-04 手机登录门无障碍 —— '
'邮箱框补 autocorrect="off" + inputmode="email"(原已有 autocapitalize=none), '
'密码框补 autocorrect="off" 并加「眼睛」显隐切换(_v229TogglePw, type=password↔text, 纯 emoji 无新文案/类)。'
'登录门 text-transform 仍 0 处。零迁移。[VER] v228→v229 -->\n')

EYEBTN=('<button type="button" onclick="_v229TogglePw(this)" aria-label="Show password" tabindex="-1" '
'style="position:absolute;right:12px;top:50%;transform:translateY(-50%);background:none;border:0;cursor:pointer;font-size:18px;line-height:1;padding:0;opacity:.6">\U0001F441</button>')

TOGGLEFN=(
"function _v229TogglePw(btn){\n"
"  try{ var inp = btn.parentNode.querySelector('input'); if(!inp) return;\n"
"    if(inp.type==='password'){ inp.type='text'; btn.textContent='\U0001F648'; }\n"
"    else { inp.type='password'; btn.textContent='\U0001F441'; }\n"
"  }catch(e){}\n"
"}\n")

edits=[
 ("H 头注 v229",
  '<!DOCTYPE html>\n<!-- maxhouse-school-portal-v228',
  '<!DOCTYPE html>\n'+HEADER+'<!-- maxhouse-school-portal-v228'),
 ("E0 email 补 autocorrect + inputmode",
  '        autocapitalize="none"\n        placeholder="邮箱 / Email"',
  '        autocapitalize="none"\n        autocorrect="off"\n        inputmode="email"\n        placeholder="邮箱 / Email"'),
 ("E1 password 补 autocorrect + 眼睛包裹",
  '      <input\n'
  '        type="password"\n'
  '        class="gate-input"\n'
  '        id="gatePasswordInput"\n'
  '        oninput="_gateE2S()"\n'
  '        autocomplete="current-password"\n'
  '        spellcheck="false"\n'
  '        autocapitalize="none"\n'
  '        placeholder="密码 / Password"\n'
  '      />',
  '      <div style="position:relative">\n'
  '      <input\n'
  '        type="password"\n'
  '        class="gate-input"\n'
  '        id="gatePasswordInput"\n'
  '        oninput="_gateE2S()"\n'
  '        autocomplete="current-password"\n'
  '        spellcheck="false"\n'
  '        autocapitalize="none"\n'
  '        autocorrect="off"\n'
  '        style="padding-right:44px"\n'
  '        placeholder="密码 / Password"\n'
  '      />\n'
  '      '+EYEBTN+'\n'
  '      </div>'),
 ("E2 眼睛切换函数(插在 gateFormSubmit 前)",
  "function gateFormSubmit(ev){",
  TOGGLEFN+"function gateFormSubmit(ev){"),
 ("E3 console [VER] v229",
  "console.info('[VER] school portal v228 (JOB-3-01: 删死代码 scheduleMockQuotaReview + OFFER_QUOTA_REVIEW_DELAY; [VER] 探针补课到当版)');   // 第三轮硬规矩: 探针随版",
  "console.info('[VER] school portal v229 (手机登录门: 邮箱补 autocorrect/inputmode, 密码补 autocorrect + 眼睛显隐切换)');   // JOB-5-04"),
]

for label,old,new in edits:
    c=text.count(old)
    if c!=1: stop("锚点非唯一 [%s] = %d"%(label,c))
    print("闸2 锚点唯一 OK: "+label)
for label,old,new in edits:
    text=text.replace(old,new,1); print("已改: "+label)

def c(s): return text.count(s)
checks=[
 ("email inputmode=email ==1", c('inputmode="email"\n        placeholder="邮箱 / Email"'),1),
 ("password autocorrect=off ==1", c('autocapitalize="none"\n        autocorrect="off"\n        style="padding-right:44px"'),1),
 ("眼睛函数定义 ==1", c("function _v229TogglePw(btn){"),1),
 ("眼睛函数调用 >=1", 1 if c("_v229TogglePw(this)")>=1 else 0,1),
 ("autocapitalize=none >=2", 1 if c('autocapitalize="none"')>=2 else 0,1),
 ("console [VER] v229 ==1", c("console.info('[VER] school portal v229"),1),
 ("旧 console [VER] school portal v228 归 0", c("[VER] school portal v228"),0),
 ("头注 v229 ==1", c("maxhouse-school-portal-v229 (2026-09-15)"),1),
]
for label,actual,expect in checks:
    if actual!=expect: stop("闸3 [%s] 实测=%d 期望=%d"%(label,actual,expect))
    print("闸3 OK: %s (=%d)"%(label,actual))
open(DST,"w",encoding="utf-8").write(text)
print("产物 md5: "+hashlib.md5(text.encode("utf-8")).hexdigest())
print("ALL PATCH-SIDE GATES PASS")
