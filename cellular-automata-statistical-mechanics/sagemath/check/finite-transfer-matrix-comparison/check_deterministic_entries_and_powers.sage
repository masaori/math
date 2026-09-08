# 対象ラベル: claim_deterministic_transfer_matrix_power_entry
# 併せて検証: def_deterministic_rule_zero_one_embedding, claim_deterministic_transfer_matrix_entry
# 零一埋め込みの一段成分と、有限和積による冪が決定論的大域写像の反復遷移指示値になることを検査する。
# 帰属: 二元有限集合、QQ、ZZ、n in NN。浮動小数点、対数、除算、極限、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

family_count = ZZ(0)
one_step_entry_count = ZZ(0)
power_entry_count = ZZ(0)

for cell_count in range(3):
    states = configurations(cell_count)
    for family in deterministic_families(cell_count):
        weight_family = deterministic_weight_family(family)
        matrix = transfer_matrix_from_kernel(transition_matrix(weight_family, cell_count))
        for source in states:
            updated = deterministic_global_update(family, source)
            row_ones = ZZ(0)
            for target in states:
                expected = QQ(1) if target == updated else QQ(0)
                assert matrix[source][target] == expected
                row_ones += ZZ(matrix[source][target])
                one_step_entry_count += 1
            assert row_ones == ZZ(1)
        for exponent in range(5):
            power = transfer_power(matrix, exponent)
            for source in states:
                updated = iterate_configuration(family, source, exponent)
                for target in states:
                    expected = QQ(1) if target == updated else QQ(0)
                    assert power[source][target] == expected
                    power_entry_count += 1
        family_count += 1

assert family_count == ZZ(261)
assert one_step_entry_count == ZZ(4113)
assert power_entry_count == ZZ(20565)
print('deterministic rule families checked:', family_count)
print('one-step indicator entries checked:', one_step_entry_count)
print('iterated indicator entries checked:', power_entry_count)
print('RESULT: PASS')
