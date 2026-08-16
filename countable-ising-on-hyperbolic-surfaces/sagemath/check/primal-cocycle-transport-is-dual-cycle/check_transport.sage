# SageMath: 主一次コサイクルの係数移送が双対一次サイクルになることの厳密検算
# 対象ラベル: theorem_primal_cocycle_transport_is_dual_cycle
# 対象: finite-fourier-duality.ts のブロック finite_fourier_theorem_primal_cocycle_transport_is_dual_cycle
# 帰属: 有限集合と GF(2)。浮動小数点、実数、複素数を使用しない

field = GF(2)


def verify_example(primal_edges, primal_faces, occurrences):
    dual_vertices = tuple(("dual_vertex", face) for face in primal_faces)
    dual_edges = tuple(("dual_edge", edge) for edge in primal_edges)

    edge_index = {edge: index for index, edge in enumerate(primal_edges)}
    face_index = {face: index for index, face in enumerate(primal_faces)}
    dual_vertex_index = {
        vertex: index for index, vertex in enumerate(dual_vertices)
    }
    dual_edge_index = {
        edge: index for index, edge in enumerate(dual_edges)
    }

    second_boundary = matrix(
        field,
        len(primal_edges),
        len(primal_faces),
    )
    dual_first_boundary = matrix(
        field,
        len(dual_vertices),
        len(dual_edges),
    )

    for edge in primal_edges:
        edge_occurrences = occurrences[edge]
        assert {orientation for orientation, face in edge_occurrences} == {
            "forward",
            "reverse",
        }

        for orientation, face in edge_occurrences:
            second_boundary[edge_index[edge], face_index[face]] += field.one()
            dual_first_boundary[
                dual_vertex_index[("dual_vertex", face)],
                dual_edge_index[("dual_edge", edge)],
            ] += field.one()

    # 各 (主辺, 主面) 成分について、双対 incidence と主二次境界の転置が一致する。
    for edge in primal_edges:
        for face in primal_faces:
            assert dual_first_boundary[
                dual_vertex_index[("dual_vertex", face)],
                dual_edge_index[("dual_edge", edge)],
            ] == second_boundary[edge_index[edge], face_index[face]]

    assert dual_first_boundary == second_boundary.transpose()

    primal_coefficient_space = VectorSpace(field, len(primal_edges))
    primal_cocycles = second_boundary.transpose().right_kernel()
    dual_cycles = dual_first_boundary.right_kernel()

    for primal_coefficients in primal_coefficient_space:
        transported_coefficients = vector(field, primal_coefficients)

        # 本文の式変形を一行ずつ照合する。
        dual_boundary_by_definition = dual_first_boundary * transported_coefficients
        dual_boundary_after_reindexing = matrix(
            field,
            second_boundary.ncols(),
            second_boundary.nrows(),
            [
                dual_first_boundary[face, edge]
                for face in range(second_boundary.ncols())
                for edge in range(second_boundary.nrows())
            ],
        ) * primal_coefficients
        dual_boundary_after_transport = dual_first_boundary * primal_coefficients
        dual_boundary_from_primal_faces = second_boundary.transpose() * primal_coefficients

        assert dual_boundary_by_definition == dual_boundary_after_reindexing
        assert dual_boundary_after_reindexing == dual_boundary_after_transport
        assert dual_boundary_after_transport == dual_boundary_from_primal_faces

        if primal_coefficients in primal_cocycles:
            assert dual_boundary_from_primal_faces.is_zero()
            assert transported_coefficients in dual_cycles


# 各主辺が異なる二面に一回ずつ現れ、各双対辺が二つの双対頂点を結ぶ例。
verify_example(
    primal_edges=("a", "b", "c"),
    primal_faces=("front", "back"),
    occurrences={
        "a": (("forward", "front"), ("reverse", "back")),
        "b": (("forward", "front"), ("reverse", "back")),
        "c": (("forward", "front"), ("reverse", "back")),
    },
)

# 各主辺の二出現が同じ面に属し、各双対辺がループになる例。
verify_example(
    primal_edges=("horizontal", "vertical"),
    primal_faces=("torus_face",),
    occurrences={
        "horizontal": (
            ("forward", "torus_face"),
            ("reverse", "torus_face"),
        ),
        "vertical": (
            ("forward", "torus_face"),
            ("reverse", "torus_face"),
        ),
    },
)

print(
    "RESULT: PASS — dual incidence equals the transpose of the primal "
    "second-boundary matrix entry by entry, and every transported primal "
    "cocycle is a dual cycle in both the two-face and dual-loop examples"
)
