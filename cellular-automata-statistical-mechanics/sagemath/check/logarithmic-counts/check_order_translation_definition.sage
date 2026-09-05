# 対象ラベル: claim_prime_logarithm_ordered_group
# 式ペア・判定: 加法後の順序の定義
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for a, b, c in vector_triples():
    expr1 = less_equal(add(a,c),add(b,c))
    expr2 = reconstruct(add(a,c)) <= reconstruct(add(b,c))
    assert expr1 == expr2
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
