# 対象ラベル: claim_union_preserving_map_finite_decidable
# 有限表から二条件を所属判定で決定し、真なら一元部分集合の値から N を構成する手続きを検査する。
# 帰属: 自然数、有限集合、有限部分集合、有限写像表だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

maps_scanned = 0
for n in (0, 1, 2):
    cells = tuple(range(n))
    domain = tuple(subsets(cells))
    for table in all_subset_maps(cells):
        maps_scanned += 1
        empty_condition = all(
            w not in table_value(cells, table, frozenset()) for w in cells
        )
        union_condition = all(
            all(
                (w in table_value(cells, table, S | T))
                == (w in (table_value(cells, table, S) | table_value(cells, table, T)))
                for w in cells
            )
            for S in domain for T in domain
        )
        decision = empty_condition and union_condition
        assert decision == is_union_preserving(cells, table)
        membership_test_bound = n + (2 ** (2 * n)) * n
        assert membership_test_bound in ZZ
        if decision:
            N = reconstruct_assignment(cells, table)
            assert len(N) == n
            assert union_map_table(cells, N) == table

print("all subset maps scanned for n <= 2:", maps_scanned)
print("PASS check_finite_decidability")
