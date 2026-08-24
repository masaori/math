# 対象ラベル: claim_eventually_constant_iff_power_identity
# 交差べき等式から隣接する正の有限箱量の同じ正整数冪が等しくなり、元の値が等しいことを検証する。
# 帰属: QQ と素因数指数 ZZ の厳密計算。浮動小数点と極限は使わない。

positive_values = [QQ(1), QQ(2), QQ(3) / QQ(2), QQ(11) / QQ(7)]
site_count_pairs = [(ZZ(1), ZZ(8)), (ZZ(8), ZZ(27)), (ZZ(27), ZZ(64))]

for left_value in positive_values:
    for right_value in positive_values:
        for left_site_count, right_site_count in site_count_pairs:
            common_exponent = left_site_count * right_site_count
            left_partition_value = left_value ** left_site_count
            right_partition_value = right_value ** right_site_count

            cross_power_identity = (
                left_partition_value ** right_site_count
                == right_partition_value ** left_site_count
            )
            common_power_identity = left_value ** common_exponent == right_value ** common_exponent

            assert cross_power_identity == common_power_identity
            assert common_power_identity == (left_value == right_value)

print("RESULT: PASS")
