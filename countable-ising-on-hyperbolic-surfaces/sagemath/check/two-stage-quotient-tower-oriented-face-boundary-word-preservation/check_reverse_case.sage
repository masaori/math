# SageMath: reverse 場合の代表元選択と向き保存の検算
# 対象ラベル: theorem_quotient_tower_oriented_face_boundary_word_preservation
# 式: eta_E^fine(C_E(a)) = a なら eta_E^coarse(D_E(kappa(a))) = kappa(a)
# 帰属: 有限商群、有限剰余類集合、形式的向きラベルだけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

checked_reverse_positions = 0
for fine_face_cell in fine_face_cells:
    for fine_position in face_positions(fine_face_cell):
        _, fine_element = fine_position
        fine_edge_cell, fine_orientation = fine_boundary_entry(fine_position)
        if fine_orientation != "reverse":
            continue
        coarse_element = stage_map(fine_element)
        coarse_edge_cell = induced_cell_image("edge", fine_edge_cell)
        assert fine_representative_selector(fine_edge_cell) == fine_element
        assert stage_map(fine_representative_selector(fine_edge_cell)) == coarse_element
        assert coarse_representative_selector(coarse_edge_cell) == coarse_element
        assert coarse_boundary_entry(induced_position_image(fine_position))[1] == "reverse"
        checked_reverse_positions += 1

assert checked_reverse_positions > 0
print(
    "RESULT: PASS — every fine reverse boundary entry maps to a coarse "
    "reverse boundary entry"
)
