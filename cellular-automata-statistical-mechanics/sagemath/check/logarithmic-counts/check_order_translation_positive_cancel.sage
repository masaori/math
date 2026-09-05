# 対象ラベル: claim_prime_logarithm_ordered_group
# 式ペア・判定: 正の因子の消去
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for a, b, c in vector_triples():
    expr1 = reconstruct(a)*reconstruct(c) <= reconstruct(b)*reconstruct(c)
    expr2 = reconstruct(a) <= reconstruct(b)
    assert expr1 == expr2
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
