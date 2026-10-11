# 対象ラベル: claim_matching_word_sign_swap
# 本文の行: 各位置への値の互換の適用
# 式ペア: w'_k = t(w_k)
# 帰属: 有限集合・有限列と ZZ。浮動小数点を使わない。
if "_matching_sign_cases_ready" not in globals():
    load("sagemath/check/perfect-matching-sign/_prelude.sage")

checked = 0
for J, w, wp, a, b in _word_swap_cases:
    p = word_permutation(J, w)
    pp = word_permutation(J, wp)
    t = swap_permutation(J, a, b)
    for k, x in enumerate(J):
        expr1 = wp[k]
        expr2 = t[w[k]]
        assert expr1 == expr2
        checked += 1

print("PASS component_swap: %s 等式" % checked)
