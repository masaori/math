# 対象ラベル: claim_perfect_matching_sign_enumeration_independent
# 本文の行: 全列挙の符号が同じ値となる主張
# 式ペア: epsilon(W(L)) = sgn(D)
# 帰属: 有限集合・有限列と ZZ。浮動小数点を使わない。
if "_matching_sign_cases_ready" not in globals():
    load("sagemath/check/perfect-matching-sign/_prelude.sage")

checked = 0
for J, D, canonical, L, w in _enumeration_cases:
    expr1 = word_sign(w)
    expr2 = word_sign(pair_word(canonical))
    assert expr1 == expr2
    checked += 1

print("PASS enumeration_independent: %s 等式" % checked)
