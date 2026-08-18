# SageMath: F_2 二次境界写像と面・辺係数押し出しの可換性を全係数写像で検算する
# 対象ラベル: theorem_quotient_tower_second_boundary_pushforward_commutativity_over_f2
# 式ペア: partial_2_coarse o bar(kappa)_{F,!}
#          = bar(kappa)_{E,!} o partial_2_fine
# 帰属: 有限剰余類面・辺セル集合と F_2 上の有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

checked_coefficient_maps = 0
checked_components = 0
for fine_coefficients in all_f2_coefficient_maps(fine_face_cells):
    left_side = coarse_second_boundary(
        face_coefficient_pushforward(fine_coefficients)
    )
    right_side = edge_coefficient_pushforward(
        fine_second_boundary(fine_coefficients)
    )
    assert left_side == right_side
    checked_coefficient_maps += 1
    checked_components += len(coarse_edge_cells)

assert checked_coefficient_maps == 2 ** len(fine_face_cells)
assert checked_components == checked_coefficient_maps * len(coarse_edge_cells)
print(
    "RESULT: PASS — coarse second boundary after face pushforward equals "
    "edge pushforward after fine second boundary for every fine F_2 face coefficient map"
)

