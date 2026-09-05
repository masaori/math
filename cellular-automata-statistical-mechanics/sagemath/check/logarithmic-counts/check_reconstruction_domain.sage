# 対象ラベル: def_prime_vector_reconstruction
# 式ペア・判定: 復元の正値性・既約性・空台・台の外の零
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for a in vectors(2):
    r, s = numerator_product(a), denominator_product(a)
    assert r in ZZ and s in ZZ and r > 0 and s > 0
    assert gcd(r,s) == 1
    assert reconstruct(a) in QQ and reconstruct(a) > 0
    assert coefficient(logarithm(reconstruct(a)),ZZ(13)) == 0
    if not a:
        assert r == s == 1
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
