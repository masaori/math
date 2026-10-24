# 対象ラベル: claim_critical_point_not_fisher_zero
if not globals().get("_cnfz_ready", False):
    load("sagemath/check/critical-point-not-fisher-zero/_prelude.sage")
assert not (cnfz_zero[0] < QQ.zero())
print("PASS negative_first_condition")
