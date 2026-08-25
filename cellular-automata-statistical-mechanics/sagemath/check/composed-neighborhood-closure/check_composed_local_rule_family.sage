# 対象ラベル: def_composed_local_rule_family
# 合成局所規則族 h_v が A^{(N*M)(v)} 上の有限真理値表であること（引数が A^{N(v)} の元になること、
# 表の大きさが 2^{|(N*M)(v)|} であること）と、セルごとの一致
# h_v( rho^V_{(N*M)(v)} x ) = f_v( rho^V_{N(v)} (Gx) ) を、
# |V| <= 2 の全ての近傍割り当てと全ての局所規則族の組で検査する。
# 帰属: 有限集合、有限写像表、0/1 の等号だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

table_checks = 0
pointwise_checks = 0
for cell_count in range(1, 3):
    cells = tuple(range(cell_count))
    configurations = tuple(product((0, 1), repeat=cell_count))
    automata = cellular_automata(cells)
    for outer, outer_rules in automata:
        for inner, inner_rules in automata:
            composed, composed_rules = composed_rule_family(
                cells, outer, outer_rules, inner, inner_rules)
            for v in cells:
                assert composed[v] <= frozenset(cells)
                assert len(composed_rules[v]) == 2 ** len(composed[v])
                for z, value in composed_rules[v].items():
                    assert len(z) == len(composed[v])
                    assert value in (0, 1)
                    # h_v(z) は f_v を N(v) の座標に沿った組へ適用した値である
                    argument = tuple(
                        inner_rules[u][restrict(z, index_tuple(composed[v]), inner[u])]
                        for u in index_tuple(outer[v]))
                    assert len(argument) == len(outer[v])
                    assert value == outer_rules[v][argument]
                    table_checks += 1
            for x in configurations:
                image = tuple(inner_rules[u][restrict(x, cells, inner[u])] for u in cells)
                for v in cells:
                    left = composed_rules[v][restrict(x, cells, composed[v])]
                    right = outer_rules[v][restrict(image, cells, outer[v])]
                    assert left == right
                    pointwise_checks += 1

print(f"PASS truth_table_entries={table_checks} pointwise={pointwise_checks}")
