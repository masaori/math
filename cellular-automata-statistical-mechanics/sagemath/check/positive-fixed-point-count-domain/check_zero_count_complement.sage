# 対象ラベル: claim_positive_count_domain_iff_period_divides
# 式ペア・判定: Z_n(F)=0 ⇔ 実現周期のいずれも n を割らない
# プログラミングによる検証: 有限集合・ZZ・QQ の厳密計算。R/C 脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

tested = 0
for name, mapping, n in rows():
    lengths = realized_lengths(mapping)
    assert (count_fixed(mapping, n) == 0) == (not any(n % d == 0 for d in lengths)), (name, mapping, n)
    tested += 1
assert tested > 0
print("map-exponent pairs checked:", tested)
print("RESULT: PASS")
