# 対象ラベル: claim_positive_count_domain_iff_period_divides
# 式ペア・判定: n>0 より乗数 k=0 を除ける
# プログラミングによる検証: 有限集合・ZZ・QQ の厳密計算。R/C 脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

tested = 0
for name, mapping, n in rows():
    lengths = realized_lengths(mapping)
    assert (any(any(n == k*d for k in range(n + 1)) for d in lengths)) == (any(any(n == k*d for k in range(1, n + 1)) for d in lengths)), (name, mapping, n)
    tested += 1
assert tested > 0
print("map-exponent pairs checked:", tested)
print("RESULT: PASS")
