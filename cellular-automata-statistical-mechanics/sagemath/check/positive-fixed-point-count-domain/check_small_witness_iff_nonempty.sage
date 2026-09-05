# 対象ラベル: claim_positive_count_domain_small_witness
# 式ペア・判定: X≠∅ ⇔ Pos_F∩[1,|X|]_N≠∅、衝突証人の正値と上界
# プログラミングによる検証: 有限集合・ZZ・QQ の厳密計算。R/C 脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

tested = 0
for name, mapping in cases():
    witnesses = {n for n in range(1, len(mapping) + 1) if count_fixed(mapping, n) > 0}
    assert bool(mapping) == bool(witnesses), (name, mapping)
    tested += 1
for name, mapping, x, i, j, p, y in collisions():
    assert 1 <= p <= len(mapping), (name, x, i, j)
    assert y in fixed_set(mapping, p), (name, x, i, j)
    assert count_fixed(mapping, p) > 0, (name, x, i, j)
assert tested > 0
print("maps checked:", tested)
print("RESULT: PASS")
