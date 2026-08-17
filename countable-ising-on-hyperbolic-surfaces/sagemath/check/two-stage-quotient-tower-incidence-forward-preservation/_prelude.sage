# SageMath: 商の塔における剰余類セル incidence の順方向保存の共通有限データ
# 対象ラベル: theorem_quotient_tower_coset_cell_incidence_forward_preservation
# 帰属: 有限置換群、有限商群、有限部分群、有限剰余類集合だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(
    _dir,
    "../two-stage-quotient-tower-coset-cell-maps/_prelude.sage",
))

role_pairs = (
    ("face", "vertex"),
    ("face", "edge"),
    ("vertex", "edge"),
)


def stage_cells(role, quotient, stabilizer, kernel, label):
    return frozenset(
        quotient_left_coset(element, stabilizer, kernel, label)
        for element in quotient
    )


fine_cells = {
    role: stage_cells(
        role,
        fine_quotient,
        fine_stabilizers[role],
        fine_kernel,
        FINE,
    )
    for role in source_roles
}
coarse_cells = {
    role: stage_cells(
        role,
        coarse_quotient,
        coarse_stabilizers[role],
        coarse_kernel,
        COARSE,
    )
    for role in source_roles
}


def incident(left_cell, right_cell):
    return not left_cell.isdisjoint(right_cell)


fine_incident_pairs = frozenset(
    (left_role, right_role, left_cell, right_cell)
    for left_role, right_role in role_pairs
    for left_cell in fine_cells[left_role]
    for right_cell in fine_cells[right_role]
    if incident(left_cell, right_cell)
)


def image_cell(role, cell):
    return induced_cell_image(role, cell)
