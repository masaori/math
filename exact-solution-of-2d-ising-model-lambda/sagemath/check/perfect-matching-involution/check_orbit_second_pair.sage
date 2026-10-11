# 対象ラベル: claim_perfect_matching_involution
# 本文の行: 軌道の一意性: 第二の場合の組の表示
if "_pm_cases" not in globals():
    load("sagemath/check/perfect-matching-involution/_prelude.sage")

checked = 0
for J, tau, k in involution_points():
    p = pair(k,tau[k])
    assert p == pair(k,tau[k])
    checked += 1
print("PASS orbit_second_pair: %s 等式" % checked)
