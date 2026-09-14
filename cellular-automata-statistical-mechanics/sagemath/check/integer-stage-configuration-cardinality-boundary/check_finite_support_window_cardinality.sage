# 対象ラベル: claim_integer_stage_finite_support_configurations_countable
# 併せて検証: def_integer_stage_finite_support_configurations
# 式ペア・判定: x -> supp_1(x) が二値の有限窓配位上で単射であり、
#                 |X_k| = 2^|D_k| = 2^(2k+1)。
# 帰属: 有限集合と NN。浮動小数点、除算、R/C、全配位、極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

windows_checked = 0
configurations_checked = 0
for radius in range(0, 9):
    window = integer_window(radius)
    configurations = finite_window_configurations(radius)
    expected_count = ZZ(2) ** ZZ(2 * radius + 1)
    encoded_supports = set()

    assert ZZ(len(window)) == ZZ(2 * radius + 1)
    for values in configurations:
        support = one_support(radius, values)
        assert all(position in window for position in support)
        assert all(
            (position in support) == (value == 1)
            for position, value in zip(window, values)
        )
        encoded_supports.add(tuple(support))

    assert ZZ(len(encoded_supports)) == expected_count
    assert ZZ(len(configurations)) == expected_count
    windows_checked += 1
    configurations_checked += len(configurations)

assert windows_checked > 0
assert configurations_checked > 0
print('finite-support windows checked:', windows_checked)
print('finite-support configurations checked:', configurations_checked)
print('RESULT: PASS')
