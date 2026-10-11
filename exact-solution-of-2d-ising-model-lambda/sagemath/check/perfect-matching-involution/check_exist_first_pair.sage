# 対象ラベル: claim_perfect_matching_involution
# 本文の行: 相手の存在: 第一の場合の組の表示
if "_pm_cases" not in globals():
    load("sagemath/check/perfect-matching-involution/_prelude.sage")

checked = 0
for J, D, p, a, b in matching_pairs():
    i = a
    assert p == pair(a,b)
    checked += 1
print("PASS exist_first_pair: %s 等式" % checked)
