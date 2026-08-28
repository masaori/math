# 対象ラベル: claim_neighborhood_mutual_reachability_component_order_finite_decidable
# 商の元数上界、代表による関係表の構成、所属判定回数の上界を検査する。
# 帰属: 有限集合、有限写像表、ZZ だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

assignments_checked = 0
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    base_bound = ZZ((n * n + 1) * n ** 3 + 3 * n * n)
    total_bound = ZZ((n * n + 1) * n ** 3 + 4 * n * n)
    for assignment in neighborhood_assignments(cells):
        result = closure(cells, assignment)
        quotient = component_set(cells, result)
        assert len(quotient) <= n

        representatives = {value: min(value) for value in quotient}
        membership_tests = ZZ(0)
        relation_table = {}
        for left in quotient:
            for right in quotient:
                membership_tests += 1
                relation_table[(left, right)] = (
                    representatives[right] in result[representatives[left]]
                )
                assert relation_table[(left, right)] == component_reaches(result, left, right)

        assert membership_tests == len(quotient) ** 2
        assert membership_tests <= n ** 2
        assert base_bound + membership_tests <= total_bound
        assignments_checked += 1

print("PASS check_finite_decidability")
print("  assignments checked:", assignments_checked)
