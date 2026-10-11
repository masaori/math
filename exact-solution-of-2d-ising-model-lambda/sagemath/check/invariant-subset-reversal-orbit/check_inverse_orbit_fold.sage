# 対象ラベル: claim_invariant_subset_reversal_orbit
# 元の軌道の定義へ戻す。有限集合と自然数だけを使う。
# 式ペア: either_iterate_membership(sigma, inv, i, j) <=> j in orbit_support(sigma, i)
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count = 0
for sigma in isro_permutations:
    inv = inverse_permutation(sigma)
    inverse_inverse = inverse_permutation(inv)
    for i in range(len(sigma)):
        for j in range(len(sigma)):
            left = either_iterate_membership(sigma, inv, i, j)
            right = j in orbit_support(sigma, i)
            assert left == right, (sigma, i, j, left, right)
            count += 1
orbit_report("check_inverse_orbit_fold.sage", count, 29367)

