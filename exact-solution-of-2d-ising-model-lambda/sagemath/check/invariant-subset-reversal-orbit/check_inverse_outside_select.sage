# 対象ラベル: claim_invariant_subset_reversal_orbit
# 外側で補助写像を元の逆置換へ展開。有限集合と自然数だけを使う。
# 式ペア: g[i] = inv[i]
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count = 0
for sigma, C, inv, f, g, r, rinv, rr in isr_cases:
    inverse_inverse = inverse_permutation(inv)
    reverse_inverse = reverse_on_subset(inv, C)
    for i in range(len(sigma)):
        if i in C:
            continue
        left = g[i]
        right = inv[i]
        assert left == right, (sigma, C, i, left, right)
        count += 1
orbit_report("check_inverse_outside_select.sage", count, 17203)

