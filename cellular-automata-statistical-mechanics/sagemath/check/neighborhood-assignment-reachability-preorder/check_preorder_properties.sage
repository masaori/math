# 対象ラベル: claim_neighborhood_reachability_preorder_transitive
# 到達関係の反射性と推移性を、閉包の各性質から段ごとに検査する。
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
            assert v in result[v]
            assert reachable(result, v, v)
            for u in cells:
                for w in cells:
                    if reachable(result, v, u) and reachable(result, u, w):
                        assert w in result[v]
                        assert reachable(result, v, w)
                    triples_checked += 1
        assignments_checked += 1

print("PASS check_preorder_properties")
print("  assignments checked:", assignments_checked)
print("  triples checked:", triples_checked)
