# 対象ラベル: claim_subsingleton_neighborhood_composition_distributes_over_intersection
# |V| <= 1 の全ての近傍割り当ての三つ組で左右の分配律を検査する。
# 本文の証明の各段を分けて検査する。
#   (N⊓M)*L = (N⊓M)⊓L = (N⊓L)⊓(M⊓L) = (N*L)⊓(M*L)
#   L*(N⊓M) = L⊓(N⊓M) = (L⊓N)⊓(L⊓M) = (L*N)⊓(L*M)
# 帰属: 有限集合と有限写像だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

triple_count = 0

for size in (0, 1):
    cells = tuple(range(size))
    assignments = neighborhood_assignments(cells)
    for N in assignments:
        for M in assignments:
            for L in assignments:
                triple_count += 1
                meet_NM = pointwise_intersection(cells, N, M)

                # 左からの分配律を段ごとに追う
                left_lhs = compose(cells, meet_NM, L)
                step1 = pointwise_intersection(cells, meet_NM, L)
                assert left_lhs == step1                       # 合成と点ごとの積の一致
                step2 = pointwise_intersection(
                    cells,
                    pointwise_intersection(cells, N, L),
                    pointwise_intersection(cells, M, L),
                )
                assert step1 == step2                          # 交換・結合・冪等律
                left_rhs = pointwise_intersection(
                    cells, compose(cells, N, L), compose(cells, M, L)
                )
                assert step2 == left_rhs                       # 合成と点ごとの積の一致
                assert left_lhs == left_rhs

                # 右からの分配律を段ごとに追う
                right_lhs = compose(cells, L, meet_NM)
                rstep1 = pointwise_intersection(cells, L, meet_NM)
                assert right_lhs == rstep1
                rstep2 = pointwise_intersection(
                    cells,
                    pointwise_intersection(cells, L, N),
                    pointwise_intersection(cells, L, M),
                )
                assert rstep1 == rstep2
                right_rhs = pointwise_intersection(
                    cells, compose(cells, L, N), compose(cells, L, M)
                )
                assert rstep2 == right_rhs
                assert right_lhs == right_rhs

print("PASS subsingleton_distributivity triples={}".format(triple_count))
