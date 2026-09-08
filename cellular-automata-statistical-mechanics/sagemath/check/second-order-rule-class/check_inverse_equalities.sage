# 対象ラベル: claim_second_order_inverse_after_evolution
# 併せて検証: claim_binary_state_addition_cancellation, claim_second_order_evolution_after_inverse, theorem_second_order_global_evolution_bijective
# 二元体加法の二つの消去等式と、二時刻発展・逆写像候補の左右の合成を有限全数検査する。
# 帰属: 有限集合と二元体加法の有限表。対数、除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

cancellation_count = ZZ(0)
for a in STATES:
    for b in STATES:
        assert add(add(a, b), a) == b
        assert add(a, add(b, a)) == b
        cancellation_count += 2

stage_count = ZZ(0)
family_count = ZZ(0)
composition_count = ZZ(0)
for cell_count in range(3):
    for cells, stage in stages(cell_count):
        local_base_tables = tuple(all_tables(inputs(stage[cell])) for cell in cells)
        for chosen_tables in itertools.product(*local_base_tables):
            family = dict(zip(cells, chosen_tables))
            configurations_here = configurations(cells)
            for previous in configurations_here:
                for current in configurations_here:
                    following_pair = evolution(cells, stage, family, previous, current)
                    assert inverse_candidate(cells, stage, family, *following_pair) == (previous, current)
                    composition_count += 1
            for current in configurations_here:
                for following in configurations_here:
                    previous_pair = inverse_candidate(cells, stage, family, current, following)
                    assert evolution(cells, stage, family, *previous_pair) == (current, following)
                    composition_count += 1
            family_count += 1
        stage_count += 1

assert cancellation_count == ZZ(8)
assert stage_count == ZZ(19)
assert family_count == ZZ(683)
assert composition_count == ZZ(21682)
print('binary cancellation equalities checked:', cancellation_count)
print('finite stages checked:', stage_count)
print('base local-rule families checked:', family_count)
print('two-sided composition equalities checked:', composition_count)
print('RESULT: PASS')
