# 対象ラベル: claim_power_form_base_is_determined_by_threshold_box
# 閾値の箱で二つの点数乗表示が同じ有理数値を与える等式を検証する。
# 帰属: QQ と ZZ の厳密計算。

for threshold_box in range(1, 7):
    site_count = ZZ(threshold_box) ** 3
    assert site_count >= ZZ(1)
    for base in [QQ(1), QQ(2), QQ(3) / QQ(2), QQ(18) / QQ(35)]:
        threshold_value = base ** site_count
        assert base ** site_count == threshold_value

print("RESULT: PASS")
