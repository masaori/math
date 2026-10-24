# 対象ラベル: claim_critical_point_not_fisher_zero
if not globals().get("_cnfz_ready", False):
    load("sagemath/check/critical-point-not-fisher-zero/_prelude.sage")
for L,s,xc,Z,C,xi,ab,roots in cnfz_cases:
    assert sum(QQbar(QQ(C[m]))*xc**m for m in range(2*L*L+1)) == xi
print("PASS sum_definition")
