# SageMath: 商の塔が誘導する F_2 面係数押し出し写像の共通有限データ
# 対象ラベル: def_quotient_tower_face_coefficient_pushforward_over_f2
# 帰属: 有限剰余類面セル集合と F_2 上の係数写像だけを用いる。

import os
import itertools

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(
    _dir,
    "../two-stage-quotient-tower-coset-cell-maps/_prelude.sage",
))

F2 = GF(2)


def labeled_face_cells(quotient, stabilizer, kernel, stage_label):
    return frozenset(
        (
            stage_label,
            "face",
            quotient_left_coset(element, stabilizer, kernel, stage_label),
        )
        for element in quotient
    )


fine_face_cells = labeled_face_cells(
    fine_quotient,
    fine_stabilizers["face"],
    fine_kernel,
    FINE,
)
coarse_face_cells = labeled_face_cells(
    coarse_quotient,
    coarse_stabilizers["face"],
    coarse_kernel,
    COARSE,
)


def induced_labeled_face_cell(fine_face_cell):
    stage_label, role, face_coset = fine_face_cell
    assert stage_label == FINE
    assert role == "face"
    return (COARSE, role, induced_cell_image(role, face_coset))


def all_f2_coefficient_maps(index_set):
    ordered_indices = tuple(index_set)
    for coefficients in itertools.product(F2, repeat=len(ordered_indices)):
        yield dict(zip(ordered_indices, coefficients))


def face_coefficient_pushforward(fine_coefficients):
    return {
        coarse_face_cell: sum(
            (
                fine_coefficients[fine_face_cell]
                for fine_face_cell in fine_face_cells
                if induced_labeled_face_cell(fine_face_cell) == coarse_face_cell
            ),
            F2.zero(),
        )
        for coarse_face_cell in coarse_face_cells
    }
