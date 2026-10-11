# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 積の表示：s*s=2 だけを用いる QQ 係数の多項式商環で係数を検査する。
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
T = PolynomialRing(R, 'z')
z = T.gen()
S = T.quotient(z*z-2, names=('s',))
s = S.gen()
xi = S(a)+S(b)*s
eta = S(ap)+S(bp)*s
actual = (xi*eta).lift()
assert actual[0] == a*ap+2*(b*bp)
assert actual[1] == a*bp+b*ap
print('RESULT: PASS (quadratic quotient representation)')
