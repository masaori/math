# 対象ラベル: claim_perfect_matching_involution
# 本文の行: 相手の一意性: 組の等式の代入
if "_pm_cases" not in globals():
    load("sagemath/check/perfect-matching-involution/_prelude.sage")

checked = 0
for J, D, i, j, k in [(J,D,i,j,k) for J,D,i in matching_points() for j in candidates(J,D,i) for k in candidates(J,D,i)]:
    assert j in pair(i,k)
    checked += 1
print("PASS unique_membership: %s 所属確認" % checked)
