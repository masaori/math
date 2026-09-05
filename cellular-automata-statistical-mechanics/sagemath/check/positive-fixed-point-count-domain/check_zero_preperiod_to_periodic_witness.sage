# 対象ラベル: claim_positive_count_domain_iff_period_divides
# 式ペア・判定: μ(y)=0 を周期点所属へ置換
# プログラミングによる検証: 有限集合・ZZ・QQ の厳密計算。R/C 脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

tested = 0
for name, mapping, n in rows():
    data = orbit_data(mapping)
    periodic = periodic_set(mapping)
    assert (any(mu == 0 and any(n == k*pi for k in range(n + 1)) for mu, pi in data)) == (any(any(n == k*data[x][1] for k in range(n + 1)) for x in periodic)), (name, mapping, n)
    tested += 1
assert tested > 0
print("map-exponent pairs checked:", tested)
print("RESULT: PASS")
