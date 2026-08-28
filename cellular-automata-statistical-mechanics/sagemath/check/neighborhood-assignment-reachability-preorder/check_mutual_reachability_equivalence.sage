# 対象ラベル: claim_neighborhood_mutual_reachability_transitive
# 相互到達関係の反射性・対称性・推移性を別々に検査する。
# 帰属: 有限集合と有限関係だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

assignments_checked = 0
triples_checked = 0
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    for assignment in neighborhood_assignments(cells):
        result = closure(cells, assignment)
        for v in cells:
            assert mutually_reachable(result, v, v)
            for u in cells:
                if mutually_reachable(result, v, u):
                    assert mutually_reachable(result, u, v)
                for w in cells:
                    if mutually_reachable(result, v, u) and mutually_reachable(result, u, w):
                        assert reachable(result, v, w)
                        assert reachable(result, w, v)
                        assert mutually_reachable(result, v, w)
                    triples_checked += 1
        assignments_checked += 1

print("PASS check_mutual_reachability_equivalence")
print("  assignments checked:", assignments_checked)
print("  triples checked:", triples_checked)
