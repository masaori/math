# 対象ラベル: claim_reachability_approximation_stabilizes
# 増大性、再帰式、真の増加、二乗上界、安定の永続を各段に分けて検査する。
# 帰属: 有限集合、有限写像表、ZZ だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

checked = 0
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    identity = identity_assignment(cells)
    for assignment in neighborhood_assignments(cells):
        values = [approximation(cells, assignment, k) for k in range(n * n + 3)]
        counts = [ZZ(sum(len(part) for part in value)) for value in values]
        for k in range(len(values) - 1):
            assert included(values[k], values[k + 1])
            assert values[k + 1] == pointwise_union(identity, compose(values[k], assignment))
            assert counts[k] <= counts[k + 1] <= n * n
            if values[k] != values[k + 1]:
                assert counts[k] + 1 <= counts[k + 1]
        stable = [k for k in range(n * n + 1) if values[k] == values[k + 1]]
        assert stable
        first = stable[0]
        assert first <= n * n
        assert all(value == values[first] for value in values[first:])
        checked += 1

print("PASS check_approximation_and_stabilization")
print("  assignments checked:", checked)
