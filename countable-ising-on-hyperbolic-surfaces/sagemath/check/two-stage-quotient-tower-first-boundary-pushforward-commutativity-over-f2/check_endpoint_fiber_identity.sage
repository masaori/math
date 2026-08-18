# SageMath: 端点保存による粗段 incidence と細段頂点ファイバー和の一致を検算する
# 対象ラベル: theorem_quotient_tower_first_boundary_pushforward_commutativity_over_f2
# 式ペア: incidence_coarse(D_V,bar(kappa)_E(C_E))
#          = sum_{bar(kappa)_V(C_V)=D_V} incidence_fine(C_V,C_E)
# 帰属: 有限剰余類頂点・辺セル集合、形式的辺端ラベル、F_2 上の有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for fine_edge_cell in fine_edge_cells:
    for coarse_vertex_cell in coarse_vertex_cells:
        left_side = coarse_boundary_coefficient(
            coarse_vertex_cell,
            induced_edge_cell(fine_edge_cell),
        )
        right_side = sum(
            (
                fine_boundary_coefficient(fine_vertex_cell, fine_edge_cell)
                for fine_vertex_cell in fine_vertex_cells
                if induced_vertex_cell(fine_vertex_cell) == coarse_vertex_cell
            ),
            F2.zero(),
        )
        assert left_side == right_side

print(
    "RESULT: PASS — endpoint preservation makes every induced coarse-edge "
    "incidence equal the exact sum over its fine-vertex fiber"
)
