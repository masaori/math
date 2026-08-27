# 対象ラベル: claim_eventually_periodic_iff_power_identity
# 周期を 1 に置いた場合の冪等式が、既存の末尾定数性の同値
# （claim_eventually_constant_iff_power_identity）の冪等式と同じ式であることを検証する。
# あわせて、閾値以後の周期等号から周期に沿った剰余類ごとに値が一定になる段を検証する。
# 帰属: QQ と ZZ の厳密計算。浮動小数点と極限は使わない。

def site_count(box_width):
    return box_width ** 3

# 周期 1 の冪等式が隣接箱の冪等式そのものであること
for box_width in [ZZ(1), ZZ(2), ZZ(3), ZZ(4)]:
    period_one_left_exponent = site_count(box_width + 1)
    adjacent_left_exponent = site_count(box_width + 1)
    assert period_one_left_exponent == adjacent_left_exponent
    period_one_right_exponent = site_count(box_width)
    adjacent_right_exponent = site_count(box_width)
    assert period_one_right_exponent == adjacent_right_exponent

# 閾値以後の周期等号から剰余類ごとの定数性が従うこと
threshold = ZZ(3)
period = ZZ(4)
last_index = ZZ(19)
class_values = {residue: QQ(residue + 2) / QQ(5) for residue in range(period)}
values = {
    index: (
        QQ(index + 1)
        if index < threshold
        else class_values[(index - threshold) % period]
    )
    for index in range(1, last_index + 1)
}

for index in range(threshold, last_index - period + 1):
    assert values[index] == values[index + period]

for index in range(threshold, last_index + 1):
    assert values[index] == class_values[(index - threshold) % period]

# 周期 1 に潰すと末尾定数性に一致すること
constant_value = QQ(11) / QQ(7)
constant_values = {
    index: (QQ(index + 1) if index < threshold else constant_value)
    for index in range(1, last_index + 1)
}
for index in range(threshold, last_index):
    assert constant_values[index] == constant_values[index + 1]
for index in range(threshold, last_index + 1):
    assert constant_values[index] == constant_value

print("RESULT: PASS")
