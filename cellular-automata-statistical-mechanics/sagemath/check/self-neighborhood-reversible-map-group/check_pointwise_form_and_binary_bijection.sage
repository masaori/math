# claim_general_self_neighborhood_pointwise_form,
# claim_binary_bijection_is_identity_or_negation,
# claim_general_self_neighborhood_reversible_pointwise_bijective の検算。
# 1 <= |V| <= 5 の自己近傍舞台で全 4^|V| 局所規則族を走査する。

import itertools
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

# 2 元集合上の全単射は恒等写像か否定写像に限る。
bijections = tuple(g for g in unary_rules() if len(set(g)) == 2)
assert set(bijections) == {(0, 1), (1, 0)}
assert (0, 1) == (0, 1)              # id_A
assert (1, 0) == (negation(0), negation(1))  # nu

checked_families = 0
checked_reversible = 0
for cell_count in range(1, 6):
    configs = configurations(cell_count)
    for family in self_neighborhood_families(cell_count):
        table = global_table(family)
        # 点ごとの表示: (F x)(v) = g_v(x(v))
        for position, config in enumerate(configs):
            image = configs[table[position]]
            assert image == tuple(family[v][config[v]] for v in range(cell_count))
        # 大域写像が単射なら各セルの値写像は全単射
        if is_injective(table):
            for v in range(cell_count):
                assert len(set(family[v])) == 2
            checked_reversible += 1
        else:
            assert any(len(set(family[v])) == 1 for v in range(cell_count))
        checked_families += 1

print(f"PASS families={checked_families} reversible={checked_reversible}")
