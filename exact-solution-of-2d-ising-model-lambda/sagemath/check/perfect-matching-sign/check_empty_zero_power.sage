# 対象ラベル: claim_perfect_matching_sign_enumeration_independent
# 本文の行: 整数の零乗
# 式ペア: (-1)^0 = 1
# 帰属: 有限集合・有限列と ZZ。浮動小数点を使わない。
if "_matching_sign_cases_ready" not in globals():
    load("sagemath/check/perfect-matching-sign/_prelude.sage")

checked = 0
expr1 = ZZ(-1) ** ZZ(0)
expr2 = ZZ(1)
assert expr1 == expr2
checked += 1

print("PASS empty_zero_power: %s 等式" % checked)
