# 対象ラベル: claim_fixed_point_count_bounded_by_cardinality
# 式ペア・判定: Fix_n(F) ⊆ X より 0 ≤ |Fix_n(F)| ≤ |X|
# プログラミングによる検証: 有限集合・ZZ・QQ の厳密計算。R/C 脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

tested = 0
for name, mapping, n in rows():
    fixed = fixed_set(mapping, n)
    assert fixed <= set(range(len(mapping))), (name, n)
    assert 0 <= ZZ(len(fixed)) <= ZZ(len(mapping)), (name, n)
    tested += 1
assert tested > 0
print("map-exponent pairs checked:", tested)
print("RESULT: PASS")
