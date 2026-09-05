# 対象ラベル: def_positive_rational_prime_valuation
# 式ペア・判定: 既約表示と対数の有限台
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for q, r, s, K in rational_rows():
    assert r > 0 and s > 0 and gcd(r,s) == 1
    assert set(logarithm(q)) == K
    for p in PROBE_PRIMES:
        assert coefficient(logarithm(q),p) == valuation(q,p)
        assert min(exponent(r,p),exponent(s,p)) == 0
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
