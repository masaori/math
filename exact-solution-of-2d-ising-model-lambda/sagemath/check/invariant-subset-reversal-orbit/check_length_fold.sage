# 対象ラベル: claim_invariant_subset_reversal_orbit_length
# 元の軌道長の定義へ戻す。有限集合と自然数だけを使う。
# 式ペア: len(orbit_support(sigma, i)) = orbit_length(sigma, i)
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count = 0
for sigma, C, inv, f, g, r, rinv, rr in isr_cases:
    inverse_inverse = inverse_permutation(inv)
    reverse_inverse = reverse_on_subset(inv, C)
    for i in range(len(sigma)):
        left = len(orbit_support(sigma, i))
        right = orbit_length(sigma, i)
        assert left == right, (sigma, C, i, left, right)
        count += 1
orbit_report("check_length_fold.sage", count, 34406)

