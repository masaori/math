# 対象ラベル: claim_perfect_matching_involution
# 本文の行: 軌道の一意性: 戻り先の代入
if "_pm_cases" not in globals():
    load("sagemath/check/perfect-matching-involution/_prelude.sage")

checked = 0
for J, tau, k in involution_points():
    i = tau[k]
    assert pair(k,i) == pair(tau[i],i)
    checked += 1
print("PASS orbit_second_mate: %s 等式" % checked)
