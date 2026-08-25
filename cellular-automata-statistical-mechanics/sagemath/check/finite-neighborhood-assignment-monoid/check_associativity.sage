# 対象ラベル: claim_composed_neighborhood_associative
# 合成近傍が結合的であること (N*M)*L = N*(M*L) を、|V| <= 2 の全ての三つ組で全数検査する。
# 併せて証明中の同値（w in ((N*M)*L)(v) <=> ∃r in N(v), ∃u in M(r), w in L(u)）を
# 両辺で別々に構成して照合する。
# 帰属: 有限集合と有限写像だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

tested_triples = 0
tested_membership = 0
for cell_count in range(1, 3):
    cells = tuple(range(cell_count))
    assignments = neighborhood_assignments(cells)
    for outer in assignments:
        for middle in assignments:
            for last in assignments:
                left = compose(cells, compose(cells, outer, middle), last)
                right = compose(cells, outer, compose(cells, middle, last))
                for v in cells:
                    # 二重の存在量化として直接構成した集合
                    witnessed = frozenset(
                        w for w in cells
                        if any(w in last[u] for r in outer[v] for u in middle[r])
                    )
                    assert left[v] == witnessed
                    assert right[v] == witnessed
                    tested_membership += len(cells)
                assert left == right
                tested_triples += 1

print(f"PASS triples={tested_triples} membership_checks={tested_membership}")
