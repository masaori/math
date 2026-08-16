# SageMath: 偶辺部分集合の第一ホモロジー類写像の合成定義を厳密検算
# 対象ラベル: def_even_edge_subset_homology_class_map
# 式ペア: eta(A) = pi_1(chi(A)) = {chi(A) + b | b in Boundary_1}
# 帰属: 形式的有限集合と GF(2) 上の有限行列・有限商だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

even_edge_subsets = [
    chosen
    for chosen in subsets(edges)
    if is_even_edge_subset(chosen)
]

first_homology_group = {
    quotient_map(cycle)
    for cycle in first_cycle_space
}

homology_class_map = {
    chosen: quotient_map(edge_subset_coefficient_map(chosen))
    for chosen in even_edge_subsets
}

assert len(even_edge_subsets) == 4
assert len(first_cycle_space) == 4
assert len(face_boundary_space) == 2
assert len(first_homology_group) == 2

for chosen in even_edge_subsets:
    coefficients = edge_subset_coefficient_map(chosen)
    assert coefficients in first_cycle_space
    assert homology_class_map[chosen] == quotient_map(coefficients)
    assert homology_class_map[chosen] == frozenset(
        add_coefficients(coefficients, boundary)
        for boundary in face_boundary_space
    )
    assert homology_class_map[chosen] in first_homology_group

print("RESULT: PASS — the homology-class map is exactly the coefficient-map restriction followed by the quotient map")
