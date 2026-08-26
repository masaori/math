# 対象ラベル: claim_power_form_base_is_determined_by_threshold_box
# 正の有理数の底の狭義大小が正の自然数乗で保たれる二方向を検証する。
# 帰属: QQ と ZZ の厳密計算。

positive_rationals = [QQ(1) / QQ(5), QQ(2) / QQ(3), QQ(1), QQ(3) / QQ(2), QQ(4)]

for exponent in range(1, 9):
    n = ZZ(exponent)
    for left in positive_rationals:
        for right in positive_rationals:
            if left < right:
                assert left ** n < right ** n
            if left > right:
                assert left ** n > right ** n

print("RESULT: PASS")
