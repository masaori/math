# 対象ラベル: def_cyclic_stage_fixed_point_count_sequence
# 併せて検証: def_cyclic_stage_global_map_family
# 式ペア・判定: 固定した有限真理値表が各有限巡回舞台に有限自己写像を定め、Z は反復不動点集合の元数である。
# 帰属: 有限集合と NN。浮動小数点と R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

rows_checked = 0
for radius in (0, 1):
    for table in truth_tables(radius):
        for length in range(1, 7):
            domain = configurations(length)
            images = tuple(global_image(configuration, length, radius, table)
                           for configuration in domain)
            assert len(images) == len(domain) == ZZ(2) ** length
            assert all(image in domain for image in images)
            for exponent in range(1, 5):
                fixed = fixed_points(length, radius, table, exponent)
                count = ZZ(len(fixed))
                assert count == sum(ZZ(1) for configuration in domain
                                    if iterate_global(configuration, length, radius, table, exponent) == configuration)
                assert ZZ(0) <= count <= ZZ(2) ** length
                rows_checked += 1

assert rows_checked > 0
print('stage-table-exponent rows checked:', rows_checked)
print('RESULT: PASS')
