# SageMath: F_2 上の一次サイクル空間の厳密検算
# 対象ラベル: def_first_cycle_space_over_f2
# 帰属: 形式的な有限ラベル集合と GF(2) 上の有限行列だけを用いる。

vertices = ("A", "B", "C")
edges = ("ab", "bc", "ca")

first_boundary = matrix(
    GF(2),
    [
        [1, 0, 1],
        [1, 1, 0],
        [0, 1, 1],
    ],
)

edge_coefficient_space = VectorSpace(GF(2), len(edges))
zero_vertex_coefficients = vector(GF(2), [0 for _vertex in vertices])

cycles_from_definition = {
    tuple(coefficient_vector)
    for coefficient_vector in edge_coefficient_space
    if first_boundary * coefficient_vector == zero_vertex_coefficients
}
cycles_from_kernel = {
    tuple(coefficient_vector)
    for coefficient_vector in first_boundary.right_kernel()
}

expected_cycles = {
    (GF(2).zero(), GF(2).zero(), GF(2).zero()),
    (GF(2).one(), GF(2).one(), GF(2).one()),
}

assert cycles_from_definition == cycles_from_kernel
assert cycles_from_definition == expected_cycles

print("RESULT: PASS — the triangle cycle space is exactly the kernel of its finite GF(2) first-boundary matrix")
