# 対象ラベル: claim_invariant_subset_reversal
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))
count = 0
for sigma,C,inv,f,g,r,rinv,rr in isr_cases:
    for i in range(len(sigma)):
        lhs = sigma[inv[i]] in C
        rhs = i in C
        assert lhs == rhs, (sigma, C, i, lhs, rhs)
        count += 1
isr_report("inverse_membership_cancel", count, 34406)
