# 対象ラベル: claim_matching_word_sign_swap
# 本文の行: 交換前の語の符号への復帰
# 式ペア: -sgn(pi_w) = -epsilon(w)
# 帰属: 有限集合・有限列と ZZ。浮動小数点を使わない。
if "_matching_sign_cases_ready" not in globals():
    load("sagemath/check/perfect-matching-sign/_prelude.sage")

checked = 0
for J, w, wp, a, b in _word_swap_cases:
    p = word_permutation(J, w)
    pp = word_permutation(J, wp)
    t = swap_permutation(J, a, b)
    assert a != b and complete_word(J, wp)
    expr1 = -permutation_sign(J, p)
    expr2 = -word_sign(w)
    assert expr1 == expr2
    checked += 1

print("PASS swap_sign_recover: %s 等式" % checked)
