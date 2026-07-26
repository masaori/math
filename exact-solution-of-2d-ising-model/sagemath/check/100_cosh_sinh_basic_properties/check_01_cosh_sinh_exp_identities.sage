# ---------------------------------------------------------
# <cosh_sinh_basic_properties> (1)
#   cosh x - sinh x = exp(-x) > 0,  cosh x + sinh x = exp(x) > 0
#   特に cosh x > 0 かつ cosh x > sinh x
#
# 独立経路: 左辺は cosh, sinh の**定義式**
#   cosh x = (exp(x)+exp(-x))/2, sinh x = (exp(x)-exp(-x))/2
# を 300 bit の実数演算で組み上げたもの。右辺は exp(-x), exp(x) をそのまま評価したもの。
# 「定義から exp へ戻る」という主張そのものを、両辺別々に数値評価して突き合わせる。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

RF = RealField(300)

def cosh_def(x):
    return (RF(x).exp() + RF(-x).exp()) / 2

def sinh_def(x):
    return (RF(x).exp() - RF(-x).exp()) / 2

# 臨界点まわりの結合定数（2 K_1 の形で現れる）も含めて広く取る
XS = [RF(v) for v in [
    0, 1/1000, -1/1000, 1/2, -1/2, 1, -1, 2, -2,
    2*0.4407, -2*0.4407, 2*0.2, 2*0.813, 2*0.05, 2*0.1,
    2*0.4, 2*0.8, 2*1.2, 2*0.3, 2*1.7, 2*5.0, 2*10.4, -2*10.4,
    20, -20, 30, -30,
]]

rep = CheckReport("<cosh_sinh_basic_properties> (1) cosh-sinh=exp(-x), cosh+sinh=exp(x)")

for x in XS:
    c = cosh_def(x)
    s = sinh_def(x)
    rep.close(float(c - s), float(RF(-x).exp()), "cosh-sinh=exp(-x) @x=%s" % x)
    rep.close(float(c + s), float(RF(x).exp()), "cosh+sinh=exp(x) @x=%s" % x)
    rep.truth(RF(-x).exp() > 0, "exp(-x)>0 @x=%s" % x)
    rep.truth(RF(x).exp() > 0, "exp(x)>0 @x=%s" % x)
    rep.truth(c > 0, "cosh>0 @x=%s" % x)
    rep.truth(c > s, "cosh>sinh @x=%s" % x)

rep.finish()
