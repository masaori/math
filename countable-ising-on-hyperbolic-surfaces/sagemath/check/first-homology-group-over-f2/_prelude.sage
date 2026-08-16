# SageMath: F_2 上の第一ホモロジー群の検算に用いる有限鎖複体
# 対象ラベル: def_first_homology_group_over_f2
# 帰属: 形式的な有限ラベル集合と GF(2) 上の有限行列だけを用いる。

vertices = ("A", "B")
edges = ("upper", "lower", "loop")
faces = ("lens",)

first_boundary = matrix(
    GF(2),
    [
        [1, 1, 0],
        [1, 1, 0],
    ],
)

second_boundary = matrix(
    GF(2),
    [
        [1],
        [1],
        [0],
    ],
)

edge_coefficient_space = VectorSpace(GF(2), len(edges))
face_coefficient_space = VectorSpace(GF(2), len(faces))
zero_vertex_coefficients = vector(GF(2), [0 for _vertex in vertices])

assert first_boundary * second_boundary == zero_matrix(GF(2), len(vertices), len(faces))

first_cycle_space = {
    tuple(edge_coefficients)
    for edge_coefficients in edge_coefficient_space
    if first_boundary * edge_coefficients == zero_vertex_coefficients
}

face_boundary_space = {
    tuple(second_boundary * face_coefficients)
    for face_coefficients in face_coefficient_space
}


def add_coefficients(left, right):
    return tuple(GF(2)(a + b) for a, b in zip(left, right))


def boundary_coset(cycle):
    return frozenset(
        add_coefficients(cycle, boundary)
        for boundary in face_boundary_space
    )
