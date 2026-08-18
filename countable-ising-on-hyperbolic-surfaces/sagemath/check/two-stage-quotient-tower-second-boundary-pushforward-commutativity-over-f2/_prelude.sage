# SageMath: 商の塔における F_2 二次境界写像と押し出しの可換性の共通有限データ
# 対象ラベル: theorem_quotient_tower_second_boundary_pushforward_commutativity_over_f2
# 帰属: 有限剰余類面・辺セル集合、有限境界位置集合、F_2 上の有限和だけを用いる。

import os
import itertools

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(
    _dir,
    "../two-stage-quotient-tower-oriented-face-boundary-word-preservation/_prelude.sage",
))

F2 = GF(2)


def induced_face_cell(fine_face_cell):
    return induced_cell_image("face", fine_face_cell)


def induced_edge_cell(fine_edge_cell):
    return induced_cell_image("edge", fine_edge_cell)


def fine_boundary_edge(fine_position):
    return fine_boundary_entry(fine_position)[0]


def coarse_boundary_edge(coarse_position):
    return coarse_boundary_entry(coarse_position)[0]


def all_f2_coefficient_maps(index_set):
    ordered_indices = tuple(index_set)
    for coefficients in itertools.product(F2, repeat=len(ordered_indices)):
        yield dict(zip(ordered_indices, coefficients))


def second_boundary(
    coefficients,
    face_cells,
    edge_cells,
    boundary_edge_function,
):
    return {
        edge_cell: sum(
            (
                coefficients[face_cell]
                * sum(
                    (
                        F2.one()
                        for position in face_positions(face_cell)
                        if boundary_edge_function(position) == edge_cell
                    ),
                    F2.zero(),
                )
                for face_cell in face_cells
            ),
            F2.zero(),
        )
        for edge_cell in edge_cells
    }


def fine_second_boundary(fine_face_coefficients):
    return second_boundary(
        fine_face_coefficients,
        fine_face_cells,
        fine_edge_cells,
        fine_boundary_edge,
    )


def coarse_second_boundary(coarse_face_coefficients):
    return second_boundary(
        coarse_face_coefficients,
        coarse_face_cells,
        coarse_edge_cells,
        coarse_boundary_edge,
    )


def face_coefficient_pushforward(fine_coefficients):
    return {
        coarse_face_cell: sum(
            (
                fine_coefficients[fine_face_cell]
                for fine_face_cell in fine_face_cells
                if induced_face_cell(fine_face_cell) == coarse_face_cell
            ),
            F2.zero(),
        )
        for coarse_face_cell in coarse_face_cells
    }


def edge_coefficient_pushforward(fine_coefficients):
    return {
        coarse_edge_cell: sum(
            (
                fine_coefficients[fine_edge_cell]
                for fine_edge_cell in fine_edge_cells
                if induced_edge_cell(fine_edge_cell) == coarse_edge_cell
            ),
            F2.zero(),
        )
        for coarse_edge_cell in coarse_edge_cells
    }


def position_fiber(fine_face_cell, coarse_position):
    return tuple(
        fine_position
        for fine_position in face_positions(fine_face_cell)
        if induced_position_image(fine_position) == coarse_position
    )

