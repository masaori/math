# 対象ラベル: claim_prime_vector_integer_division
# 式ペア・判定: 整数倍の各係数は乗数で割り切れる
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for b, d in product(vectors(3), (-3,-2,-1,1,2,3)):
    a = scale(d,b)
    for p in set(a):
        assert coefficient(a,p) == d*coefficient(b,p)
        assert coefficient(a,p) % d == 0
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
