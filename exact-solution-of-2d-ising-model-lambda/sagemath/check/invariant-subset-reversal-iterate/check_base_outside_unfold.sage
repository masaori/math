# 対象ラベル: claim_invariant_subset_reversal_iterate
# 零回の反転を恒等写像へ展開（部分集合の外側）。有限集合と自然数だけを使う。
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count = 0
for sigma, C, inv, f, g, r, rinv, rr in isr_cases:
    for i in range(len(sigma)):
        if (i in C) != False:
            continue
        for k in [0]:
            left = repeat_value(r, 0, i)
            right = i
            assert left == right, (sigma, C, k, i, left, right)
            count += 1
isr_report("check_base_outside_unfold.sage", count, 17203)
