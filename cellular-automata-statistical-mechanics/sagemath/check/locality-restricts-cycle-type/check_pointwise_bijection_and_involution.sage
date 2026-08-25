# claim_self_neighborhood_injective_iff_pointwise_bijective と
# claim_self_neighborhood_involution の検算。
# 3 セル自己近傍舞台の全 64 局所規則族について両方向と反復の各段を検査する。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

identity = (0, 1)
negation = (1, 0)
checked_families = 0
checked_reversible = 0
for family in self_neighborhood_families(3):
    table = global_table(family)
    globally_injective = len(set(table)) == 8
    pointwise_bijective = all(len(set(rule)) == 2 for rule in family)
    assert globally_injective == pointwise_bijective
    checked_families += 1
    if not globally_injective:
        continue
    assert all(rule in (identity, negation) for rule in family)
    # F^2 x = F(F x) = x を全配位で検査する。
    assert all(table[table[x]] == x for x in range(8))
    checked_reversible += 1

assert checked_reversible == 2 ** 3
print(f"PASS families={checked_families} reversible={checked_reversible}")

