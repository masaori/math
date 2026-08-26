# 対象ラベル: claim_neighborhood_assignment_transpose_membership
# 転置が近傍所属の向きを逆にすること v ∈ N^T(w) ⟺ w ∈ N(v) を全数検査する。
# 併せて、転置の値が V の部分集合であること（N^T が近傍割り当てであること）を検査する。
# 帰属: 有限集合と有限写像表だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

assignment_count = 0
membership_count = 0

for size in (0, 1, 2, 3):
    cells = tuple(range(size))
    for N in neighborhood_assignments(cells):
        assignment_count += 1
        T = transpose(cells, N)

        # 第一段: 転置の値は V の有限部分集合であり、N^T は近傍割り当てである
        for w in cells:
            assert T[w] <= frozenset(cells)
        assert len(T) == len(cells)

        # 第二段: 所属の向きが逆になる（定義の右辺そのもの）
        for v in cells:
            for w in cells:
                membership_count += 1
                assert (v in T[w]) == (w in N[v])

print("PASS transpose_membership assignments={} membership_checks={}".format(
    assignment_count, membership_count
))
