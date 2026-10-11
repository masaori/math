# 対象ラベル: claim_perfect_matching_involution
# 本文の行: 左逆の逆包含: 軌道の族への所属
if "_pm_cases" not in globals():
    load("sagemath/check/perfect-matching-involution/_prelude.sage")

checked = 0
for J, D, p, a, b in matching_pairs():
    tau = {i:mate(J,D,i) for i in J}
    assert p in involution_pairs(J,tau)
    checked += 1
print("PASS left_membership: %s 所属確認" % checked)
