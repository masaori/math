# 対象ラベル: claim_perfect_matching_involution
# 本文の行: 相手の存在: 第二端点の代入
if "_pm_cases" not in globals():
    load("sagemath/check/perfect-matching-involution/_prelude.sage")

checked = 0
for J, D, p, a, b in matching_pairs():
    i = b
    assert pair(a,b) == pair(a,i)
    checked += 1
print("PASS exist_second_substitution: %s 等式" % checked)
