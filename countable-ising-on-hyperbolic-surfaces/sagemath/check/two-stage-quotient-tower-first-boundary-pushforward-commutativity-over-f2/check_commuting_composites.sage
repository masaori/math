# SageMath: F_2 一次境界写像と二つの係数押し出しの可換性を全係数写像で検算する
# 対象ラベル: theorem_quotient_tower_first_boundary_pushforward_commutativity_over_f2
# 式ペア: partial_1_coarse o bar(kappa)_{E,!}
#          = bar(kappa)_{V,!} o partial_1_fine
# 帰属: 有限剰余類頂点・辺セル集合と F_2 上の有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

checked_coefficient_maps = 0
checked_components = 0

for fine_coefficients in all_f2_coefficient_maps(fine_edge_cells):
    left_side = coarse_first_boundary(
        edge_coefficient_pushforward(fine_coefficients)
    )
    right_side = vertex_coefficient_pushforward(
        fine_first_boundary(fine_coefficients)
    )
    assert left_side == right_side
    checked_coefficient_maps += 1
    checked_components += len(coarse_vertex_cells)

assert checked_coefficient_maps == 2 ** len(fine_edge_cells)
assert checked_components == checked_coefficient_maps * len(coarse_vertex_cells)

print(
    "RESULT: PASS — coarse boundary after edge pushforward equals vertex "
    "pushforward after fine boundary for every fine F_2 edge coefficient map"
)
