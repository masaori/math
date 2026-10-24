# 対象ラベル: claim_critical_point_not_fisher_zero
if not globals().get("_cnfz_ready", False):
    load("sagemath/check/critical-point-not-fisher-zero/_prelude.sage")
for L,s,xc,Z,C,xi,ab,roots in cnfz_cases:
    assert all(t in QQ for t in ab)
    assert xi == QQbar(ab[0])+QQbar(ab[1])*s
print("PASS field_membership")
