# 対象ラベル: theorem_probabilistic_global_transition_normalized
# 併せて検証: def_probabilistic_local_output_weight, def_probabilistic_global_transition_weight
# 大域遷移重みの総和を、有限和に対する有限積の分配則と局所正規化の各段へ分けて検査する。
# 帰属: 有限集合、QQ、ZZ。有理数体上の除算だけを使い、未定義の対数・除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_common.sage'))

allowed_weights = (QQ(0), QQ(1) / QQ(2), QQ(1))
family_count = ZZ(0)
source_count = ZZ(0)
transition_count = ZZ(0)

for cell_count in range(3):
    states = configurations(cell_count)
    for family in rule_families(cell_count, allowed_weights):
        family_count += 1
        for source in states:
            direct_sum = sum((global_transition_weight(family, source, target) for target in states), QQ(0))
            product_of_local_sums = prod(
                sum((local_output_weight(family[cell][source], output) for output in A), QQ(0))
                for cell in range(cell_count)
            )
            product_of_ones = prod(QQ(1) for _cell in range(cell_count))

            assert direct_sum == product_of_local_sums
            assert product_of_local_sums == product_of_ones
            assert product_of_ones == QQ(1)
            assert all(global_transition_weight(family, source, target) in QQ for target in states)
            assert all(global_transition_weight(family, source, target) >= QQ(0) for target in states)

            source_count += 1
            transition_count += len(states)

assert family_count == ZZ(6571)
assert source_count == ZZ(26263)
assert transition_count == ZZ(105013)
print('rational local-rule families checked:', family_count)
print('normalized source rows checked:', source_count)
print('global transition weights checked:', transition_count)
print('RESULT: PASS')
