# 対象ラベル: claim_finite_local_factor_step_comparison_decidable
# 判定: 一元・二元舞台の全完全近傍真理値表族について、局所因子から抽出した全成分を有限走査し、零一指示行列との等号を決定する。
# 帰属: 二元有限配位集合、有限真理値表、有限外積係数表、ZZ。対数、除算、実数体、複素数体、浮動小数点は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

total_rule_families = ZZ(0)
total_matrix_entries = ZZ(0)
distinct_global_updates = {}

for cell_count in (1, 2):
    cells = tuple(ZZ(value) for value in range(cell_count))
    states = binary_configurations(cells)
    update_tables = set()
    rule_family_count = ZZ(0)
    for truth_bits in product((ZZ(0), ZZ(1)), repeat=len(cells) * len(states)):
        rule_family = full_neighborhood_rule_family(cells, states, truth_bits)
        global_update = global_update_from_full_neighborhood(cells, states, rule_family)
        update_tables.add(tuple(global_update[source] for source in states))
        for source, target in product(states, repeat=2):
            extracted = top_coefficient(
                cells,
                ordered_local_factor_product(cells, rule_family, source, target),
            )
            indicator = ZZ(1) if target == global_update[source] else ZZ(0)
            assert extracted == indicator
            total_matrix_entries += 1
        rule_family_count += 1
    expected_self_maps = ZZ(len(states)) ** len(states)
    assert rule_family_count == expected_self_maps
    assert len(update_tables) == expected_self_maps
    distinct_global_updates[cell_count] = ZZ(len(update_tables))
    total_rule_families += rule_family_count

assert distinct_global_updates == {1: ZZ(4), 2: ZZ(256)}
assert total_rule_families == ZZ(260)
assert total_matrix_entries == ZZ(4) * ZZ(4) + ZZ(256) * ZZ(16)
print('rule families checked:', total_rule_families)
print('distinct global updates by cell count:', distinct_global_updates)
print('matrix entries decided:', total_matrix_entries)
print('RESULT: PASS')
