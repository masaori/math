# 対象ラベル: claim_invariant_subset_reversal_orbit
# 存在量化内の選言を交換。有限集合と自然数だけを使う。
# 式ペア: either_iterate_membership(inv, sigma, i, j) <=> either_iterate_membership(sigma, inv, i, j)
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count = 0
for sigma in isro_permutations:
    inv = inverse_permutation(sigma)
    inverse_inverse = inverse_permutation(inv)
    for i in range(len(sigma)):
        for j in range(len(sigma)):
            left = either_iterate_membership(inv, sigma, i, j)
            right = either_iterate_membership(sigma, inv, i, j)
            assert left == right, (sigma, i, j, left, right)
            count += 1
orbit_report("check_inverse_orbit_disjunction.sage", count, 29367)

