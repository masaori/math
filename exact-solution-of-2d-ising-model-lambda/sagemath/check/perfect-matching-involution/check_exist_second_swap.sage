# 対象ラベル: claim_perfect_matching_involution
# 本文の行: 相手の存在: 第二の場合の順序交換
if "_pm_cases" not in globals():
    load("sagemath/check/perfect-matching-involution/_prelude.sage")

checked = 0
for J, D, p, a, b in matching_pairs():
    i = b
    assert pair(a,i) == pair(i,a)
    checked += 1
print("PASS exist_second_swap: %s 等式" % checked)
