# SageMath: 細段と粗段の代表元選択写像の各値が対応する辺剰余類に属することを検証する
# 対象ラベル: def_quotient_tower_oriented_edge_representative_selector_compatibility
# 帰属: 有限置換群、有限商群、有限部分群、有限剰余類集合だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for coarse_edge_cell in coarse_edge_cells:
    assert coarse_representative_selector(coarse_edge_cell) in coarse_edge_cell

for fine_edge_cell in fine_edge_cells:
    assert fine_representative_selector(fine_edge_cell) in fine_edge_cell

print(
    "RESULT: PASS — the fine-stage and coarse-stage selectors choose an "
    "element of every edge coset in their respective finite quotient groups"
)
