# 対象ラベル: claim_perfect_matching_involution
# 本文の行: 軌道の一意性: 第一端点の代入
if "_pm_cases" not in globals():
    load("sagemath/check/perfect-matching-involution/_prelude.sage")

checked = 0
for J, tau, k in involution_points():
    i = k
    assert pair(k,tau[k]) == pair(i,tau[i])
    checked += 1
print("PASS orbit_first_substitution: %s 等式" % checked)
