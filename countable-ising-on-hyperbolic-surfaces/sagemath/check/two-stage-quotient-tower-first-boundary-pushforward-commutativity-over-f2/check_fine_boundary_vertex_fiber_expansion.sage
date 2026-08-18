# SageMath: 細段一次境界と頂点係数押し出しの合成の定義展開を検算する
# 対象ラベル: theorem_quotient_tower_first_boundary_pushforward_commutativity_over_f2
# 式ペア: sum_{bar(kappa)_V(C_V)=D_V} sum_{C_E} incidence_fine(C_V,C_E)c(C_E)
#          = (bar(kappa)_{V,!}(partial_1_fine(c)))(D_V)
# 帰属: 有限剰余類頂点・辺セル集合と F_2 上の有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for fine_coefficients in all_f2_coefficient_maps(fine_edge_cells):
    fine_boundary = fine_first_boundary(fine_coefficients)
    pushed_boundary = vertex_coefficient_pushforward(fine_boundary)
    for coarse_vertex_cell in coarse_vertex_cells:
        expanded_side = sum(
            (
                sum(
                    (
                        fine_boundary_coefficient(fine_vertex_cell, fine_edge_cell)
                        * fine_coefficients[fine_edge_cell]
                        for fine_edge_cell in fine_edge_cells
                    ),
                    F2.zero(),
                )
                for fine_vertex_cell in fine_vertex_cells
                if induced_vertex_cell(fine_vertex_cell) == coarse_vertex_cell
            ),
            F2.zero(),
        )
        assert expanded_side == pushed_boundary[coarse_vertex_cell]

print(
    "RESULT: PASS — the pushed fine first-boundary component equals its "
    "exact finite expansion over the induced-vertex fiber"
)
