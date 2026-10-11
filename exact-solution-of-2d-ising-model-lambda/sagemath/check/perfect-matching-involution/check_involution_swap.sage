# 対象ラベル: claim_perfect_matching_involution
# 本文の行: 相手写像の対合性: 順序交換
if "_pm_cases" not in globals():
    load("sagemath/check/perfect-matching-involution/_prelude.sage")

checked = 0
for J, D, i in matching_points():
    j = mate(J,D,i)
    assert pair(j,i) == pair(i,j)
    checked += 1
print("PASS involution_swap: %s 等式" % checked)
