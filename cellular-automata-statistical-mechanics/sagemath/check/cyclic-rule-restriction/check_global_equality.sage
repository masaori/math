# 対象ラベル: claim_cyclic_rule_global_equality
# 式ペア・判定: 表の両立入力上の制限と大域写像の等号が同じ同値類を定めることを全数検査する。
# 帰属: 有限集合と有限写像表。浮動小数点と R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

tables_scanned = 0
for radius in (0, 1):
    arguments = bit_assignments(offsets(radius))
    tables = truth_tables(radius)
    for length in range(1, 7):
        admissible = set(admissible_inputs(length, radius))
        restricted_groups = {}
        global_groups = {}
        for table in tables:
            restriction = tuple(table[index] for index, argument in enumerate(arguments) if argument in admissible)
            global_table = global_map_table(table, length, radius)
            restricted_groups.setdefault(restriction, set()).add(table)
            global_groups.setdefault(global_table, set()).add(table)
            tables_scanned += 1
        assert {frozenset(group) for group in restricted_groups.values()} == {
            frozenset(group) for group in global_groups.values()
        }

print('tables classified:', tables_scanned)
print('RESULT: PASS')

