# 対象ラベル: claim_neighborhood_mutual_reachability_component_order_is_partial_order
# 商上の到達関係の反射性・推移性・反対称性を別々に検査する。
# 帰属: 有限集合と有限関係だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

assignments_checked = 0
component_triples_checked = 0
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    for assignment in neighborhood_assignments(cells):
        result = closure(cells, assignment)
        quotient = component_set(cells, result)
        for left in quotient:
            assert component_reaches(result, left, left)
            for middle in quotient:
                if component_reaches(result, left, middle) and component_reaches(result, middle, left):
                    assert left == middle
                for right in quotient:
                    if component_reaches(result, left, middle) and component_reaches(result, middle, right):
                        assert component_reaches(result, left, right)
                    component_triples_checked += 1
        assignments_checked += 1

print("PASS check_partial_order_properties")
print("  assignments checked:", assignments_checked)
print("  component triples checked:", component_triples_checked)
