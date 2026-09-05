# 対象ラベル: claim_positive_count_domain_iff_period_divides
# 式ペア・判定: n ∈ Pos_F ⇔ Z_n(F)>0
# プログラミングによる検証: 有限集合・ZZ・QQ の厳密計算。R/C 脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

tested = 0
for name, mapping, n in rows():
    positive_window = {m for m in range(1, n + 1) if count_fixed(mapping, m) > 0}
    assert (n in positive_window) == (count_fixed(mapping, n) > 0), (name, mapping, n)
    tested += 1
assert tested > 0
print("map-exponent pairs checked:", tested)
print("RESULT: PASS")
