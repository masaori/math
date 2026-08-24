# 対象ラベル: claim_power_identity_iff_rational_power_form
# 一つの正の有理数の点数乗表示から、隣接する箱の交差冪等式を得る各式変形を検証する。
# 帰属: QQ と ZZ の厳密計算。浮動小数点と極限は使わない。

for common_base in [QQ(1), QQ(2), QQ(3) / QQ(2), QQ(18) / QQ(35)]:
    for box_size in range(1, 6):
        left_site_count = ZZ(box_size) ** 3
        right_site_count = ZZ(box_size + 1) ** 3
        left_value = common_base ** left_site_count
        right_value = common_base ** right_site_count

        left_cross_power = left_value ** right_site_count
        common_power = common_base ** (left_site_count * right_site_count)
        right_cross_power = right_value ** left_site_count

        assert left_cross_power == common_power
        assert common_power == right_cross_power

print("RESULT: PASS")
