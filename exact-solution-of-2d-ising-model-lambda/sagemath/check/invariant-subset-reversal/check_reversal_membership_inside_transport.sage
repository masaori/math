# 対象ラベル: claim_invariant_subset_reversal
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count = 0
for sigma,C,inv,f,g,r,rinv,rr in isr_cases:
    for i in range(len(sigma)):
        if i not in C:
            continue
        lhs = inv[i] in C
        rhs = i in C
        assert lhs == rhs, (sigma, C, i, lhs, rhs)
        count += 1
isr_report("reversal_membership_inside_transport", count, 17203)
