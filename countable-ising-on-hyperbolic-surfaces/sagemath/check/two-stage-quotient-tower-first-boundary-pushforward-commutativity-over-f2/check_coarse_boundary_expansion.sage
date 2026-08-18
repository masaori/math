# SageMath: 粗段一次境界と辺係数押し出しの合成の定義展開を検算する
# 対象ラベル: theorem_quotient_tower_first_boundary_pushforward_commutativity_over_f2
# 式ペア: (partial_1_coarse(bar(kappa)_{E,!}(c)))(D_V)
#          = sum_{D_E} incidence_coarse(D_V,D_E) (bar(kappa)_{E,!}(c))(D_E)
# 帰属: 有限剰余類頂点・辺セル集合と F_2 上の有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for fine_coefficients in all_f2_coefficient_maps(fine_edge_cells):
    pushed_edge_coefficients = edge_coefficient_pushforward(fine_coefficients)
    left_side = coarse_first_boundary(pushed_edge_coefficients)
    for coarse_vertex_cell in coarse_vertex_cells:
        expanded_side = sum(
            (
                coarse_boundary_coefficient(coarse_vertex_cell, coarse_edge_cell)
                * pushed_edge_coefficients[coarse_edge_cell]
                for coarse_edge_cell in coarse_edge_cells
            ),
            F2.zero(),
        )
        assert left_side[coarse_vertex_cell] == expanded_side

print(
    "RESULT: PASS — the coarse first-boundary component equals its exact "
    "finite incidence expansion after edge-coefficient pushforward"
)
