#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# JOB-5-04 中介端登录门: 邮箱补 autocapitalize/autocorrect/inputmode(原缺, 真有大写bug) + 密码补属性 + 眼睛. base v147 -> v148. 零迁移.
import sys, os, hashlib
SRC="/Volumes/Dev/MAXHOUSE/partner-portal/maxhouse-partner-portal-v147.html"
DST="/Volumes/Dev/MAXHOUSE/partner-portal/maxhouse-partner-portal-v148.html"
BASE_MD5="d311af409d7430305f83f1ba651cb8d5"
FORCE=("--force" in sys.argv)
def stop(m): print("STOP: "+m); sys.exit(1)
raw=open(SRC,"rb").read()
got=hashlib.md5(raw).hexdigest()
if got!=BASE_MD5: stop("基底 md5 不符 期望=%s 实测=%s"%(BASE_MD5,got))
print("闸1 基底 md5 OK: "+got)
if os.path.exists(DST) and not FORCE: stop("产物已存在, 重跑加 --force")
text=raw.decode("utf-8")

EYEBTN=('<button type="button" onclick="_v148TogglePw(this)" aria-label="Show password" tabindex="-1" '
'style="position:absolute;right:12px;top:50%;transform:translateY(-50%);background:none;border:0;cursor:pointer;font-size:18px;line-height:1;padding:0;opacity:.6">\U0001F441</button>')

TOGGLEFN=(
"  function _v148TogglePw(btn){\n"
"    try{ var inp = btn.parentNode.querySelector('input'); if(!inp) return;\n"
"      if(inp.type==='password'){ inp.type='text'; btn.textContent='\U0001F648'; }\n"
"      else { inp.type='password'; btn.textContent='\U0001F441'; }\n"
"    }catch(e){}\n"
"  }\n")

edits=[
 ("E0 email 补 autocapitalize/autocorrect/spellcheck/inputmode",
  '<input class="gate-input text" id="emailInput" type="email" placeholder="you@agency.com" autocomplete="username" />',
  '<input class="gate-input text" id="emailInput" type="email" placeholder="you@agency.com" autocomplete="username" spellcheck="false" autocapitalize="none" autocorrect="off" inputmode="email" />'),
 ("E1 password 补属性 + 眼睛包裹",
  '      <input class="gate-input text" id="pwdInput" type="password" placeholder="••••••••" autocomplete="current-password"\n'
  "             onkeydown=\"if(event.key==='Enter')doLogin()\" />",
  '      <div style="position:relative">\n'
  '      <input class="gate-input text" id="pwdInput" type="password" placeholder="••••••••" autocomplete="current-password" autocapitalize="none" autocorrect="off" style="padding-right:44px"\n'
  "             onkeydown=\"if(event.key==='Enter')doLogin()\" />\n"
  '      '+EYEBTN+'\n'
  '      </div>'),
 ("E2 眼睛切换函数(插在 doLogin 前)",
  "  async function doLogin(){",
  TOGGLEFN+"  async function doLogin(){"),
 ("E3 console [VER] v148",
  "  console.info('[VER] partner portal v147 (称谓统一: 标签「理由（可空）」、按钮「保存理由」)');   // 卡1029",
  "  console.info('[VER] partner portal v148 (手机登录门: 邮箱补 autocapitalize/autocorrect/inputmode, 密码补属性 + 眼睛显隐)');   // JOB-5-04"),
]

for label,old,new in edits:
    c=text.count(old)
    if c!=1: stop("锚点非唯一 [%s] = %d"%(label,c))
    print("闸2 锚点唯一 OK: "+label)
for label,old,new in edits:
    text=text.replace(old,new,1); print("已改: "+label)

def c(s): return text.count(s)
checks=[
 ("email autocapitalize=none ==1", c('id="emailInput" type="email" placeholder="you@agency.com" autocomplete="username" spellcheck="false" autocapitalize="none" autocorrect="off" inputmode="email"'),1),
 ("password autocapitalize=none ==1", c('id="pwdInput" type="password" placeholder="••••••••" autocomplete="current-password" autocapitalize="none" autocorrect="off"'),1),
 ("眼睛函数定义 ==1", c("function _v148TogglePw(btn){"),1),
 ("眼睛函数调用 >=1", 1 if c("_v148TogglePw(this)")>=1 else 0,1),
 ("autocapitalize=none >=2", 1 if c('autocapitalize="none"')>=2 else 0,1),
 ("console [VER] v148 ==1", c("console.info('[VER] partner portal v148"),1),
 ("旧 [VER] partner portal v147 归 0", c("[VER] partner portal v147"),0),
]
for label,actual,expect in checks:
    if actual!=expect: stop("闸3 [%s] 实测=%d 期望=%d"%(label,actual,expect))
    print("闸3 OK: %s (=%d)"%(label,actual))
open(DST,"w",encoding="utf-8").write(text)
print("产物 md5: "+hashlib.md5(text.encode("utf-8")).hexdigest())
print("ALL PATCH-SIDE GATES PASS")
