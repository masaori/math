# 対象ラベル: claim_prime_logarithm_inverse
# 式ペア・判定: R(log q) の有限積への展開
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for q, r, s, K in rational_rows():
    expr1 = reconstruct(logarithm(q))
    expr2 = QQ(prod((p**max(coefficient(logarithm(q),p),0) for p in K),ZZ(1)))/prod((p**max(-coefficient(logarithm(q),p),0) for p in K),ZZ(1))
    assert expr1 == expr2
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
