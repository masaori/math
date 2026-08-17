# SageMath: 主第一コホモロジーと双対第一ホモロジーの剰余集合の厳密検算
# 対象ラベル: def_primal_cohomology_to_dual_homology_transport
# 式ペア: H^1 = Cocycle^1 / Coboundary^1, H_1(C*) = Cycle_1(C*) / Boundary_1(C*)
# 帰属: 形式的な有限ラベル集合と GF(2) 上の有限行列だけを用いる。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

assert primal_coboundary_space.is_subspace(primal_cocycle_space)
assert dual_boundary_space.is_subspace(dual_cycle_space)
assert primal_cocycle_space.cardinality() == 4
assert primal_coboundary_space.cardinality() == 2
assert len(primal_cohomology) == 2
assert dual_cycle_space.cardinality() == 4
assert dual_boundary_space.cardinality() == 2
assert len(dual_homology) == 2

assert set().union(*primal_cohomology) == {
    coefficient_tuple(cocycle)
    for cocycle in primal_cocycle_space
}
assert set().union(*dual_homology) == {
    coefficient_tuple(cycle)
    for cycle in dual_cycle_space
}
assert all(
    left == right or left.isdisjoint(right)
    for left in primal_cohomology
    for right in primal_cohomology
)
assert all(
    left == right or left.isdisjoint(right)
    for left in dual_homology
    for right in dual_homology
)

print(
    "RESULT: PASS — the primal cocycle and dual cycle spaces each split "
    "into two disjoint boundary cosets"
)
