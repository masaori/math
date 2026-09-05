# 対象ラベル: claim_prime_logarithm_ratio
# 式ペア・判定: 積の対数公式
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for q, t in product(rationals(), repeat=2):
    expr1 = logarithm(q*(1/t))
    expr2 = add(logarithm(q),logarithm(1/t))
    assert expr1 == expr2
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
