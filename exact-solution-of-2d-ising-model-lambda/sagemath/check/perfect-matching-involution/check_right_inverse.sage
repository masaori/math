# 対象ラベル: claim_perfect_matching_involution
# 本文の行: 右逆: 相手の一意性
if "_pm_cases" not in globals():
    load("sagemath/check/perfect-matching-involution/_prelude.sage")

checked = 0
for J, tau, k in involution_points():
    D = involution_pairs(J,tau)
    assert mate(J,D,k) == tau[k]
    checked += 1
print("PASS right_inverse: %s 等式" % checked)
