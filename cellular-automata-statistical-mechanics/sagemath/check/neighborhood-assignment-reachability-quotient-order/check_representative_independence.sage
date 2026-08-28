# 対象ラベル: claim_neighborhood_mutual_reachability_component_order_representative_independent
# 一組の代表による到達と、全ての代表による到達が同値であることを検査する。
# 帰属: 有限集合と有限関係だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

assignments_checked = 0
component_pairs_checked = 0
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    for assignment in neighborhood_assignments(cells):
        result = closure(cells, assignment)
        quotient = component_set(cells, result)
        for left in quotient:
            for right in quotient:
                exists_representatives = component_reaches(result, left, right)
                all_representatives = all_representatives_reach(result, left, right)
                assert exists_representatives == all_representatives
                if exists_representatives:
                    for v in left:
                        for w in right:
                            assert reachable(result, v, w)
                component_pairs_checked += 1
        assignments_checked += 1

print("PASS check_representative_independence")
print("  assignments checked:", assignments_checked)
print("  component pairs checked:", component_pairs_checked)
