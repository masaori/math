# 対象ラベル: claim_invariant_subset_reversal_iterate
# 反転の反復から最初の一歩を出す（部分集合の内側）。有限集合と自然数だけを使う。
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count = 0
for sigma, C, inv, f, g, r, rinv, rr in isr_cases:
    for i in range(len(sigma)):
        if (i in C) != True:
            continue
        for k in range(13):
            left = repeat_value(r, k + 1, i)
            right = repeat_value(r, k, r[i])
            assert left == right, (sigma, C, k, i, left, right)
            count += 1
isr_report("check_successor_inside_unfold.sage", count, 223639)
