# SageMath: 主セルの F_2 上の一次コサイクル空間の厳密検算
# 対象ラベル: def_primal_first_cocycle_space_over_f2
# 対象: finite-fourier-duality.ts のブロック finite_fourier_definition_primal_first_cocycle_space
# 帰属: 有限集合と GF(2)。浮動小数点、実数、複素数を使用しない

field = GF(2)
primal_edges = ("a", "b", "c")
primal_faces = ("front", "back")

# 反対向きの三角形二面では、各面の境界に各主辺が一回ずつ現れる。
second_boundary = matrix(
    field,
    len(primal_edges),
    len(primal_faces),
    [
        [1, 1],
        [1, 1],
        [1, 1],
    ],
)

primal_edge_coefficient_space = VectorSpace(field, len(primal_edges))
transpose_kernel = second_boundary.transpose().right_kernel()


def satisfies_face_sum_condition(coefficients):
    return all(
        sum(
            second_boundary[edge_index, face_index] * coefficients[edge_index]
            for edge_index in range(len(primal_edges))
        )
        == field.zero()
        for face_index in range(len(primal_faces))
    )


condition_cocycles = {
    tuple(coefficients)
    for coefficients in primal_edge_coefficient_space
    if satisfies_face_sum_condition(coefficients)
}
kernel_cocycles = {
    tuple(coefficients)
    for coefficients in transpose_kernel
}
expected_even_weight_cocycles = {
    (field.zero(), field.zero(), field.zero()),
    (field.zero(), field.one(), field.one()),
    (field.one(), field.zero(), field.one()),
    (field.one(), field.one(), field.zero()),
}

assert condition_cocycles == kernel_cocycles
assert condition_cocycles == expected_even_weight_cocycles

print(
    "RESULT: PASS — all eight primal GF(2) edge-coefficient functions were "
    "enumerated, and the face-sum definition equals the transpose kernel "
    "with exactly the four even-weight cocycles"
)
