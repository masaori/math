# 対象ラベル: claim_quadratic_positive_mul_mixed_signs
# 帰属: QQ、QQ 多項式、二次代数。浮動小数点を使わない。
from pathlib import Path
import sys

source_path = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (source_path.parent / '_prelude.sage').is_file():
    source_path = Path(sys.argv[0]).resolve()
__file__ = str(source_path)
load(str(source_path.parent / '_prelude.sage'))
# 本文: 積の表示
# 式: rep_s(xi*eta) = (a*ap+2*(b*bp), a*bp+b*ap)
# 根拠: claim_quadratic_multiplication_representation
T = PolynomialRing(qpm_polynomials, 'z')
z = T.gen()
S = T.quotient(z*z-2, names=('theta',))
theta = S.gen()
checked = 0
for root_sign in (QQ(1), QQ(-1)):
    s = S(root_sign)*theta
    xi, eta = S(a)+S(b)*s, S(ap)+S(bp)*s
    actual = (xi*eta).lift()
    actual_a, actual_b = actual[0], actual[1]/root_sign
    assert (actual_a, actual_b) == (a*ap+2*(b*bp), a*bp+b*ap)
    checked += 1
qpm_record('representation_multiplication', checked, 'quadratic quotient; both roots')
