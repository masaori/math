# 対象ラベル: claim_matching_word_sign_swap
# 本文の行: 符号の乗法性
# 式ペア: sgn(t o pi_w) = sgn(t) sgn(pi_w)
# 帰属: 有限集合・有限列と ZZ。浮動小数点を使わない。
if "_matching_sign_cases_ready" not in globals():
    load("sagemath/check/perfect-matching-sign/_prelude.sage")

checked = 0
for J, w, wp, a, b in _word_swap_cases:
    p = word_permutation(J, w)
    pp = word_permutation(J, wp)
    t = swap_permutation(J, a, b)
    assert a != b and complete_word(J, wp)
    expr1 = permutation_sign(J, compose(t, p))
    expr2 = permutation_sign(J, t) * permutation_sign(J, p)
    assert expr1 == expr2
    checked += 1

print("PASS swap_sign_multiplication: %s 等式" % checked)
