# 対象ラベル: claim_invariant_subset_reversal_iterate
# 所属を保つ始点で帰納法の等式を照合（部分集合の外側）。有限集合と自然数だけを使う。
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count = 0
for sigma, C, inv, f, g, r, rinv, rr in isr_cases:
    for i in range(len(sigma)):
        if (i in C) != False:
            continue
        for k in range(13):
            left = repeat_value(r, k, sigma[i])
            right = repeat_value(sigma, k, sigma[i])
            assert left == right, (sigma, C, k, i, left, right)
            count += 1
isr_report("check_successor_outside_induction.sage", count, 223639)
