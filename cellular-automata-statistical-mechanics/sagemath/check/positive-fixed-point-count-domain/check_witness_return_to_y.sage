# 対象ラベル: claim_positive_count_domain_small_witness
# 式ペア・判定: F^i x = y
# プログラミングによる検証: 有限集合・ZZ・QQ の厳密計算。R/C 脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

tested = 0
for name, mapping, x, i, j, p, y in collisions():
    assert (image_at(mapping,x,i)) == (y), (name, mapping, x, i, j)
    tested += 1
assert tested > 0
print("collision witnesses checked:", tested)
print("RESULT: PASS")
