# 対象ラベル: claim_perfect_matching_involution
# 本文の行: 左逆の逆包含: 組の表示
if "_pm_cases" not in globals():
    load("sagemath/check/perfect-matching-involution/_prelude.sage")

checked = 0
for J, D, p, a, b in matching_pairs():
    i,j = a,b
    assert p == pair(i,j)
    checked += 1
print("PASS left_pair: %s 等式" % checked)
