# 対象ラベル: claim_union_preserving_map_determined_by_singletons
# 空集合の場合と、S' = S ∖ {u} から S = S' ∪ {u} へ進む帰納段階を分けて検査する。
# 帰属: 有限集合と有限部分集合だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

maps_scanned = 0
subsets_scanned = 0
for n in (0, 1, 2):
    cells = tuple(range(n))
    domain = tuple(subsets(cells))
    for table in all_subset_maps(cells):
        if not is_union_preserving(cells, table):
            continue
        maps_scanned += 1
        assert table_value(cells, table, frozenset()) == frozenset()
        for S in domain:
            subsets_scanned += 1
            singleton_union = frozenset().union(*(
                table_value(cells, table, frozenset((v,))) for v in S
            ))
            assert table_value(cells, table, S) == singleton_union
            if S:
                u = min(S)
                S_prime = S - frozenset((u,))
                assert S == S_prime | frozenset((u,))
                assert len(S_prime) + 1 == len(S)
                assert table_value(cells, table, S) == (
                    table_value(cells, table, S_prime)
                    | table_value(cells, table, frozenset((u,)))
                )

print("union-preserving maps scanned:", maps_scanned)
print("subsets scanned:", subsets_scanned)
print("PASS check_singleton_determination")
