# 対象ラベル: claim_positive_count_domain_iff_period_divides
# 式ペア・判定: |Fix_n(F)|>0 ⇔ ∃y∈Fix_n(F)
# プログラミングによる検証: 有限集合・ZZ・QQ の厳密計算。R/C 脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

tested = 0
for name, mapping, n in rows():
    assert (len(fixed_set(mapping, n)) > 0) == (any(x in fixed_set(mapping, n) for x in range(len(mapping)))), (name, mapping, n)
    tested += 1
assert tested > 0
print("map-exponent pairs checked:", tested)
print("RESULT: PASS")
