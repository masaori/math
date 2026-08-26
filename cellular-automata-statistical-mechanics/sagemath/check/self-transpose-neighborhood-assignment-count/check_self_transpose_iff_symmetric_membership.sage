# 対象ラベル: claim_self_transpose_iff_symmetric_membership
# N^T = N ⟺ (∀ v,w ∈ V, w ∈ N(v) ⟺ v ∈ N(w)) を全数検査する。
# 本文の証明の各段を分けて検査する。
#   順方向: N^T = N を仮定し、w ∈ N(v) ⟺ w ∈ N^T(v) ⟺ v ∈ N(w)
#   逆方向: 対称性を仮定し、w ∈ N^T(v) ⟺ v ∈ N(w) ⟺ w ∈ N(v)、
#           所属条件の同値と二回の外延性で N^T = N
# 帰属: 有限集合と有限写像表だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

assignment_count = 0
symmetric_count = 0
step_count = 0

for size in (0, 1, 2, 3, 4):
    cells = tuple(range(size))
    for N in neighborhood_assignments(cells):
        assignment_count += 1
        T = transpose(cells, N)
        symmetric = all((w in N[v]) == (v in N[w]) for v in cells for w in cells)

        if T == N:
            symmetric_count += 1
            for v in cells:
                for w in cells:
                    step_count += 1
                    # 第一段: N^T = N を所属へ適用
                    assert (w in N[v]) == (w in T[v])
                    # 第二段: 転置の所属同値
                    assert (w in T[v]) == (v in N[w])
                    # 両段の合成（順方向の結論）
                    assert (w in N[v]) == (v in N[w])
            assert symmetric

        if symmetric:
            for v in cells:
                for w in cells:
                    step_count += 1
                    # 第一段: 転置の所属同値
                    assert (w in T[v]) == (v in N[w])
                    # 第二段: 仮定した対称性
                    assert (v in N[w]) == (w in N[v])
                    # 両段の合成
                    assert (w in T[v]) == (w in N[v])
                # 第三段: w の任意性と集合の外延性
                assert T[v] == N[v]
            # 第四段: v の任意性と写像の外延性（逆方向の結論）
            assert T == N

print("PASS self_transpose_iff_symmetric_membership assignments={} self_transpose={} steps={}".format(
    assignment_count, symmetric_count, step_count
))
