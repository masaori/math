# 対象ラベル: claim_neighborhood_mutual_reachability_components_partition
# 成分の所属特徴づけ、自己転置性、被覆性、交わる成分の一致を分けて検査する。
# 帰属: 有限集合、有限部分集合、有限写像表だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

assignments_checked = 0
component_pairs_checked = 0
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    for assignment in neighborhood_assignments(cells):
        result = closure(cells, assignment)
        transposed = transpose(cells, result)
        component_assignment = components(cells, result)

        assert component_assignment == pointwise_intersection(result, transposed)
        for v in cells:
            for w in cells:
                assert (w in component_assignment[v]) == (
                    w in result[v] and w in transposed[v]
                )
                assert (w in transposed[v]) == (v in result[w])
                assert (w in component_assignment[v]) == mutually_reachable(result, v, w)

        assert transpose(cells, component_assignment) == component_assignment
        for v in cells:
            assert v in component_assignment[v]
            for u in cells:
                intersection = component_assignment[v] & component_assignment[u]
                if intersection:
                    witness = next(iter(intersection))
                    assert mutually_reachable(result, v, witness)
                    assert mutually_reachable(result, u, witness)
                    assert component_assignment[v] == component_assignment[u]
                component_pairs_checked += 1
        assignments_checked += 1

print("PASS check_components_and_partition")
print("  assignments checked:", assignments_checked)
print("  component pairs checked:", component_pairs_checked)
