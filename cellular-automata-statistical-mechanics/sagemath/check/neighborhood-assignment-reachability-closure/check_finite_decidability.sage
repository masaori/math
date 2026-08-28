# 対象ラベル: claim_reflexive_transitive_closure_finite_decidable
# 本文の有限構成と所属判定回数の上界を検査する。
# 帰属: 有限集合、有限写像表、ZZ だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

checked = 0
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    bound = ZZ((n * n + 1) * n ** 3)
    for assignment in neighborhood_assignments(cells):
        current = identity_assignment(cells)
        collected = current
        membership_tests = ZZ(0)
        for _ in range(n * n):
            following = []
            for v in cells:
                value = set()
                for u in current[v]:
                    for w in cells:
                        membership_tests += 1
                        if w in assignment[u]:
                            value.add(w)
                following.append(frozenset(value))
            current = tuple(following)
            collected = pointwise_union(collected, current)
        assert collected == closure(cells, assignment)
        assert membership_tests <= bound
        checked += 1

print("PASS check_finite_decidability")
print("  assignments checked:", checked)
