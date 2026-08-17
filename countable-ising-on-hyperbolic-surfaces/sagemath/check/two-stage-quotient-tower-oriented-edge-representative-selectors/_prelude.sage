# SageMath: 商の塔における向き付き辺代表元選択の整合性の共通有限データ
# 対象ラベル: def_quotient_tower_oriented_edge_representative_selector_compatibility
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


fine_edge_cells = stage_cells(
    fine_quotient,
    fine_stabilizers["edge"],
    fine_kernel,
    FINE,
)
coarse_edge_cells = stage_cells(
    coarse_quotient,
    coarse_stabilizers["edge"],
    coarse_kernel,
    COARSE,
)


def permutation_key(permutation):
    return tuple(permutation(index) for index in range(1, 5))


def quotient_element_key(quotient_element):
    label, ambient_coset = quotient_element
    label_key = 0 if label == FINE else 1
    return (label_key, min(permutation_key(element) for element in ambient_coset))


def coarse_representative_selector(coarse_edge_cell):
    return min(coarse_edge_cell, key=quotient_element_key)


def fine_representative_selector(fine_edge_cell):
    coarse_edge_cell = induced_cell_image("edge", fine_edge_cell)
    selected_coarse_representative = coarse_representative_selector(coarse_edge_cell)
    compatible_candidates = tuple(
        fine_representative
        for fine_representative in fine_edge_cell
        if stage_map(fine_representative) == selected_coarse_representative
    )
    assert compatible_candidates
    return min(compatible_candidates, key=quotient_element_key)
