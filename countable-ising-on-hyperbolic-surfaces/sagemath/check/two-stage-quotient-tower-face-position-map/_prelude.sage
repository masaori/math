# SageMath: 商の塔が誘導する剰余類面の巡回位置写像の共通有限データ
# 対象ラベル: def_quotient_tower_induced_face_position_map
# 帰属: 有限置換群、有限商群、有限部分群、有限剰余類集合だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(
    _dir,
    "../two-stage-quotient-tower-coset-cell-maps/_prelude.sage",
))


def stage_cells(quotient, stabilizer, kernel, label):
    return frozenset(
        quotient_left_coset(element, stabilizer, kernel, label)
        for element in quotient
    )


fine_face_cells = stage_cells(
    fine_quotient,
    fine_stabilizers["face"],
    fine_kernel,
    FINE,
)
coarse_face_cells = stage_cells(
    coarse_quotient,
    coarse_stabilizers["face"],
    coarse_kernel,
    COARSE,
)


def face_positions(face_cell):
    return frozenset(("position", element) for element in face_cell)


def fine_successor(position):
    position_label, element = position
    return (
        position_label,
        quotient_product(element, fine_roles["face"], fine_kernel, FINE),
    )


def coarse_successor(position):
    position_label, element = position
    return (
        position_label,
        quotient_product(element, coarse_roles["face"], coarse_kernel, COARSE),
    )


def induced_position_image(position):
    position_label, element = position
    return (position_label, stage_map(element))
