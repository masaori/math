# 対象ラベル: claim_positive_count_domain_iff_period_divides
# 式ペア・判定: 周期点の最小周期の存在 ⇔ Len_F の元の存在
# プログラミングによる検証: 有限集合・ZZ・QQ の厳密計算。R/C 脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

tested = 0
for name, mapping, n in rows():
    data = orbit_data(mapping)
    periodic = periodic_set(mapping)
    lengths = realized_lengths(mapping)
    assert (any(any(n == k*data[x][1] for k in range(n + 1)) for x in periodic)) == (any(any(n == k*d for k in range(n + 1)) for d in lengths)), (name, mapping, n)
    tested += 1
assert tested > 0
print("map-exponent pairs checked:", tested)
print("RESULT: PASS")
