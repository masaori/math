# 対象ラベル: claim_perfect_matching_involution
# 本文の行: 単射性: 第二の左逆
if "_pm_cases" not in globals():
    load("sagemath/check/perfect-matching-involution/_prelude.sage")

checked = 0
for J, D, E in [(J,D,E) for J,D in _pm_cases for Js,E in _pm_cases if Js == J and all(mate(J,D,i) == mate(J,E,i) for i in J)]:
    td = {i:mate(J,D,i) for i in J}
    te = {i:mate(J,E,i) for i in J}
    assert involution_pairs(J,te) == E
    checked += 1
print("PASS injective_right: %s 等式" % checked)
