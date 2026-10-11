# 対象ラベル: claim_invariant_subset_reversal_orbit
# 内側で逆置換の反転へ戻す。有限集合と自然数だけを使う。
# 式ペア: inverse_inverse[i] = reverse_inverse[i]
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count = 0
for sigma, C, inv, f, g, r, rinv, rr in isr_cases:
    inverse_inverse = inverse_permutation(inv)
    reverse_inverse = reverse_on_subset(inv, C)
    for i in range(len(sigma)):
        if i not in C:
            continue
        left = inverse_inverse[i]
        right = reverse_inverse[i]
        assert left == right, (sigma, C, i, left, right)
        count += 1
orbit_report("check_inverse_inside_fold.sage", count, 17203)

