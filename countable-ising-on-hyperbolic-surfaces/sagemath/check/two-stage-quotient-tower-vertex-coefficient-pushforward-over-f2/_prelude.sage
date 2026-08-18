# SageMath: 商の塔が誘導する F_2 頂点係数押し出し写像の共通有限データ
# 対象ラベル: def_quotient_tower_vertex_coefficient_pushforward_over_f2
# 帰属: 有限剰余類頂点セル集合と F_2 上の係数写像だけを用いる。

import os
import itertools

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(
    _dir,
    "../two-stage-quotient-tower-coset-cell-maps/_prelude.sage",
))

F2 = GF(2)


def labeled_vertex_cells(quotient, stabilizer, kernel, stage_label):
    return frozenset(
        (
            stage_label,
            "vertex",
            quotient_left_coset(element, stabilizer, kernel, stage_label),
        )
        for element in quotient
    )


fine_vertex_cells = labeled_vertex_cells(
    fine_quotient,
    fine_stabilizers["vertex"],
    fine_kernel,
    FINE,
)
coarse_vertex_cells = labeled_vertex_cells(
    coarse_quotient,
    coarse_stabilizers["vertex"],
    coarse_kernel,
    COARSE,
)


def induced_labeled_vertex_cell(fine_vertex_cell):
    stage_label, role, vertex_coset = fine_vertex_cell
    assert stage_label == FINE
    assert role == "vertex"
    return (COARSE, role, induced_cell_image(role, vertex_coset))


def all_f2_coefficient_maps(index_set):
    ordered_indices = tuple(index_set)
    for coefficients in itertools.product(F2, repeat=len(ordered_indices)):
        yield dict(zip(ordered_indices, coefficients))


def vertex_coefficient_pushforward(fine_coefficients):
    return {
        coarse_vertex_cell: sum(
            (
                fine_coefficients[fine_vertex_cell]
                for fine_vertex_cell in fine_vertex_cells
                if induced_labeled_vertex_cell(fine_vertex_cell) == coarse_vertex_cell
            ),
            F2.zero(),
        )
        for coarse_vertex_cell in coarse_vertex_cells
    }
