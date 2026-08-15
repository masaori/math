# SageMath: 各頂点リンクが一つの巡回列である有限述語の正例・負例
# 対象ラベル: def_finite_cellulation_vertex_links_are_cycles
# 対象: structured-latex/content/finite-cellulation.ts の「頂点リンクが一つの巡回列であるための有限述語」
# 帰属: 有限集合、ZZ、真偽値だけを用いる。


def opposite_edge_twice(edges, boundary_words):
    for edge in edges:
        orientations = []
        for word in boundary_words.values():
            orientations.extend(orientation for current_edge, orientation in word if current_edge == edge)
        if len(orientations) != 2:
            return False
        if sum(ZZ(orientation) for orientation in orientations) != 0:
            return False
    return True


def edge_end(edge, orientation, terminal):
    if terminal:
        endpoint_index = (1 + orientation) // 2
    else:
        endpoint_index = (1 - orientation) // 2
    return (edge, endpoint_index)


def vertex_links_are_cycles(vertices, edges, endpoints, boundary_words):
    if not opposite_edge_twice(edges, boundary_words):
        return False

    corners_by_vertex = {vertex: [] for vertex in vertices}
    corner_ends = {}
    for face, word in boundary_words.items():
        for index, (edge, orientation) in enumerate(word):
            next_edge, next_orientation = word[(index + 1) % len(word)]
            incoming_end = edge_end(edge, orientation, terminal=True)
            outgoing_end = edge_end(next_edge, next_orientation, terminal=False)
            incoming_vertex = endpoints[edge][incoming_end[1]]
            outgoing_vertex = endpoints[next_edge][outgoing_end[1]]
            if incoming_vertex != outgoing_vertex:
                return False
            corner = (face, index)
            corners_by_vertex[incoming_vertex].append(corner)
            corner_ends[corner] = (incoming_end, outgoing_end)

    for vertex in vertices:
        corners = corners_by_vertex[vertex]
        if not corners:
            return False

        incident_ends = [
            (edge, endpoint_index)
            for edge in edges
            for endpoint_index in (0, 1)
            if endpoints[edge][endpoint_index] == vertex
        ]
        for current_end in incident_ends:
            if sum(current_end == end for corner in corners for end in corner_ends[corner]) != 2:
                return False

        reached = {corners[0]}
        frontier = [corners[0]]
        while frontier:
            current = frontier.pop()
            for candidate in corners:
                if candidate not in reached and set(corner_ends[current]).intersection(corner_ends[candidate]):
                    reached.add(candidate)
                    frontier.append(candidate)
        if len(reached) != len(corners):
            return False

    return True


# 三角形二面を反対向きに貼った二次元球面では、各頂点リンクは二角からなる一つの巡回列である。
sphere_vertices = ("A", "B", "C")
sphere_edges = ("a", "b", "c")
sphere_endpoints = {
    "a": ("A", "B"),
    "b": ("B", "C"),
    "c": ("C", "A"),
}
sphere_boundary_words = {
    "north": (("a", 1), ("b", 1), ("c", 1)),
    "south": (("c", -1), ("b", -1), ("a", -1)),
}
assert vertex_links_are_cycles(
    sphere_vertices,
    sphere_edges,
    sphere_endpoints,
    sphere_boundary_words,
)

# 二つの二面三角形を頂点 A だけで貼った入力では、A のリンクが二つの巡回列へ分かれる。
pinched_vertices = ("A", "B", "C", "D", "E")
pinched_edges = ("a", "b", "c", "d", "e", "f")
pinched_endpoints = {
    "a": ("A", "B"),
    "b": ("B", "C"),
    "c": ("C", "A"),
    "d": ("A", "D"),
    "e": ("D", "E"),
    "f": ("E", "A"),
}
pinched_boundary_words = {
    "north_left": (("a", 1), ("b", 1), ("c", 1)),
    "south_left": (("c", -1), ("b", -1), ("a", -1)),
    "north_right": (("d", 1), ("e", 1), ("f", 1)),
    "south_right": (("f", -1), ("e", -1), ("d", -1)),
}
assert opposite_edge_twice(pinched_edges, pinched_boundary_words)
assert not vertex_links_are_cycles(
    pinched_vertices,
    pinched_edges,
    pinched_endpoints,
    pinched_boundary_words,
)

# 同方向の二面は辺の逆向き二回出現条件を満たさないため拒否する。
same_orientation = {
    "north": (("a", 1), ("b", 1), ("c", 1)),
    "south": (("a", 1), ("b", 1), ("c", 1)),
}
assert not vertex_links_are_cycles(
    sphere_vertices,
    sphere_edges,
    sphere_endpoints,
    same_orientation,
)

print("RESULT: PASS — accepted the sphere and rejected a disconnected vertex link and inconsistent orientations")
