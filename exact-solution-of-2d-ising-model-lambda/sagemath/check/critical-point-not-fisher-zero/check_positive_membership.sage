# 対象ラベル: claim_critical_point_not_fisher_zero
if not globals().get("_cnfz_ready", False):
    load("sagemath/check/critical-point-not-fisher-zero/_prelude.sage")
for L,s,xc,Z,C,xi,ab,roots in cnfz_cases:
    assert cnfz_positive(*ab)
print("PASS positive_membership")
