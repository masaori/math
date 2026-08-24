# 対象ラベル: claim_eventually_constant_iff_power_identity
# 閾値以後の隣接項の等号から、帰納的に全項が閾値での値へ等しくなることを検証する。
# 帰属: QQ と有限な自然数添字の厳密計算。浮動小数点と極限は使わない。

threshold = ZZ(3)
last_index = ZZ(12)
common_value = QQ(11) / QQ(7)
values = {
    index: (QQ(index + 1) if index < threshold else common_value)
    for index in range(1, last_index + 1)
}

for index in range(threshold, last_index):
    assert values[index] == values[index + 1]

assert values[threshold] == common_value
for index in range(threshold, last_index + 1):
    assert values[index] == common_value

print("RESULT: PASS")
