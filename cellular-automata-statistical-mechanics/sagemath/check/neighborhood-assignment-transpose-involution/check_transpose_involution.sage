# 対象ラベル: claim_neighborhood_assignment_transpose_involutive
# (N^T)^T = N を全数検査する。本文の証明の各段を分けて検査する。
#   w ∈ (N^T)^T(v) ⟺ v ∈ N^T(w)   （所属の向きの反転を N^T へ適用）
#                  ⟺ w ∈ N(v)      （所属の向きの反転を N へ適用）
#   w の任意性と集合の外延性、v の任意性と写像の外延性で等号を得る
# 帰属: 有限集合と有限写像表だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

assignment_count = 0
step_count = 0

for size in (0, 1, 2, 3):
    cells = tuple(range(size))
    for N in neighborhood_assignments(cells):
        assignment_count += 1
        T = transpose(cells, N)
        TT = transpose(cells, T)

        for v in cells:
            for w in cells:
                step_count += 1
                # 第一段: 所属の向きの反転を N^T へ適用
                assert (w in TT[v]) == (v in T[w])
                # 第二段: 所属の向きの反転を N へ適用
                assert (v in T[w]) == (w in N[v])
                # 両段の合成
                assert (w in TT[v]) == (w in N[v])

            # 第三段: w の任意性と集合の外延性
            assert TT[v] == N[v]

        # 第四段: v の任意性と写像の外延性
        assert TT == N

print("PASS transpose_involution assignments={} steps={}".format(
    assignment_count, step_count
))
