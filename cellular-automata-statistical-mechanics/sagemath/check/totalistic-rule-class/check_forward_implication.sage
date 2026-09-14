# 対象ラベル: claim_totalistic_pairwise_characterization
# 併せて検証: def_totalistic_local_rule_family, def_totalistic_local_signature
# 順方向: f_v(x)=phi(s_v(x)) なら s_u(x)=s_v(y) から f_u(x)=f_v(y) が従う。
# 帰属: 有限集合、有限写像表、ZZ。対数、除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

stage_count = ZZ(0)
table_count = ZZ(0)
comparison_count = ZZ(0)

for cell_count in range(4):
    for cells, stage in closed_neighborhood_stages(cell_count):
        stage_count += 1
        entries = local_input_entries(cells, stage)
        for table in all_binary_tables(signature_domain(cell_count)):
            family = induced_family(cells, stage, table)
            for u, x in entries:
                for v, y in entries:
                    if local_signature(stage, u, x) == local_signature(stage, v, y):
                        assert family[(u, x)] == table[local_signature(stage, u, x)]
                        assert table[local_signature(stage, u, x)] == table[local_signature(stage, v, y)]
                        assert table[local_signature(stage, v, y)] == family[(v, y)]
                    comparison_count += 1
            assert pairwise_condition(cells, stage, family)
            table_count += 1

assert stage_count == ZZ(12)
assert table_count == ZZ(2196)
assert comparison_count > 0
print('closed-neighborhood stages checked:', stage_count)
print('totalistic tables checked:', table_count)
print('local-input pairs checked:', comparison_count)
print('RESULT: PASS')
