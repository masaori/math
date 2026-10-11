# 対象ラベル: claim_perfect_matching_involution
# 本文の行: 相手の一意性: 自分以外の端点
if "_pm_cases" not in globals():
    load("sagemath/check/perfect-matching-involution/_prelude.sage")

checked = 0
for J, D, i, j, k in [(J,D,i,j,k) for J,D,i in matching_points() for j in candidates(J,D,i) for k in candidates(J,D,i)]:
    assert j == k
    checked += 1
print("PASS unique_partner: %s 等式" % checked)
