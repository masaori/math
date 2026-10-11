# 対象ラベル: claim_perfect_matching_involution
# 本文の行: 相手写像の対合性: 逆順の組の所属
if "_pm_cases" not in globals():
    load("sagemath/check/perfect-matching-involution/_prelude.sage")

checked = 0
for J, D, i in matching_points():
    j = mate(J,D,i)
    assert pair(j,i) in D
    checked += 1
print("PASS involution_membership: %s 所属確認" % checked)
