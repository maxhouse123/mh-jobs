#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# JOB-5-04 学生端手机登录门: 邮箱 inputmode=email + 密码 autocapitalize/autocorrect + 眼睛显隐. base v379 -> v380. 零迁移.
import sys, os, hashlib
SRC="/Volumes/Dev/MAXHOUSE/student-portal/maxhouse_student_portal_v379.html"
DST="/Volumes/Dev/MAXHOUSE/student-portal/maxhouse_student_portal_v380.html"
BASE_MD5="fcc25c682798e650b236b14103ec76b9"
FORCE=("--force" in sys.argv)
def stop(m): print("STOP: "+m); sys.exit(1)
raw=open(SRC,"rb").read()
got=hashlib.md5(raw).hexdigest()
if got!=BASE_MD5: stop("基底 md5 不符 期望=%s 实测=%s"%(BASE_MD5,got))
print("闸1 基底 md5 OK: "+got)
if os.path.exists(DST) and not FORCE: stop("产物已存在, 重跑加 --force")
text=raw.decode("utf-8")

EYEBTN=('<button type="button" onclick="_v380TogglePw(this)" aria-label="Show password" tabindex="-1" '
'style="position:absolute;right:12px;top:50%;transform:translateY(-50%);background:none;border:0;cursor:pointer;font-size:18px;line-height:1;padding:0;opacity:.6">\U0001F441</button>')

TOGGLEFN=(
"function _v380TogglePw(btn){\n"
"  try{ var inp = btn.parentNode.querySelector('input'); if(!inp) return;\n"
"    if(inp.type==='password'){ inp.type='text'; btn.textContent='\U0001F648'; }\n"
"    else { inp.type='password'; btn.textContent='\U0001F441'; }\n"
"  }catch(e){}\n"
"}\n")

edits=[
 ("E0 email 加 inputmode=email",
  '<input type="email" class="gate-input" id="gateEmail" autocomplete="username" spellcheck="false" autocapitalize="none" autocorrect="off"\n',
  '<input type="email" class="gate-input" id="gateEmail" autocomplete="username" spellcheck="false" autocapitalize="none" autocorrect="off" inputmode="email"\n'),
 ("E1 password 加属性 + 眼睛包裹",
  '      <input type="password" class="gate-input" id="gatePassword" autocomplete="current-password"\n'
  '        placeholder="Your password" data-gate-i18n-attr="placeholder:gate.pwPlaceholder" />\n',
  '      <div style="position:relative">\n'
  '      <input type="password" class="gate-input" id="gatePassword" autocomplete="current-password" autocapitalize="none" autocorrect="off" style="padding-right:44px"\n'
  '        placeholder="Your password" data-gate-i18n-attr="placeholder:gate.pwPlaceholder" />\n'
  '      '+EYEBTN+'\n'
  '      </div>\n'),
 ("E2 眼睛切换函数(插在 gateLogin 前)",
  "async function gateLogin(ev) {",
  TOGGLEFN+"async function gateLogin(ev) {"),
 ("E3 console [VER] v380",
  "console.info('[VER] student portal v379 (忘记密码补齐后半段: 发信带回跳地址 + 重置令牌落地屏, 失败说真实原因, 四语)');   // 卡972",
  "console.info('[VER] student portal v380 (手机登录门: 邮箱加 inputmode=email, 密码加 autocapitalize/autocorrect + 眼睛显隐切换)');   // JOB-5-04"),
]

for label,old,new in edits:
    c=text.count(old)
    if c!=1: stop("锚点非唯一 [%s] = %d"%(label,c))
    print("闸2 锚点唯一 OK: "+label)
for label,old,new in edits:
    text=text.replace(old,new,1); print("已改: "+label)

def c(s): return text.count(s)
checks=[
 ("email inputmode=email ==1", c('id="gateEmail" autocomplete="username" spellcheck="false" autocapitalize="none" autocorrect="off" inputmode="email"'),1),
 ("password autocapitalize=none ==1", c('id="gatePassword" autocomplete="current-password" autocapitalize="none" autocorrect="off"'),1),
 ("眼睛函数定义 ==1", c("function _v380TogglePw(btn){"),1),
 ("眼睛函数调用 >=1", 1 if c("_v380TogglePw(this)")>=1 else 0,1),
 ("autocapitalize=none >=2", 1 if c('autocapitalize="none"')>=2 else 0,1),
 ("console [VER] v380 ==1", c("console.info('[VER] student portal v380"),1),
 ("旧 [VER] student portal v379 归 0", c("[VER] student portal v379"),0),
]
for label,actual,expect in checks:
    if actual!=expect: stop("闸3 [%s] 实测=%d 期望=%d"%(label,actual,expect))
    print("闸3 OK: %s (=%d)"%(label,actual))
open(DST,"w",encoding="utf-8").write(text)
print("产物 md5: "+hashlib.md5(text.encode("utf-8")).hexdigest())
print("ALL PATCH-SIDE GATES PASS")
