# 対象ラベル: claim_binary_field_linear_membership_finite_decidable
# 三条件の有限走査と、係数表による線形写像の独立な全数列挙を比較する。
# 帰属: 有限集合と二元体の有限表。対数、除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

neighborhood_count = ZZ(0)
table_count = ZZ(0)
accepted_count = ZZ(0)
for cell_count in range(3):
    cells = tuple(range(cell_count))
    for flags in itertools.product((False, True), repeat=cell_count):
        neighborhood = frozenset(cell for cell, present in zip(cells, flags) if present)
        local_inputs = inputs(neighborhood)
        coefficient_tables = tuple(linear_table(neighborhood, coefficients)
                                   for coefficients in itertools.product(STATES, repeat=len(neighborhood)))
        for outputs in itertools.product(STATES, repeat=len(local_inputs)):
            table = dict(zip(local_inputs, outputs))
            by_scan = is_linear(neighborhood, table)
            by_coefficients = any(table == candidate for candidate in coefficient_tables)
            assert by_scan == by_coefficients
            accepted_count += ZZ(by_scan)
            table_count += 1
        neighborhood_count += 1

assert neighborhood_count == ZZ(7)
assert table_count == ZZ(34)
assert accepted_count == ZZ(13)
print('neighborhoods checked:', neighborhood_count)
print('all local truth tables checked:', table_count)
print('linear tables accepted:', accepted_count)
print('RESULT: PASS')
