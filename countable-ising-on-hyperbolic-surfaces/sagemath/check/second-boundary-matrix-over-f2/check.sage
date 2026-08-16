# SageMath: F_2 上の二次境界写像の有限行列による厳密検算
# 対象ラベル: def_second_boundary_matrix_over_f2
# 帰属: 形式的な有限ラベル集合と GF(2) 上の有限行列だけを用いる。

FORWARD = "forward-orientation"
REVERSE = "reverse-orientation"


def second_boundary_matrix(edges, faces, boundary_words):
    return matrix(
        GF(2),
        len(edges),
        len(faces),
        lambda row, column: sum(
            GF(2).one()
            for edge, orientation in boundary_words[faces[column]]
            if edge == edges[row]
        ),
    )


def boundary_parity(edges, faces, boundary_words, coefficients):
    return vector(
        GF(2),
        [
            sum(
                coefficients[face]
                for face in faces
                for boundary_edge, orientation in boundary_words[face]
                if boundary_edge == edge
            )
            for edge in edges
        ],
    )


edges = ("ab", "bc", "ca", "doubled")
faces = ("front", "back", "folded")
boundary_words = {
    "front": (
        ("ab", FORWARD),
        ("bc", FORWARD),
        ("ca", FORWARD),
    ),
    "back": (
        ("ca", REVERSE),
        ("bc", REVERSE),
        ("ab", REVERSE),
    ),
    "folded": (
        ("doubled", FORWARD),
        ("doubled", REVERSE),
    ),
}

boundary = second_boundary_matrix(edges, faces, boundary_words)
expected = matrix(
    GF(2),
    [
        [1, 1, 0],
        [1, 1, 0],
        [1, 1, 0],
        [0, 0, 0],
    ],
)
assert boundary == expected

for mask in range(2 ** len(faces)):
    coefficient_values = [GF(2)((mask >> position) & 1) for position in range(len(faces))]
    coefficient_vector = vector(GF(2), coefficient_values)
    coefficients = dict(zip(faces, coefficient_values))
    assert boundary * coefficient_vector == boundary_parity(
        edges,
        faces,
        boundary_words,
        coefficients,
    )

print("RESULT: PASS — the finite GF(2) face-boundary matrix agrees with direct boundary-position parity for every face subset")
