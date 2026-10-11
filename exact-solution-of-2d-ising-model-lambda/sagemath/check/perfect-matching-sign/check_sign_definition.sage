# 対象ラベル: def_matching_word_sign
# 本文の行: 転倒数の符号と独立な Sage 置換符号
# 式ペア: epsilon(w) = (-1)^inv(pi_w)
# 帰属: 有限集合・有限列と ZZ。浮動小数点を使わない。
if "_matching_sign_cases_ready" not in globals():
    load("sagemath/check/perfect-matching-sign/_prelude.sage")

checked = 0
for J, D, canonical, L, w in _enumeration_cases:
    p = word_permutation(J, w)
    expr1 = permutation_sign(J, p)
    expr2 = ZZ(Permutation([J.index(x) + 1 for x in w]).signature())
    assert expr1 == expr2 and expr1 in (ZZ(-1), ZZ(1))
    checked += 1

print("PASS sign_definition: %s 等式" % checked)
