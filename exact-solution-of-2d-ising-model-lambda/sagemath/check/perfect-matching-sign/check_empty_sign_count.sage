# 対象ラベル: claim_perfect_matching_sign_enumeration_independent
# 本文の行: 空集合の転倒数
# 式ペア: sgn(id_empty) = (-1)^0
# 帰属: 有限集合・有限列と ZZ。浮動小数点を使わない。
if "_matching_sign_cases_ready" not in globals():
    load("sagemath/check/perfect-matching-sign/_prelude.sage")

checked = 0
expr1 = permutation_sign((), {})
expr2 = ZZ(-1) ** ZZ(0)
assert inversion_count(()) == 0 and expr1 == expr2
checked += 1

print("PASS empty_sign_count: %s 等式" % checked)
