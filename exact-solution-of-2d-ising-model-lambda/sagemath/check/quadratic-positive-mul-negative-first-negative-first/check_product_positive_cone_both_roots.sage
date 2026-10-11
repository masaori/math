# 対象ラベル: claim_quadratic_positive_mul_negative_first_negative_first
# 二次数体の両根について実際の積の正規形から表示を取り出し、正錐所属を検査する。
from pathlib import Path
load(str(Path(__file__).with_name('_prelude.sage')))
T = PolynomialRing(QQ, 'z')
z = T.gen()
K = NumberField(z*z-2, 'theta')
theta = K.gen()
checked = 0
for c, b, cp, bp, a, ap, A, B, V, D in rational_cases():
    for root_sign in (QQ(1), QQ(-1)):
        s = K(root_sign)*theta
        xi, eta = K(a)+K(b)*s, K(ap)+K(bp)*s
        value = xi*eta
        actual_a, actual_b = QQ(value[0]), QQ(value[1])/root_sign
        assert (actual_a, actual_b) == (A, B)
        assert actual_a > 0 and actual_b < 0 and 2*actual_b*actual_b < actual_a*actual_a
        checked += 1
assert checked == 199712
print(f'RESULT: PASS ({checked} products, both quadratic roots)')
