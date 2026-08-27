# 対象ラベル: claim_eventually_periodic_iff_power_identity
# 周期だけ離れた二項が等しいとき、対応する交差べき等式が従う各式変形を検証する。
# 帰属: QQ と ZZ の厳密計算。浮動小数点と極限は使わない。

for common_value in [QQ(1), QQ(2), QQ(3) / QQ(2), QQ(11) / QQ(7)]:
    for left_site_count, right_site_count in [
        (ZZ(1), ZZ(27)),
        (ZZ(8), ZZ(64)),
        (ZZ(27), ZZ(125)),
    ]:
        left_partition_value = common_value ** left_site_count
        right_partition_value = common_value ** right_site_count

        left_cross_power = left_partition_value ** right_site_count
        common_power = common_value ** (left_site_count * right_site_count)
        right_cross_power = right_partition_value ** left_site_count

        assert left_cross_power == common_power
        assert common_power == right_cross_power
        assert left_cross_power == right_cross_power

print("RESULT: PASS")
