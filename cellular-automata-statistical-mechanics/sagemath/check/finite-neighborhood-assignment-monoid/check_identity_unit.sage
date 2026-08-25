# 対象ラベル: claim_identity_neighborhood_assignment_is_composition_identity
# 自己近傍割り当て I_V が合成近傍 * の両側単位元であること、すなわち
# I_V * N = N かつ N * I_V = N を、|V| <= 3 の全ての近傍割り当てで検査する。
# 証明の各段（一元集合を添字とする合併、一元集合の合併）も分けて検査する。
# 帰属: 有限集合と有限写像だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

tested_assignments = 0
tested_cells = 0
for cell_count in range(1, 4):
    cells = tuple(range(cell_count))
    identity = identity_assignment(cells)
    for assignment in neighborhood_assignments(cells):
        left = compose(cells, identity, assignment)
        right = compose(cells, assignment, identity)
        for v in cells:
            # 一元集合 I_V(v) = {v} を添字とする合併は N(v)
            assert identity[v] == frozenset({v})
            assert left[v] == assignment[v]
            # 一元集合 I_V(u) = {u} を u in N(v) で合併すると N(v)
            singleton_union = frozenset()
            for u in assignment[v]:
                singleton_union |= frozenset({u})
            assert right[v] == singleton_union
            assert right[v] == assignment[v]
            tested_cells += 1
        assert left == assignment
        assert right == assignment
        tested_assignments += 1

print(f"PASS assignments={tested_assignments} cells={tested_cells}")
