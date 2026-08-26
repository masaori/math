# 対象ラベル: claim_neighborhood_assignment_transpose_preserves_lattice_operations
# (N⊔M)^T = N^T ⊔ M^T、(N⊓M)^T = N^T ⊓ M^T、I_V^T = I_V を全数検査する。
# 本文の証明の各段を分けて検査する。
#   w ∈ (N⊔M)^T(v) ⟺ v ∈ N(w) ∪ M(w) ⟺ w ∈ N^T(v) ∪ M^T(v)
#   w ∈ (N⊓M)^T(v) ⟺ v ∈ N(w) ∩ M(w) ⟺ w ∈ N^T(v) ∩ M^T(v)
#   w ∈ I_V^T(v)   ⟺ v ∈ {w} ⟺ w ∈ {v} ⟺ w ∈ I_V(v)
# 帰属: 有限集合と有限写像表だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

pair_count = 0
step_count = 0
identity_size_count = 0

for size in (0, 1, 2, 3):
    cells = tuple(range(size))
    assignments = neighborhood_assignments(cells)

    # 単位元の保存: I_V^T = I_V
    identity = identity_assignment(cells)
    transposed_identity = transpose(cells, identity)
    for v in cells:
        for w in cells:
            # 第一段: 所属の向きの反転と自己近傍割り当ての定義
            assert (w in transposed_identity[v]) == (v in frozenset((w,)))
            # 第二段: 等号の対称性
            assert (v in frozenset((w,))) == (w in frozenset((v,)))
            # 第三段: 自己近傍割り当ての定義
            assert (w in frozenset((v,))) == (w in identity[v])
        assert transposed_identity[v] == identity[v]
    assert transposed_identity == identity
    identity_size_count += 1

    for N in assignments:
        TN = transpose(cells, N)
        for M in assignments:
            pair_count += 1
            TM = transpose(cells, M)

            join = pointwise_union(cells, N, M)
            meet = pointwise_intersection(cells, N, M)
            transposed_join = transpose(cells, join)
            transposed_meet = transpose(cells, meet)
            join_of_transposes = pointwise_union(cells, TN, TM)
            meet_of_transposes = pointwise_intersection(cells, TN, TM)

            for v in cells:
                for w in cells:
                    step_count += 1
                    # 和: 第一段（所属の向きの反転と点ごとの和の定義）
                    assert (w in transposed_join[v]) == (v in (N[w] | M[w]))
                    # 和: 第二段（合併への所属と所属の向きの反転）
                    assert (v in (N[w] | M[w])) == (w in (TN[v] | TM[v]))
                    assert (w in (TN[v] | TM[v])) == (w in join_of_transposes[v])
                    # 積: 第一段（所属の向きの反転と点ごとの積の定義）
                    assert (w in transposed_meet[v]) == (v in (N[w] & M[w]))
                    # 積: 第二段（共通部分への所属と所属の向きの反転）
                    assert (v in (N[w] & M[w])) == (w in (TN[v] & TM[v]))
                    assert (w in (TN[v] & TM[v])) == (w in meet_of_transposes[v])

                # 集合の外延性
                assert transposed_join[v] == join_of_transposes[v]
                assert transposed_meet[v] == meet_of_transposes[v]

            # 写像の外延性
            assert transposed_join == join_of_transposes
            assert transposed_meet == meet_of_transposes

print("PASS transpose_preserves_lattice_operations pairs={} steps={} identity_stages={}".format(
    pair_count, step_count, identity_size_count
))
