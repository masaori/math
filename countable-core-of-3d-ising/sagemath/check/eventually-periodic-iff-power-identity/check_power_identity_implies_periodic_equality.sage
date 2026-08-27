# 対象ラベル: claim_eventually_periodic_iff_power_identity
# 交差べき等式が、共通の正整数冪の等式に一致し、正の値に対する冪の単射性から
# 周期だけ離れた二項の等号を与えることを検証する。
# 帰属: QQ と ZZ の厳密計算。浮動小数点と極限は使わない。

candidate_values = [QQ(1), QQ(2), QQ(3) / QQ(2), QQ(11) / QQ(7)]

for left_site_count, right_site_count in [
    (ZZ(1), ZZ(27)),
    (ZZ(8), ZZ(64)),
    (ZZ(27), ZZ(125)),
]:
    common_exponent = left_site_count * right_site_count
    for left_value in candidate_values:
        for right_value in candidate_values:
            left_partition_value = left_value ** left_site_count
            right_partition_value = right_value ** right_site_count

            cross_power_identity = (
                left_partition_value ** right_site_count
                == right_partition_value ** left_site_count
            )
            common_power_identity = (
                left_value ** common_exponent == right_value ** common_exponent
            )

            assert cross_power_identity == common_power_identity
            # 正の有理数における正整数冪の単射性（本文の「正の実数の冪は単射」の可算側標本）
            assert common_power_identity == (left_value == right_value)

print("RESULT: PASS")
