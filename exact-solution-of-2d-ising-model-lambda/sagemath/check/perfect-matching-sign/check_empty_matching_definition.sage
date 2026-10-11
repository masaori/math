# 対象ラベル: claim_perfect_matching_sign_enumeration_independent
# 本文の行: 空マッチングの置換
# 式ペア: sgn(empty) = sgn(id_empty)
# 帰属: 有限集合・有限列と ZZ。浮動小数点を使わない。
if "_matching_sign_cases_ready" not in globals():
    load("sagemath/check/perfect-matching-sign/_prelude.sage")

checked = 0
J, D, canonical = _matching_cases[0]
assert J == () and D == frozenset() and canonical == ()
expr1 = word_sign(pair_word(canonical))
expr2 = permutation_sign(J, {})
assert expr1 == expr2
checked += 1

print("PASS empty_matching_definition: %s 等式" % checked)
