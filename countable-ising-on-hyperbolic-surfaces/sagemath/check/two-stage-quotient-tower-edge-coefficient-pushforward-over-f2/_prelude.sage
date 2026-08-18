# SageMath: 商の塔が誘導する F_2 辺係数押し出し写像の共通有限データ
# 対象ラベル: def_quotient_tower_edge_coefficient_pushforward_over_f2
# 帰属: 有限剰余類辺セル集合と F_2 上の係数写像だけを用いる。

import os
import itertools

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(
    _dir,
    "../two-stage-quotient-tower-coset-cell-maps/_prelude.sage",
))

F2 = GF(2)


def labeled_edge_cells(quotient, stabilizer, kernel, stage_label):
    return frozenset(
        (
            stage_label,
            "edge",
            quotient_left_coset(element, stabilizer, kernel, stage_label),
        )
        for element in quotient
    )


fine_edge_cells = labeled_edge_cells(
    fine_quotient,
    fine_stabilizers["edge"],
    fine_kernel,
    FINE,
)
coarse_edge_cells = labeled_edge_cells(
    coarse_quotient,
    coarse_stabilizers["edge"],
    coarse_kernel,
    COARSE,
)


def induced_labeled_edge_cell(fine_edge_cell):
    stage_label, role, edge_coset = fine_edge_cell
    assert stage_label == FINE
    assert role == "edge"
    return (COARSE, role, induced_cell_image(role, edge_coset))


def all_f2_coefficient_maps(index_set):
    ordered_indices = tuple(index_set)
    for coefficients in itertools.product(F2, repeat=len(ordered_indices)):
        yield dict(zip(ordered_indices, coefficients))


def edge_coefficient_pushforward(fine_coefficients):
    return {
        coarse_edge_cell: sum(
            (
                fine_coefficients[fine_edge_cell]
                for fine_edge_cell in fine_edge_cells
                if induced_labeled_edge_cell(fine_edge_cell) == coarse_edge_cell
            ),
            F2.zero(),
        )
        for coarse_edge_cell in coarse_edge_cells
    }
