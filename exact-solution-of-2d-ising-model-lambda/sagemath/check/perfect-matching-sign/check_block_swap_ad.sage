# 対象ラベル: claim_perfect_matching_sign_enumeration_independent
# 本文の行: 最後の隣接交換
# 式ペア: epsilon[c,d,a,b] = -epsilon[c,a,d,b]
# 帰属: 有限集合・有限列と ZZ。浮動小数点を使わない。
if "_matching_sign_cases_ready" not in globals():
    load("sagemath/check/perfect-matching-sign/_prelude.sage")

checked = 0
for J, w0, w1, w2, w3, w4 in _block_swap_cases:
    assert all(complete_word(J, w) for w in (w0, w1, w2, w3, w4))
    expr1 = word_sign(w4)
    expr2 = -word_sign(w3)
    assert expr1 == expr2
    checked += 1

print("PASS block_swap_ad: %s 等式" % checked)
