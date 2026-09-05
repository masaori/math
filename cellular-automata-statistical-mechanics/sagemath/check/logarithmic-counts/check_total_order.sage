# 対象ラベル: claim_prime_logarithm_ordered_group
# 式ペア・判定: 反射・反対称・推移・全比較
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for a, b, c in vector_triples():
    assert less_equal(a,a)
    assert less_equal(a,b) or less_equal(b,a)
    if less_equal(a,b) and less_equal(b,a):
        assert a == b
    if less_equal(a,b) and less_equal(b,c):
        assert less_equal(a,c)
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
