# 対象ラベル: claim_critical_point_not_fisher_zero
if not globals().get("_cnfz_ready", False):
    load("sagemath/check/critical-point-not-fisher-zero/_prelude.sage")
for L,s,xc,Z,C,xi,ab,roots in cnfz_cases:
    for point in [xc] + roots:
        assert (point in roots) == (Z(point) == 0)
print("PASS zero_set_definition")
