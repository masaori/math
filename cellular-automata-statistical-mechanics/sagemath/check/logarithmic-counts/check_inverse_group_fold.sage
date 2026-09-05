# 対象ラベル: claim_prime_vectors_abelian_group
# 式ペア・判定: 0=0_Λ(p)
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for a, p in vector_rows():
    expr1 = ZZ(0)
    expr2 = coefficient({},p)
    assert expr1 == expr2
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
