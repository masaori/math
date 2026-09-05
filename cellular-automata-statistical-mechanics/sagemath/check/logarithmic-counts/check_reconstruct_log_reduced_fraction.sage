# 対象ラベル: claim_prime_logarithm_inverse
# 式ペア・判定: r/s=q
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for q, r, s, K in rational_rows():
    expr1 = QQ(r)/QQ(s)
    expr2 = q
    assert expr1 == expr2
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
