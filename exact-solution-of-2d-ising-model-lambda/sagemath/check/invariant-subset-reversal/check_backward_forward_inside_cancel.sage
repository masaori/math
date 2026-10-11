# 対象ラベル: claim_invariant_subset_reversal
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count = 0
for sigma,C,inv,f,g,r,rinv,rr in isr_cases:
    for i in range(len(sigma)):
        if i not in C:
            continue
        lhs = sigma[inv[i]]
        rhs = i
        assert lhs == rhs, (sigma, C, i, lhs, rhs)
        count += 1
isr_report("backward_forward_inside_cancel", count, 17203)
