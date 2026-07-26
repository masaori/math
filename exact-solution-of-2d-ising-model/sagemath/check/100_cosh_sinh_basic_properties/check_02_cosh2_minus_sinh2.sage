# ---------------------------------------------------------
# <cosh_sinh_basic_properties> (2)  (cosh x)^2 - (sinh x)^2 = 1
#
# 独立経路: 左辺は定義式 (exp(x)±exp(-x))/2 から 300 bit で組み上げて自乗し差を取る。
# 右辺は定数 1。本文の証明は (cosh-sinh)(cosh+sinh)=exp(-x)exp(x)=exp(0)=1 と
# 積へ分解する経路なので、こちらは分解せず素朴に自乗して引く経路を取る。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

RF = RealField(300)

XS = [RF(v) for v in [
    0, 1/1000, -1/1000, 1/3, -1/3, 1, -1, 2, -2,
    2*0.4407, -2*0.4407, 2*0.2, 2*0.813, 2*0.05, 2*0.1,
    2*0.4, 2*0.8, 2*1.2, 2*0.3, 2*1.7, 2*5.0, 2*10.4, -2*10.4,
    15, -15, 25, -25,
]]

rep = CheckReport("<cosh_sinh_basic_properties> (2) cosh^2 - sinh^2 = 1")

for x in XS:
    c = (RF(x).exp() + RF(-x).exp()) / 2
    s = (RF(x).exp() - RF(-x).exp()) / 2
    rep.close(float(c**2 - s**2), 1.0, "cosh^2-sinh^2=1 @x=%s" % x)
    # 本文の分解経路（積の形）も別途確認する
    rep.close(float((c - s) * (c + s)), 1.0, "(cosh-sinh)(cosh+sinh)=1 @x=%s" % x)

rep.finish()
