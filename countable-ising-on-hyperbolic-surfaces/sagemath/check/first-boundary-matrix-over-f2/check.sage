# SageMath: F_2 上の一次境界写像の有限行列による厳密検算
# 対象ラベル: def_first_boundary_matrix_over_f2
# 帰属: 形式的な有限ラベル集合と GF(2) 上の有限行列だけを用いる。

SOURCE = "source-end"
TARGET = "target-end"
END_LABELS = (SOURCE, TARGET)


def first_boundary_matrix(vertices, edges, endpoints):
    return matrix(
        GF(2),
        len(vertices),
        len(edges),
        lambda row, column: sum(
            GF(2).one()
            for end_label in END_LABELS
            if endpoints[edges[column]][end_label] == vertices[row]
        ),
    )


def boundary_parity(vertices, edges, endpoints, coefficients):
    return vector(
        GF(2),
        [
            sum(
                coefficients[edge]
                for edge in edges
                for end_label in END_LABELS
                if endpoints[edge][end_label] == vertex
            )
            for vertex in vertices
        ],
    )


vertices = ("A", "B", "C")
edges = ("ab", "bc", "ca")
endpoints = {
    "ab": {SOURCE: "A", TARGET: "B"},
    "bc": {SOURCE: "B", TARGET: "C"},
    "ca": {SOURCE: "C", TARGET: "A"},
}

boundary = first_boundary_matrix(vertices, edges, endpoints)
expected = matrix(
    GF(2),
    [
        [1, 0, 1],
        [1, 1, 0],
        [0, 1, 1],
    ],
)
assert boundary == expected

for mask in range(2 ** len(edges)):
    coefficient_values = [GF(2)((mask >> position) & 1) for position in range(len(edges))]
    coefficient_vector = vector(GF(2), coefficient_values)
    coefficients = dict(zip(edges, coefficient_values))
    assert boundary * coefficient_vector == boundary_parity(
        vertices,
        edges,
        endpoints,
        coefficients,
    )

print("RESULT: PASS — the finite GF(2) incidence matrix gives the endpoint parity for every edge subset of a triangle")
