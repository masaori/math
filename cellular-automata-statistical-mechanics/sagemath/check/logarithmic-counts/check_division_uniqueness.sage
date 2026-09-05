# 対象ラベル: claim_prime_vector_integer_division
# 式ペア・判定: 二解の係数等号と非零整数の消去
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for b, c, d in product(vectors(), vectors(), (-3,-2,-1,1,2,3)):
    if scale(d,b) == scale(d,c):
        a = scale(d,b)
        for p in PROBE_PRIMES:
            assert d*coefficient(b,p) == coefficient(a,p)
            assert coefficient(a,p) == d*coefficient(c,p)
            assert coefficient(b,p) == coefficient(c,p)
        assert b == c
    assert (scale(d,b) == scale(d,c)) == (b == c)
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
