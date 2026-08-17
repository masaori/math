# SageMath: 固定剰余類格子の係数列の支持と偶数性
# 対象ラベル: theorem_fixed_quotient_coefficient_support
# 帰属: 有限集合、NN、ZZ だけを用いる

import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(
    os.path.join(
        check_directory,
        "../fixed-quotient-ising-partition-polynomial/check_coefficients.sage",
    )
)

expected_support = (0, 7, 12, 14, 15) + tuple(range(17, 57))
actual_support = tuple(
    broken_edge_count
    for broken_edge_count, coefficient in enumerate(coefficient_by_broken_edge_count)
    if coefficient > 0
)

assert actual_support == expected_support
assert all(
    coefficient_by_broken_edge_count[broken_edge_count] % 2 == 0
    and coefficient_by_broken_edge_count[broken_edge_count] > 0
    for broken_edge_count in expected_support
)
assert all(
    coefficient_by_broken_edge_count[broken_edge_count] == 0
    for broken_edge_count in set(range(85)).difference(expected_support)
)

# 大域反転は各端点の二値を同時に反転する。四つの端点値の組で
# 不一致条件が保存されることを厳密に照合する。
for source_spin in (0, 1):
    for target_spin in (0, 1):
        assert ((1 - source_spin) != (1 - target_spin)) == (
            source_spin != target_spin
        )

full_configuration_mask = 2**len(vertices) - 1


def global_spin_flip(configuration):
    return configuration ^^ full_configuration_mask


assert full_configuration_mask > 0
for configuration in (0, 1, full_configuration_mask - 1, full_configuration_mask):
    assert global_spin_flip(configuration) != configuration
    assert global_spin_flip(global_spin_flip(configuration)) == configuration

print(
    "RESULT: PASS — the exact coefficient support is "
    "{0,7,12,14,15} union {17,...,56}, every supported coefficient is a "
    "positive even integer, and global spin reversal preserves broken edges"
)
