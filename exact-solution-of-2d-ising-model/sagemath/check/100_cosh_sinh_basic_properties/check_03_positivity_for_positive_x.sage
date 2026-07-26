# ---------------------------------------------------------
# <cosh_sinh_basic_properties> (3)  x > 0 ならば cosh x > sinh x > 0
#
# 反例探索の方針: 主張は x>0 でのみ成り立つ。x<=0 では sinh x <= 0 になり
# 「sinh x > 0」が破れるはずなので、x<=0 でも走査して
#   「x>0 のとき成立し、x<=0 のとき sinh x <= 0 である」
# の両方を確認する。x>0 側だけを見て通すと、主張の仮定 x>0 が効いていることを
# 検証したことにならない。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

RF = RealField(300)

def sinh_def(x):
    return (RF(x).exp() - RF(-x).exp()) / 2

def cosh_def(x):
    return (RF(x).exp() + RF(-x).exp()) / 2

POS = [RF(v) for v in [
    1/10**6, 1/10**3, 1/100, 1/10, 1/2, 1, 2,
    2*0.4407, 2*0.2, 2*0.813, 2*0.05, 2*0.1,
    2*0.4, 2*0.8, 2*1.2, 2*0.3, 2*1.7, 2*5.0, 2*10.4, 25,
]]
NONPOS = [RF(0)] + [-v for v in POS]

rep = CheckReport("<cosh_sinh_basic_properties> (3) x>0 => cosh x > sinh x > 0")

for x in POS:
    c, s = cosh_def(x), sinh_def(x)
    rep.truth(s > 0, "sinh>0 @x=%s" % x)
    rep.truth(c > s, "cosh>sinh @x=%s" % x)

for x in NONPOS:
    s = sinh_def(x)
    rep.truth(s <= 0, "x<=0 では sinh<=0（仮定 x>0 が効いていること）@x=%s" % x)
    # cosh > sinh は x の符号によらず成り立つ（(1) より）
    rep.truth(cosh_def(x) > s, "cosh>sinh は x<=0 でも成立 @x=%s" % x)

rep.finish()
