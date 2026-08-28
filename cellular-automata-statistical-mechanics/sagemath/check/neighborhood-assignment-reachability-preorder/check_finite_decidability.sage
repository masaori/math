# 対象ラベル: claim_neighborhood_reachability_preorder_finite_decidable
# 本文の有限表構成と所属判定回数の上界を段ごとに検査する。
# 帰属: 有限集合、有限写像表、ZZ だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

assignments_checked = 0
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    closure_bound = ZZ((n * n + 1) * n ** 3)
    total_bound = closure_bound + ZZ(3 * n * n)
    for assignment in neighborhood_assignments(cells):
        result = closure(cells, assignment)
        membership_tests = ZZ(0)

        reachability_table = {}
        for v in cells:
            for w in cells:
                membership_tests += 1
                reachability_table[(v, w)] = w in result[v]

        mutual_table = {
            (v, w): reachability_table[(v, w)] and reachability_table[(w, v)]
            for v in cells
            for w in cells
        }

        component_table = []
        for v in cells:
            value = set()
            for w in cells:
                membership_tests += 2
                if w in result[v] and v in result[w]:
                    value.add(w)
            component_table.append(frozenset(value))

        assert mutual_table == {
            (v, w): mutually_reachable(result, v, w) for v in cells for w in cells
        }
        assert tuple(component_table) == components(cells, result)
        assert membership_tests == 3 * n * n
        assert closure_bound + membership_tests == total_bound
        assignments_checked += 1

print("PASS check_finite_decidability")
print("  assignments checked:", assignments_checked)
