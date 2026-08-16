# SageMath: 主一次余境界の係数移送が双対面境界空間になることの厳密検算
# 対象ラベル: theorem_primal_coboundary_transport_is_dual_boundary
# 対象: finite-fourier-duality.ts のブロック finite_fourier_theorem_primal_coboundary_transport_is_dual_boundary
# 帰属: 有限集合と GF(2)。浮動小数点、実数、複素数を使用しない

field = GF(2)


def permutation_matrix_from_map(image_indices):
    size = len(image_indices)
    result = matrix(field, size, size)
    for source_index, target_index in enumerate(image_indices):
        result[target_index, source_index] = 1
    return result


def vector_space_elements(space):
    return {tuple(vector(field, element)) for element in space}


def verify_coboundary_transport(first_boundary, edge_image_indices, vertex_image_indices):
    edge_transport = permutation_matrix_from_map(edge_image_indices)
    vertex_to_dual_face_transport = permutation_matrix_from_map(vertex_image_indices)

    primal_coboundaries = first_boundary.transpose().column_space()
    dual_second_boundary = (
        edge_transport
        * first_boundary.transpose()
        * vertex_to_dual_face_transport.transpose()
    )
    dual_boundaries = dual_second_boundary.column_space()

    transported_primal_coboundaries = {
        tuple(edge_transport * vector(field, coboundary))
        for coboundary in primal_coboundaries
    }

    assert all(
        dual_second_boundary[edge_image_indices[edge], vertex_image_indices[vertex]]
        == first_boundary[vertex, edge]
        for vertex in range(first_boundary.nrows())
        for edge in range(first_boundary.ncols())
    )
    assert transported_primal_coboundaries == vector_space_elements(dual_boundaries)

    for primal_vertex_coefficients in VectorSpace(field, first_boundary.nrows()):
        primal_coboundary = first_boundary.transpose() * primal_vertex_coefficients
        dual_face_coefficients = (
            vertex_to_dual_face_transport * primal_vertex_coefficients
        )
        assert (
            edge_transport * primal_coboundary
            == dual_second_boundary * dual_face_coefficients
        )

    for dual_face_coefficients in VectorSpace(field, first_boundary.nrows()):
        primal_vertex_coefficients = (
            vertex_to_dual_face_transport.transpose() * dual_face_coefficients
        )
        assert (
            dual_second_boundary * dual_face_coefficients
            == edge_transport
            * first_boundary.transpose()
            * primal_vertex_coefficients
        )


# 三角形の一次境界行列。辺と頂点から双対辺と双対面への対応は非自明な置換にする。
verify_coboundary_transport(
    matrix(
        field,
        [
            [1, 0, 1],
            [1, 1, 0],
            [0, 1, 1],
        ],
    ),
    [2, 0, 1],
    [1, 2, 0],
)

# 一頂点に二本のループ辺をもつ例では、一次境界と二つの余境界空間が零になる。
verify_coboundary_transport(matrix(field, [[0, 0]]), [1, 0], [0])

print(
    "RESULT: PASS — transported primal first coboundaries equal dual face "
    "boundaries in both the triangle and loop examples"
)
