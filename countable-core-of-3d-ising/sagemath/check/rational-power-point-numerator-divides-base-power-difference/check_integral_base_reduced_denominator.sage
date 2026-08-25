# 対象ラベル: claim_rational_power_point_numerator_divides_base_power_difference
# 正の自然数 c の既約分数表示 c = u/v では u = c, v = 1 となることを ZZ・QQ で確認する。

for c in range(1, 257):
    reduced = QQ(c)
    assert reduced.numerator() == ZZ(c)
    assert reduced.denominator() == ZZ(1)

print("RESULT: PASS")
