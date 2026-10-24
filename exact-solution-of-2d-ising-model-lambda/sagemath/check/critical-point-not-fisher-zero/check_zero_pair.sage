# 対象ラベル: claim_critical_point_not_fisher_zero
if not globals().get("_cnfz_ready", False):
    load("sagemath/check/critical-point-not-fisher-zero/_prelude.sage")
for L,s,xc,Z,C,xi,ab,roots in cnfz_cases:
    a,b = cnfz_rep(QQbar.zero(), s)
    assert (a,b) == cnfz_zero
print("PASS zero_pair")
