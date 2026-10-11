# 対象ラベル: claim_invariant_subset_reversal_orbit
# 反転の軌道の定義を展開。有限集合と自然数だけを使う。
# 式ペア: j in orbit_support(r, i) <=> either_iterate_membership(r, rinv, i, j)
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
            left = j in orbit_support(r, i)
            right = either_iterate_membership(r, rinv, i, j)
            assert left == right, (sigma, C, i, j, left, right)
            count += 1
orbit_report("check_orbit_inside_unfold.sage", count, 100801)

