# SageMath: 主第一コホモロジーから双対第一ホモロジーへの誘導写像の有限例
# 対象ラベル: def_primal_cohomology_to_dual_homology_transport
# 帰属: 形式的な有限ラベル集合と GF(2) 上の有限行列だけを用いる。

field = GF(2)

first_boundary = matrix(
    field,
    [
        [1, 1, 0],
        [1, 1, 0],
    ],
)

second_boundary = matrix(
    field,
    [
        [1],
        [1],
        [0],
    ],
)

edge_transport = matrix(
    field,
    [
        [0, 1, 0],
        [0, 0, 1],
        [1, 0, 0],
    ],
)

primal_cocycle_space = second_boundary.transpose().right_kernel()
primal_coboundary_space = first_boundary.transpose().column_space()
dual_edge_coefficient_space = VectorSpace(field, edge_transport.nrows())
dual_cycle_space = (
    primal_cocycle_space.basis_matrix() * edge_transport.transpose()
).row_space()
dual_boundary_space = (
    primal_coboundary_space.basis_matrix() * edge_transport.transpose()
).row_space()


def coefficient_tuple(coefficients):
    return tuple(vector(field, coefficients))


def coefficient_sum(left, right):
    result = []
    for left_coefficient, right_coefficient in zip(left, right):
        result.append(field(left_coefficient + right_coefficient))
    return tuple(result)


def coset(representative, subspace):
    result = set()
    for element in subspace:
        result.add(coefficient_sum(representative, element))
    return frozenset(result)


primal_cohomology = set()
for cocycle in primal_cocycle_space:
    primal_cohomology.add(coset(cocycle, primal_coboundary_space))

dual_homology = set()
for cycle in dual_cycle_space:
    dual_homology.add(coset(cycle, dual_boundary_space))
