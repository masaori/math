# 対象ラベル: claim_block_phase_characterization
# 併せて検証: def_block_local_rule_family, def_block_phase_update
# 逆方向: ブロック内入力だけへの依存から零延長で局所規則族を復元し、元の写像を再構成する。
# 帰属: 有限集合、有限写像表、ZZ。対数、除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

map_partition_pair_count = ZZ(0)
accepted_pair_count = ZZ(0)
local_input_count = ZZ(0)

for cell_count in range(3):
    cells = tuple(range(cell_count))
    inputs = configurations(cells)
    for partition in block_partitions(cells):
        for global_map in all_global_maps(cells):
            if block_dependence_condition(cells, partition, global_map):
                family = reconstruct_family(cells, partition, global_map)
                for block in partition:
                    for local_configuration in configurations(block):
                        extended = extend_by_zero(cells, block, local_configuration)
                        assert restrict_configuration(extended, block) == local_configuration
                        assert family[block][local_configuration] == restrict_configuration(global_map[extended], block)
                        local_input_count += 1
                assert global_map_from_family(cells, partition, family) == global_map
                accepted_pair_count += 1
            map_partition_pair_count += 1

assert map_partition_pair_count == ZZ(517)
assert accepted_pair_count == ZZ(277)
assert local_input_count == ZZ(1096)
print('global-map and partition pairs scanned:', map_partition_pair_count)
print('block-dependent pairs reconstructed:', accepted_pair_count)
print('local inputs used in reconstruction:', local_input_count)
print('RESULT: PASS')
