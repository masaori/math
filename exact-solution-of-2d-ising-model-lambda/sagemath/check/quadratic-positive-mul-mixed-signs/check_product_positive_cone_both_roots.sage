# 対象ラベル: claim_quadratic_positive_mul_mixed_signs
# 帰属: QQ、QQ 多項式、二次代数。浮動小数点を使わない。
from pathlib import Path
import sys

source_path = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (source_path.parent / '_prelude.sage').is_file():
    source_path = Path(sys.argv[0]).resolve()
__file__ = str(source_path)
load(str(source_path.parent / '_prelude.sage'))
# 本文: 積の正錐への所属
# 判定: xi*eta in P_s。実際の積の正規形から表示を復元する。
# 根拠: A<0, 0<B, A*A<(2*B)*B と def_quadratic_positive_cone。
T = PolynomialRing(QQ, 'z')
z = T.gen()
K = NumberField(z*z-2, 'theta')
theta = K.gen()
checked = 0
for a, u, cp, bp, b, ap, A, B, C, D in qpm_cases:
    for root_sign in (QQ(1), QQ(-1)):
        s = K(root_sign)*theta
        xi, eta = K(a)+K(b)*s, K(ap)+K(bp)*s
        value = xi*eta
        actual_a, actual_b = QQ(value[0]), QQ(value[1])/root_sign
        assert (actual_a, actual_b) == (A, B)
        assert actual_a < 0 and 0 < actual_b and actual_a*actual_a < (2*actual_b)*actual_b
        checked += 1
assert checked == 134616
qpm_record('product_positive_cone_both_roots', checked, 'quadratic field; both roots')
