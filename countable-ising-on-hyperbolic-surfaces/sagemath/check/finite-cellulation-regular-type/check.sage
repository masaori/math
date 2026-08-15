# SageMath: 有限セル分割の正則型を判定する有限述語の厳密検算
# 対象ラベル: def_finite_cellulation_regular_type
# 対象: structured-latex/content/finite-cellulation.ts の「有限セル分割の正則型」
# 帰属: 辺端・向き・位置の各有限ラベル集合、NN、真偽値だけを用いる。

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


def regular_type(vertices, endpoints, boundary_words, p, q, oriented_closed):
    p = NN(p)
    q = NN(q)
    if p == 0 or q == 0 or not oriented_closed:
        return False
    if any(len(word["positions"]) != p for word in boundary_words.values()):
        return False

    corner_counts = {vertex: NN(0) for vertex in vertices}
    for word in boundary_words.values():
        for position in word["positions"]:
            vertex = corner_vertex(word, position, endpoints)
            corner_counts[vertex] += 1
    return all(corner_counts[vertex] == q for vertex in vertices)


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
assert regular_type(
    sphere_vertices,
    sphere_endpoints,
    sphere_boundary_words,
    3,
    2,
    oriented_closed=True,
)

# 面の辺出現数または頂点の角出現数が指定値と異なれば拒否する。
assert not regular_type(
    sphere_vertices,
    sphere_endpoints,
    sphere_boundary_words,
    4,
    2,
    oriented_closed=True,
)
assert not regular_type(
    sphere_vertices,
    sphere_endpoints,
    sphere_boundary_words,
    3,
    3,
    oriented_closed=True,
)

# incidence が一致しても、向き付け閉曲面述語を満たさない入力は正則型と呼ばない。
assert not regular_type(
    sphere_vertices,
    sphere_endpoints,
    sphere_boundary_words,
    3,
    2,
    oriented_closed=False,
)

print("RESULT: PASS — accepted regular type {3,2} and rejected three failed conjuncts")
