# 対象ラベル: claim_second_order_membership_finite_decidable
# 定義式の有限走査と、基礎表から生成される二次表の独立な全数列挙を比較する。
# 帰属: 有限集合と二元体加法の有限表。対数、除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

neighborhood_count = ZZ(0)
table_count = ZZ(0)
accepted_count = ZZ(0)
for cell_count in range(3):
    cells = tuple(range(cell_count))
    for flags in itertools.product((False, True), repeat=cell_count):
        neighborhood = frozenset(cell for cell, present in zip(cells, flags) if present)
        generated = tuple(lift_base_table(neighborhood, base) for base in all_tables(inputs(neighborhood)))
        for table in all_tables(second_order_domain(neighborhood)):
            by_scan = is_second_order(neighborhood, table)
            by_generation = any(table == candidate for candidate in generated)
            assert by_scan == by_generation
            accepted_count += ZZ(by_scan)
            table_count += 1
        neighborhood_count += 1

assert neighborhood_count == ZZ(7)
assert table_count == ZZ(316)
assert accepted_count == ZZ(34)
print('neighborhoods checked:', neighborhood_count)
print('two-time truth tables checked:', table_count)
print('second-order tables accepted:', accepted_count)
print('RESULT: PASS')
