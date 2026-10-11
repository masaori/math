# 対象ラベル: claim_invariant_subset_reversal_orbit
# 元の軌道の定義へ戻す。有限集合と自然数だけを使う。
# 式ペア: either_iterate_membership(sigma, inv, i, j) <=> j in orbit_support(sigma, i)
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count = 0
for sigma, C, inv, f, g, r, rinv, rr in isr_cases:
    inverse_inverse = inverse_permutation(inv)
    reverse_inverse = reverse_on_subset(inv, C)
    for i in range(len(sigma)):
        if i in C:
            continue
        for j in range(len(sigma)):
            left = either_iterate_membership(sigma, inv, i, j)
            right = j in orbit_support(sigma, i)
            assert left == right, (sigma, C, i, j, left, right)
            count += 1
orbit_report("check_orbit_outside_fold.sage", count, 100801)

