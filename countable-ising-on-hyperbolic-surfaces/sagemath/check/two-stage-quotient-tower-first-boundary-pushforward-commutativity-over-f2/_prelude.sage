# SageMath: 商の塔における F_2 一次境界写像と押し出しの可換性の共通有限データ
# 対象ラベル: theorem_quotient_tower_first_boundary_pushforward_commutativity_over_f2
# 帰属: 有限剰余類頂点・辺セル集合、形式的辺端ラベル、F_2 上の有限和だけを用いる。

import os
import itertools

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(
    _dir,
    "../two-stage-quotient-tower-oriented-edge-endpoint-preservation/_prelude.sage",
))

F2 = GF(2)
ENDPOINT_LABELS = ("source", "target")

fine_vertex_cells = stage_cells(
    fine_quotient,
    fine_stabilizers["vertex"],
    fine_kernel,
    FINE,
)
coarse_vertex_cells = stage_cells(
    coarse_quotient,
    coarse_stabilizers["vertex"],
    coarse_kernel,
    COARSE,
)


def induced_edge_cell(fine_edge_cell):
    return induced_cell_image("edge", fine_edge_cell)


def induced_vertex_cell(fine_vertex_cell):
    return induced_cell_image("vertex", fine_vertex_cell)


def all_f2_coefficient_maps(index_set):
    ordered_indices = tuple(index_set)
    for coefficients in itertools.product(F2, repeat=len(ordered_indices)):
        yield dict(zip(ordered_indices, coefficients))


def boundary_coefficient(vertex_cell, edge_cell, endpoint_cell_function):
    return sum(
        (
            F2.one()
            for endpoint_label in ENDPOINT_LABELS
            if endpoint_cell_function(edge_cell, endpoint_label) == vertex_cell
        ),
        F2.zero(),
    )


def fine_boundary_coefficient(fine_vertex_cell, fine_edge_cell):
    return boundary_coefficient(
        fine_vertex_cell,
        fine_edge_cell,
        fine_endpoint_cell,
    )


def coarse_boundary_coefficient(coarse_vertex_cell, coarse_edge_cell):
    return boundary_coefficient(
        coarse_vertex_cell,
        coarse_edge_cell,
        coarse_endpoint_cell,
    )


def first_boundary(coefficients, vertex_cells, edge_cells, coefficient_function):
    return {
        vertex_cell: sum(
            (
                coefficient_function(vertex_cell, edge_cell)
                * coefficients[edge_cell]
                for edge_cell in edge_cells
            ),
            F2.zero(),
        )
        for vertex_cell in vertex_cells
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


def vertex_coefficient_pushforward(fine_coefficients):
    return {
        coarse_vertex_cell: sum(
            (
                fine_coefficients[fine_vertex_cell]
                for fine_vertex_cell in fine_vertex_cells
                if induced_vertex_cell(fine_vertex_cell) == coarse_vertex_cell
            ),
            F2.zero(),
        )
        for coarse_vertex_cell in coarse_vertex_cells
    }


def fine_first_boundary(fine_edge_coefficients):
    return first_boundary(
        fine_edge_coefficients,
        fine_vertex_cells,
        fine_edge_cells,
        fine_boundary_coefficient,
    )


def coarse_first_boundary(coarse_edge_coefficients):
    return first_boundary(
        coarse_edge_coefficients,
        coarse_vertex_cells,
        coarse_edge_cells,
        coarse_boundary_coefficient,
    )
