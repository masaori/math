# 対象ラベル: claim_power_form_base_is_determined_by_threshold_box
# 同じ正の自然数乗が等しい正の有理数の底は等しいことを検証する。
# 帰属: QQ と ZZ の厳密計算。

positive_rationals = [QQ(1) / QQ(5), QQ(2) / QQ(3), QQ(1), QQ(3) / QQ(2), QQ(4)]

for exponent in range(1, 9):
    n = ZZ(exponent)
    for left in positive_rationals:
        for right in positive_rationals:
            assert ((left ** n == right ** n) == (left == right))

print("RESULT: PASS")
