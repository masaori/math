# SageMath: 有限セル分割の正則型を判定する有限述語の厳密検算
# 対象ラベル: def_finite_cellulation_regular_type
# 対象: structured-latex/content/finite-cellulation.ts の「有限セル分割の正則型」
# 帰属: 有限集合、NN、真偽値だけを用いる。


def corner_vertex(edge, orientation, endpoints):
    terminal_index = (1 + orientation) // 2
    return endpoints[edge][terminal_index]


def regular_type(vertices, endpoints, boundary_words, p, q, oriented_closed):
    p = NN(p)
    q = NN(q)
    if p == 0 or q == 0 or not oriented_closed:
        return False
    if any(len(word) != p for word in boundary_words.values()):
        return False

    corner_counts = {vertex: NN(0) for vertex in vertices}
    for word in boundary_words.values():
        for edge, orientation in word:
            vertex = corner_vertex(edge, orientation, endpoints)
            corner_counts[vertex] += 1
    return all(corner_counts[vertex] == q for vertex in vertices)


# 三角形二面を反対向きに貼った球面では、各面に三つの辺出現があり、各頂点に二つの角が接する。
sphere_vertices = ("A", "B", "C")
sphere_endpoints = {
    "a": ("A", "B"),
    "b": ("B", "C"),
    "c": ("C", "A"),
}
sphere_boundary_words = {
    "north": (("a", 1), ("b", 1), ("c", 1)),
    "south": (("c", -1), ("b", -1), ("a", -1)),
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
