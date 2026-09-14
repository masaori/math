# 対象ラベル: claim_block_phase_membership_finite_decidable
# 併せて検証: claim_block_phase_characterization
# 有限入力対の走査と、全ブロック局所規則族の独立な存在走査が一致することを検査する。
# 帰属: 有限集合、有限写像表、ZZ。対数、除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

pair_count = ZZ(0)
accepted_count = ZZ(0)
rejected_count = ZZ(0)

for cell_count in range(3):
    cells = tuple(range(cell_count))
    for partition in block_partitions(cells):
        represented_maps = tuple(global_map_from_family(cells, partition, family) for family in block_rule_families(partition))
        assert len({tuple(candidate.items()) for candidate in represented_maps}) == len(represented_maps)
        for global_map in all_global_maps(cells):
            by_finite_scan = block_dependence_condition(cells, partition, global_map)
            by_rule_family_existence = global_map in represented_maps
            assert by_finite_scan == by_rule_family_existence
            if by_finite_scan:
                accepted_count += 1
            else:
                rejected_count += 1
            pair_count += 1

assert pair_count == ZZ(517)
assert accepted_count == ZZ(277)
assert rejected_count == ZZ(240)
assert accepted_count + rejected_count == pair_count
print('global-map and partition pairs scanned:', pair_count)
print('accepted and rejected:', accepted_count, rejected_count)
print('RESULT: PASS')
