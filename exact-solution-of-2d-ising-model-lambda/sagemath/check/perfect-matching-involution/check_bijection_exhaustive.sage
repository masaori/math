# 対象ラベル: claim_perfect_matching_involution
# 本文の行: 独立に列挙した置換との全単射
if "_pm_cases" not in globals():
    load("sagemath/check/perfect-matching-involution/_prelude.sage")

checked = 0
for n in range(9):
    J = tuple(3*i+2 for i in range(n))
    left = {tuple(mate(J,D,i) for i in J) for Js,D in _pm_cases if Js == J}
    right = {tuple(tau[i] for i in J) for Js,tau in _inv_cases if Js == J}
    assert left == right
    checked += 1
print("PASS bijection_exhaustive: %s 集合等式" % checked)
