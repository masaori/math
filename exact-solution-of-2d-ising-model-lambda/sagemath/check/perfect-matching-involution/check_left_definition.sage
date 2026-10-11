# 対象ラベル: claim_perfect_matching_involution
# 本文の行: 左逆: 合成写像の定義
if "_pm_cases" not in globals():
    load("sagemath/check/perfect-matching-involution/_prelude.sage")

checked = 0
for J, D in _pm_cases:
    tau = {i:mate(J,D,i) for i in J}
    image = frozenset(pair(i,tau[i]) for i in J)
    assert image == involution_pairs(J,tau)
    checked += 1
print("PASS left_definition: %s 等式" % checked)
