# 対象ラベル: claim_neighborhood_mutual_reachability_component_representative
# 成分の非空性と、成分の任意の元が同じ成分を代表することを分けて検査する。
# 帰属: 有限集合と有限写像表だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

assignments_checked = 0
representatives_checked = 0
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    for assignment in neighborhood_assignments(cells):
        result = closure(cells, assignment)
        component_assignment = components(cells, result)
        quotient = component_set(cells, result)

        assert set(quotient) == set(component_assignment)
        for value in quotient:
            assert value
            for v in value:
                assert v in component_assignment[v]
                assert value == component_assignment[v]
                representatives_checked += 1
        assignments_checked += 1

print("PASS check_component_set_and_representatives")
print("  assignments checked:", assignments_checked)
print("  representatives checked:", representatives_checked)
