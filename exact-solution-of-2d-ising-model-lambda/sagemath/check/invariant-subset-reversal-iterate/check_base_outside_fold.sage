# 対象ラベル: claim_invariant_subset_reversal_iterate
# 対応する写像の零回の反復へ戻す（部分集合の外側）。有限集合と自然数だけを使う。
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count = 0
for sigma, C, inv, f, g, r, rinv, rr in isr_cases:
    for i in range(len(sigma)):
        if (i in C) != False:
            continue
        for k in [0]:
            left = i
            right = repeat_value(sigma, 0, i)
            assert left == right, (sigma, C, k, i, left, right)
            count += 1
isr_report("check_base_outside_fold.sage", count, 17203)
