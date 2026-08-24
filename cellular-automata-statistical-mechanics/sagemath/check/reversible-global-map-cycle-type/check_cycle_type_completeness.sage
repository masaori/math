# claim_reversible_cycle_type_completeness の検算。
# 元数 1,2,4 の配位集合上の単射な自己写像の全ての順序対について、
# 巡回型が一致する対では構成 h(F^r(q_O)) := G^r(q'_O) が全単射かつ h∘F = G∘h を満たすこと、
# 巡回型が異なる対では有限置換の全数走査で共役全単射が存在しないことを検査する。
# 元数 8 では、同じ巡回型を持つ代表と各写像の間で同じ構成を作り、共役条件を検査する。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

checked_equal = 0
checked_different = 0
for size in (1, 2, 4):
    tables = injective_maps(size)
    permutations = tuple(itertools.permutations(range(size)))
    for table_f in tables:
        for table_g in tables:
            if cycle_type(table_f) == cycle_type(table_g):
                h = build_conjugacy_from_cycle_type(table_f, table_g)
                assert len(set(h)) == size
                assert all(h[table_f[y]] == table_g[h[y]] for y in range(size))
                checked_equal += 1
            else:
                assert not any(
                    conjugate_table(table_f, permutation) == table_g
                    for permutation in permutations
                )
                checked_different += 1

checked_size_eight = 0
representative = {}
for table in injective_maps(8):
    representative.setdefault(cycle_type(table), table)
for table in injective_maps(8):
    table_f = representative[cycle_type(table)]
    h = build_conjugacy_from_cycle_type(table_f, table)
    assert len(set(h)) == 8
    assert all(h[table_f[y]] == table[h[y]] for y in range(8))
    checked_size_eight += 1

print(f"PASS equal_pairs={checked_equal} different_pairs={checked_different} size8={checked_size_eight}")
