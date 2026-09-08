# 対象ラベル: claim_block_phase_characterization
# 併せて検証: def_block_local_rule_family, def_block_phase_update
# 順方向: 一相更新なら、各ブロックの出力は同じブロックの入力だけに依存する。
# 帰属: 有限集合、有限写像表、ZZ。対数、除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

partition_count = ZZ(0)
family_count = ZZ(0)
comparison_count = ZZ(0)

for cell_count in range(3):
    cells = tuple(range(cell_count))
    inputs = configurations(cells)
    for partition in block_partitions(cells):
        partition_count += 1
        for family in block_rule_families(partition):
            global_map = global_map_from_family(cells, partition, family)
            for block in partition:
                for x in inputs:
                    for y in inputs:
                        if restrict_configuration(x, block) == restrict_configuration(y, block):
                            assert restrict_configuration(global_map[x], block) == family[block][restrict_configuration(x, block)]
                            assert family[block][restrict_configuration(x, block)] == family[block][restrict_configuration(y, block)]
                            assert family[block][restrict_configuration(y, block)] == restrict_configuration(global_map[y], block)
                        comparison_count += 1
            assert block_dependence_condition(cells, partition, global_map)
            family_count += 1

assert partition_count == ZZ(4)
assert family_count == ZZ(277)
assert comparison_count == ZZ(4624)
print('block partitions checked:', partition_count)
print('block-rule families checked:', family_count)
print('input-pair comparisons checked:', comparison_count)
print('RESULT: PASS')
