# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 積の表示を二次商環の両根について、実際の積の正規形から抽出する。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
T = PolynomialRing(R, 'z')
z = T.gen()
S = T.quotient(z*z-2, names=('theta',))
theta = S.gen()
for root_sign in (QQ(1), QQ(-1)):
    s = S(root_sign)*theta
    xi, eta = S(a)+S(b)*s, S(ap)+S(bp)*s
    actual = (xi*eta).lift()
    actual_a, actual_b = actual[0], actual[1]/root_sign
    assert actual_a == a*ap+2*(b*bp)
    assert actual_b == a*bp+b*ap
print('RESULT: PASS (quadratic quotient representation, both roots)')
