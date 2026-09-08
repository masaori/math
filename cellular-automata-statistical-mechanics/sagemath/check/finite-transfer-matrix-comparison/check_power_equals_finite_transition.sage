# 対象ラベル: claim_transfer_matrix_power_equals_finite_step_weight
# 零回の等号指示値と、有限和積による帰納段を別々に照合し、行列冪と有限回遷移重みの成分一致を検査する。
# 帰属: 有限集合、QQ、ZZ、n in NN。浮動小数点、対数、極限、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

family_count = ZZ(0)
power_count = ZZ(0)
entry_count = ZZ(0)
recursion_entry_count = ZZ(0)

for family in sample_probabilistic_families():
    cell_count = len(family)
    states = configurations(cell_count)
    one_step = transition_matrix(family, cell_count)
    matrix = transfer_matrix_from_kernel(one_step)
    finite_transition = identity_transition(cell_count)
    for exponent in range(5):
        power = transfer_power(matrix, exponent)
        for source in states:
            for target in states:
                assert power[source][target] == finite_transition[source][target]
                entry_count += 1
        power_count += 1
        if exponent < 4:
            next_finite_transition = compose_transitions(finite_transition, one_step)
            next_power = transfer_power(matrix, exponent + 1)
            for source in states:
                for target in states:
                    defining_sum = sum(
                        (power[source][middle] * matrix[middle][target] for middle in states),
                        QQ(0),
                    )
                    assert next_power[source][target] == defining_sum
                    assert defining_sum == next_finite_transition[source][target]
                    recursion_entry_count += 1
            finite_transition = next_finite_transition
    family_count += 1

assert family_count == ZZ(13)
assert power_count == ZZ(65)
assert entry_count == ZZ(425)
assert recursion_entry_count == ZZ(340)
print('finite transition families checked:', family_count)
print('matrix powers checked:', power_count)
print('power-transition entries checked:', entry_count)
print('recursion entries checked:', recursion_entry_count)
print('RESULT: PASS')
