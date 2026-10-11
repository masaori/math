# 対象ラベル: claim_invariant_subset_reversal_orbit
# 第二方向を逆置換の反転へ置換。有限集合と自然数だけを使う。
# 式ペア: either_iterate_membership(r, rinv, i, j) <=> either_iterate_membership(r, reverse_inverse, i, j)
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count = 0
for sigma, C, inv, f, g, r, rinv, rr in isr_cases:
    inverse_inverse = inverse_permutation(inv)
    reverse_inverse = reverse_on_subset(inv, C)
    for i in range(len(sigma)):
        if i not in C:
            continue
        for j in range(len(sigma)):
            left = either_iterate_membership(r, rinv, i, j)
            right = either_iterate_membership(r, reverse_inverse, i, j)
            assert left == right, (sigma, C, i, j, left, right)
            count += 1
orbit_report("check_orbit_inside_replace_inverse.sage", count, 100801)

