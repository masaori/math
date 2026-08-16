# SageMath: F_2 上の面境界空間の検算に用いる有限セル複体
# 対象ラベル: def_face_boundary_space_over_f2
# 帰属: 形式的な有限ラベル集合と GF(2) 上の有限行列だけを用いる。

vertices = ("A", "B", "C")
edges = ("ab", "bc", "ca")
faces = ("front", "back")

first_boundary = matrix(
    GF(2),
    [
        [1, 0, 1],
        [1, 1, 0],
        [0, 1, 1],
    ],
)

second_boundary = matrix(
    GF(2),
    [
        [1, 1],
        [1, 1],
        [1, 1],
    ],
)

face_coefficient_space = VectorSpace(GF(2), len(faces))
edge_coefficient_space = VectorSpace(GF(2), len(edges))
zero_vertex_coefficients = vector(GF(2), [0 for _vertex in vertices])
