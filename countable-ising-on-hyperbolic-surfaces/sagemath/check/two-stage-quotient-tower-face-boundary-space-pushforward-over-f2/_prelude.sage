# SageMath: 商の塔における面境界空間の押し出しの共通有限データ
# 対象ラベル: theorem_quotient_tower_face_boundary_space_pushforward_over_f2
# 帰属: 有限剰余類面・辺セル集合と F_2 上の有限像だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(
    _dir,
    "../two-stage-quotient-tower-second-boundary-pushforward-commutativity-over-f2/_prelude.sage",
))


def coefficient_tuple(coefficients, ordered_cells):
    return tuple(coefficients[cell] for cell in ordered_cells)


fine_face_boundaries = tuple({
    coefficient_tuple(
        fine_second_boundary(fine_face_coefficients),
        fine_edge_cells,
    )
    for fine_face_coefficients in all_f2_coefficient_maps(fine_face_cells)
})

coarse_face_boundaries = tuple({
    coefficient_tuple(
        coarse_second_boundary(coarse_face_coefficients),
        coarse_edge_cells,
    )
    for coarse_face_coefficients in all_f2_coefficient_maps(coarse_face_cells)
})


def tuple_to_coefficient_map(coefficient_values, ordered_cells):
    return dict(zip(ordered_cells, coefficient_values))
