# 対象ラベル: claim_subset_union_map_preserves_empty
# 併せて検査するラベル: claim_subset_union_map_preserves_union
# U_N が空集合と二項合併を保つ証明を、所属の同値ごとに検査する。
# 帰属: 有限集合と有限部分集合だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

assignments_scanned = 0
triples_scanned = 0
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    domain = tuple(subsets(cells))
    for N in neighborhood_assignments(cells):
        assignments_scanned += 1
        assert union_map_value(N, frozenset()) == frozenset()
        for S in domain:
            for T in domain:
                triples_scanned += 1
                for w in cells:
                    step_definition = any(w in N[v] for v in S | T)
                    step_union_membership = any(
                        ((v in S) or (v in T)) and (w in N[v]) for v in cells
                    )
                    step_distribution = any(
                        ((v in S) and (w in N[v])) or ((v in T) and (w in N[v]))
                        for v in cells
                    )
                    step_exists_split = (
                        any(w in N[v] for v in S) or any(w in N[v] for v in T)
                    )
                    step_image_membership = (
                        w in union_map_value(N, S) or w in union_map_value(N, T)
                    )
                    step_union_image = w in (union_map_value(N, S) | union_map_value(N, T))
                    assert step_definition == step_union_membership
                    assert step_union_membership == step_distribution
                    assert step_distribution == step_exists_split
                    assert step_exists_split == step_image_membership
                    assert step_image_membership == step_union_image
                assert union_map_value(N, S | T) == union_map_value(N, S) | union_map_value(N, T)

print("assignments scanned:", assignments_scanned)
print("assignment-subset pairs scanned:", triples_scanned)
print("PASS check_union_map_preserves_conditions")
