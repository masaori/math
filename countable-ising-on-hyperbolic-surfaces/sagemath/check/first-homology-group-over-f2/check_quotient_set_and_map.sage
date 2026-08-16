# SageMath: 商集合による第一ホモロジー群と明示した商写像の厳密検算
# 対象ラベル: def_first_homology_group_over_f2
# 式ペア: H_1 = {c + Boundary_1 | c in Cycle_1}, pi_1(c) = c + Boundary_1
# 帰属: 形式的な有限ラベル集合と GF(2) 上の有限行列だけを用いる。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

first_homology_group = {
    boundary_coset(cycle)
    for cycle in first_cycle_space
}

quotient_map = {
    cycle: boundary_coset(cycle)
    for cycle in first_cycle_space
}

assert len(first_cycle_space) == 4
assert len(face_boundary_space) == 2
assert len(first_homology_group) == 2
assert set(quotient_map.values()) == first_homology_group

for cycle in first_cycle_space:
    assert quotient_map[cycle] == frozenset(
        add_coefficients(cycle, boundary)
        for boundary in face_boundary_space
    )

for left in first_cycle_space:
    for right in first_cycle_space:
        same_coset = quotient_map[left] == quotient_map[right]
        difference_is_boundary = add_coefficients(left, right) in face_boundary_space
        assert same_coset == difference_is_boundary

print("RESULT: PASS — the finite GF(2) quotient set and its explicit quotient map agree with boundary cosets")
