# 対象ラベル: claim_perfect_matching_involution
# 本文の行: 右逆: 合成写像の点ごとの定義
if "_pm_cases" not in globals():
    load("sagemath/check/perfect-matching-involution/_prelude.sage")

checked = 0
for J, tau, k in involution_points():
    D = involution_pairs(J,tau)
    image = {i:mate(J,D,i) for i in J}
    assert image[k] == mate(J,D,k)
    checked += 1
print("PASS right_definition: %s 等式" % checked)
