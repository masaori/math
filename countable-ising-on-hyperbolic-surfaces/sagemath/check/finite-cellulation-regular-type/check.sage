# SageMath: 有限セル分割データの正則型集合の厳密検算
# 対象ラベル: def_finite_cellulation_regular_type_set
# 対象: structured-latex/content/finite-cellulation.ts の「有限セル分割データの正則型集合」
# 帰属: 辺端・向き・位置の各有限ラベル集合と NN だけを用いる。

SOURCE = "source"
TARGET = "target"
FORWARD = "forward"
REVERSE = "reverse"
TERMINAL_END = {FORWARD: TARGET, REVERSE: SOURCE}


def cyclic_word(entries):
    positions = []
    edge_at = {}
    orientation_at = {}
    successor = {}
    first_position = None
    previous_position = None
    for position, edge, orientation in entries:
        if first_position is None:
            first_position = position
        if previous_position is not None:
            successor[previous_position] = position
        positions.append(position)
        edge_at[position] = edge
        orientation_at[position] = orientation
        previous_position = position
    assert first_position is not None
    successor[previous_position] = first_position
    return {
        "positions": tuple(positions),
        "successor": successor,
        "edge_at": edge_at,
        "orientation_at": orientation_at,
    }


def corner_vertex(word, position, endpoints):
    edge = word["edge_at"][position]
    orientation = word["orientation_at"][position]
    terminal_label = TERMINAL_END[orientation]
    return endpoints[edge][terminal_label]


def regular_types(vertices, endpoints, boundary_words):
    face_degree_image = Set([NN(len(word["positions"])) for word in boundary_words.values()])
    corner_counts = {vertex: NN(0) for vertex in vertices}
    for word in boundary_words.values():
        for position in word["positions"]:
            vertex = corner_vertex(word, position, endpoints)
            corner_counts[vertex] += 1
    vertex_degree_image = Set([corner_counts[vertex] for vertex in vertices])

    if face_degree_image.cardinality() != 1 or vertex_degree_image.cardinality() != 1:
        return Set([])
    return Set([(face_degree_image.an_element(), vertex_degree_image.an_element())])


# 三角形二面を反対向きに貼った球面では、各面に三つの辺出現があり、各頂点に二つの角が接する。
sphere_vertices = ("A", "B", "C")
sphere_endpoints = {
    "a": {SOURCE: "A", TARGET: "B"},
    "b": {SOURCE: "B", TARGET: "C"},
    "c": {SOURCE: "C", TARGET: "A"},
}
sphere_boundary_words = {
    "north": cyclic_word((("north-a", "a", FORWARD), ("north-b", "b", FORWARD), ("north-c", "c", FORWARD))),
    "south": cyclic_word((("south-c", "c", REVERSE), ("south-b", "b", REVERSE), ("south-a", "a", REVERSE))),
}
assert regular_types(
    sphere_vertices,
    sphere_endpoints,
    sphere_boundary_words,
) == Set([(NN(3), NN(2))])
assert (NN(3), NN(2)) in regular_types(
    sphere_vertices,
    sphere_endpoints,
    sphere_boundary_words,
)

# 三角形四面と正方形一面からなる四角錐の球面では、面次数と頂点次数が一定でない。
pyramid_vertices = ("A", "B", "C", "D", "E")
pyramid_endpoints = {
    "AB": {SOURCE: "A", TARGET: "B"},
    "AC": {SOURCE: "A", TARGET: "C"},
    "AD": {SOURCE: "A", TARGET: "D"},
    "AE": {SOURCE: "A", TARGET: "E"},
    "BC": {SOURCE: "B", TARGET: "C"},
    "CD": {SOURCE: "C", TARGET: "D"},
    "DE": {SOURCE: "D", TARGET: "E"},
    "EB": {SOURCE: "E", TARGET: "B"},
}
pyramid_boundary_words = {
    "ABC": cyclic_word((("ABC-AB", "AB", FORWARD), ("ABC-BC", "BC", FORWARD), ("ABC-AC", "AC", REVERSE))),
    "ACD": cyclic_word((("ACD-AC", "AC", FORWARD), ("ACD-CD", "CD", FORWARD), ("ACD-AD", "AD", REVERSE))),
    "ADE": cyclic_word((("ADE-AD", "AD", FORWARD), ("ADE-DE", "DE", FORWARD), ("ADE-AE", "AE", REVERSE))),
    "AEB": cyclic_word((("AEB-AE", "AE", FORWARD), ("AEB-EB", "EB", FORWARD), ("AEB-AB", "AB", REVERSE))),
    "BCDE": cyclic_word((("BCDE-EB", "EB", REVERSE), ("BCDE-DE", "DE", REVERSE), ("BCDE-CD", "CD", REVERSE), ("BCDE-BC", "BC", REVERSE))),
}

assert regular_types(
    pyramid_vertices,
    pyramid_endpoints,
    pyramid_boundary_words,
) == Set([])

print("RESULT: PASS — the regular-type set is {(3,2)} for the triangular sphere and empty for the irregular pyramid sphere")
