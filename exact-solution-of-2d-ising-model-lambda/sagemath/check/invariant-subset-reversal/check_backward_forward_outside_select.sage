# 対象ラベル: claim_invariant_subset_reversal
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count = 0
for sigma,C,inv,f,g,r,rinv,rr in isr_cases:
    for i in range(len(sigma)):
        if i in C:
            continue
        lhs = g[sigma[i]]
        rhs = inv[sigma[i]]
        assert lhs == rhs, (sigma, C, i, lhs, rhs)
        count += 1
isr_report("backward_forward_outside_select", count, 17203)
