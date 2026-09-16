# 対象ラベル: claim_binary_finite_total_shell_cardinality
# 式ペア: |Sigma_U| = sum_{x in X_A} Omega_B(U-H_A(x))。
# 帰属: 有限集合、ZZ、NN。対数、除算、実数体、浮動小数点は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

system_count = ZZ(0)
fiber_count = ZZ(0)
for first_set, second_set, first_observation, second_observation, total in sample_systems():
    shell = shell_pairs(first_set, second_set, first_observation, second_observation, total)
    fiber_sum = ZZ(0)
    for first_index in range(len(first_set)):
        fiber = tuple(
            second_index
            for second_index in range(len(second_set))
            if (first_index, second_index) in shell
        )
        expected_fiber_size = multiplicity(
            second_set,
            second_observation,
            total - first_observation[first_index],
        )
        assert ZZ(len(fiber)) == expected_fiber_size
        fiber_sum += expected_fiber_size
        fiber_count += 1
    assert ZZ(len(shell)) == fiber_sum
    system_count += 1

assert system_count > 0
assert fiber_count > 0
print('finite observation systems checked:', system_count)
print('first-coordinate fibers checked:', fiber_count)
print('RESULT: PASS')
