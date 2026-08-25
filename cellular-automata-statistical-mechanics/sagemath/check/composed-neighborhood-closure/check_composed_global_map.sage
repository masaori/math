# 対象ラベル: claim_global_map_composition_representable_on_composed_neighborhood
# 大域写像の合成 F o G が合成局所規則族の大域写像 H に一致すること、および F o G が
# 合成近傍上の大域写像全体 M(V, N*M) に属することを、|V| <= 2 の全ての近傍割り当てと
# 全ての局所規則族の組で検査する。M(V, N*M) は合成近傍上の全局所規則族の列挙で独立に作る。
# 帰属: 有限集合、有限写像表、0/1 の等号だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

identity_checks = 0
membership_checks = 0
for cell_count in range(1, 3):
    cells = tuple(range(cell_count))
    configurations = tuple(product((0, 1), repeat=cell_count))
    place = {configuration: number for number, configuration in enumerate(configurations)}
    automata = cellular_automata(cells)
    tables = tuple(global_table(cells, configurations, place, neighborhood, rules)
                   for neighborhood, rules in automata)
    # 近傍割り当てごとの M(V, N) を独立に集める
    maps_of = {}
    for (neighborhood, _rules), table in zip(automata, tables):
        maps_of.setdefault(neighborhood, set()).add(table)
    for outer_position, (outer, outer_rules) in enumerate(automata):
        for inner_position, (inner, inner_rules) in enumerate(automata):
            composed, composed_rules = composed_rule_family(
                cells, outer, outer_rules, inner, inner_rules)
            composed_table = global_table(
                cells, configurations, place, composed, composed_rules)
            outer_table = tables[outer_position]
            inner_table = tables[inner_position]
            product_table = tuple(outer_table[inner_table[point]]
                                  for point in range(len(configurations)))
            assert product_table == composed_table
            identity_checks += 1
            assert product_table in maps_of[composed]
            membership_checks += 1

print(f"PASS composition_identities={identity_checks} memberships={membership_checks}")
