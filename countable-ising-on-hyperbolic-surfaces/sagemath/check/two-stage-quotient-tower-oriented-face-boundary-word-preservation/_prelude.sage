# SageMath: 商の塔における剰余類面の向き付き境界語保存の共通有限データ
# 対象ラベル: theorem_quotient_tower_oriented_face_boundary_word_preservation
# 帰属: 有限置換群、有限商群、有限部分群、有限剰余類集合、形式的向きラベルだけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(
    _dir,
    "../two-stage-quotient-tower-oriented-edge-representative-selectors/_prelude.sage",
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


def induced_position_image(position):
    position_label, element = position
    return (position_label, stage_map(element))


def edge_cell_at(element, stabilizer, kernel, label):
    return quotient_left_coset(element, stabilizer, kernel, label)


def fine_edge_cell_at(element):
    return edge_cell_at(
        element,
        fine_stabilizers["edge"],
        fine_kernel,
        FINE,
    )


def coarse_edge_cell_at(element):
    return edge_cell_at(
        element,
        coarse_stabilizers["edge"],
        coarse_kernel,
        COARSE,
    )


def boundary_entry(element, edge_cell, representative_selector, edge_role, kernel, label):
    selected = representative_selector(edge_cell)
    if selected == element:
        orientation = "reverse"
    else:
        assert selected == quotient_product(element, edge_role, kernel, label)
        orientation = "forward"
    return edge_cell, orientation


def fine_boundary_entry(position):
    position_label, element = position
    assert position_label == "position"
    edge_cell = fine_edge_cell_at(element)
    return boundary_entry(
        element,
        edge_cell,
        fine_representative_selector,
        fine_roles["edge"],
        fine_kernel,
        FINE,
    )


def coarse_boundary_entry(position):
    position_label, element = position
    assert position_label == "position"
    edge_cell = coarse_edge_cell_at(element)
    return boundary_entry(
        element,
        edge_cell,
        coarse_representative_selector,
        coarse_roles["edge"],
        coarse_kernel,
        COARSE,
    )


def induced_boundary_entry(entry):
    fine_edge_cell, orientation = entry
    return induced_cell_image("edge", fine_edge_cell), orientation
