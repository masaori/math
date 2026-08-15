# SageMath: 各頂点リンクが一つの巡回列である有限述語の正例・負例
# 対象ラベル: def_finite_cellulation_vertex_links_are_cycles
# 対象: structured-latex/content/finite-cellulation.ts の「頂点リンクが一つの巡回列であるための有限述語」
# 帰属: 辺端・向き・角での役割・位置の各有限ラベル集合と、真偽値だけを用いる。

SOURCE = "source"
TARGET = "target"
END_LABELS = (SOURCE, TARGET)

FORWARD = "forward"
REVERSE = "reverse"
INITIAL_END = {FORWARD: SOURCE, REVERSE: TARGET}
TERMINAL_END = {FORWARD: TARGET, REVERSE: SOURCE}
REVERSED_ORIENTATION = {FORWARD: REVERSE, REVERSE: FORWARD}

ARRIVING = "arriving"
DEPARTING = "departing"
CORNER_SIDE_LABELS = (ARRIVING, DEPARTING)


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


def opposite_edge_twice(edges, boundary_words):
    for edge in edges:
        orientations = []
        for word in boundary_words.values():
            for position in word["positions"]:
                if word["edge_at"][position] == edge:
                    orientations.append(word["orientation_at"][position])
        if len(orientations) != 2:
            return False
        first_orientation, second_orientation = orientations
        if second_orientation != REVERSED_ORIENTATION[first_orientation]:
            return False
    return True


def corner_edge_end(word, position, corner_side):
    if corner_side == ARRIVING:
        edge = word["edge_at"][position]
        orientation = word["orientation_at"][position]
        return (edge, TERMINAL_END[orientation])
    successor_position = word["successor"][position]
    edge = word["edge_at"][successor_position]
    orientation = word["orientation_at"][successor_position]
    return (edge, INITIAL_END[orientation])


def vertex_links_are_cycles(vertices, edges, endpoints, boundary_words):
    if not opposite_edge_twice(edges, boundary_words):
        return False

    corners_by_vertex = {vertex: [] for vertex in vertices}
    corner_ends = {}
    for face, word in boundary_words.items():
        for position in word["positions"]:
            arriving_end = corner_edge_end(word, position, ARRIVING)
            departing_end = corner_edge_end(word, position, DEPARTING)
            arriving_edge, arriving_label = arriving_end
            departing_edge, departing_label = departing_end
            arriving_vertex = endpoints[arriving_edge][arriving_label]
            departing_vertex = endpoints[departing_edge][departing_label]
            if arriving_vertex != departing_vertex:
                return False
            corner = (face, position)
            corners_by_vertex[arriving_vertex].append(corner)
            corner_ends[corner] = {
                ARRIVING: arriving_end,
                DEPARTING: departing_end,
            }

    for vertex in vertices:
        corners = corners_by_vertex[vertex]
        if not corners:
            return False

        incident_ends = [
            (edge, end_label)
            for edge in edges
            for end_label in END_LABELS
            if endpoints[edge][end_label] == vertex
        ]
        for current_end in incident_ends:
            multiplicity = sum(
                current_end == corner_ends[corner][corner_side]
                for corner in corners
                for corner_side in CORNER_SIDE_LABELS
            )
            if multiplicity != 2:
                return False

        initial_corner = next(iter(corners))
        reached = {initial_corner}
        frontier = [initial_corner]
        while frontier:
            current = frontier.pop()
            current_ends = set(corner_ends[current].values())
            for candidate in corners:
                candidate_ends = set(corner_ends[candidate].values())
                if candidate not in reached and current_ends.intersection(candidate_ends):
                    reached.add(candidate)
                    frontier.append(candidate)
        if len(reached) != len(corners):
            return False

    return True


# 三角形二面を反対向きに貼った二次元球面では、各頂点リンクは二角からなる一つの巡回列である。
sphere_vertices = ("A", "B", "C")
sphere_edges = ("a", "b", "c")
sphere_endpoints = {
    "a": {SOURCE: "A", TARGET: "B"},
    "b": {SOURCE: "B", TARGET: "C"},
    "c": {SOURCE: "C", TARGET: "A"},
}
sphere_boundary_words = {
    "north": cyclic_word((("north-a", "a", FORWARD), ("north-b", "b", FORWARD), ("north-c", "c", FORWARD))),
    "south": cyclic_word((("south-c", "c", REVERSE), ("south-b", "b", REVERSE), ("south-a", "a", REVERSE))),
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
    "a": {SOURCE: "A", TARGET: "B"},
    "b": {SOURCE: "B", TARGET: "C"},
    "c": {SOURCE: "C", TARGET: "A"},
    "d": {SOURCE: "A", TARGET: "D"},
    "e": {SOURCE: "D", TARGET: "E"},
    "f": {SOURCE: "E", TARGET: "A"},
}
pinched_boundary_words = {
    "north_left": cyclic_word((("north-left-a", "a", FORWARD), ("north-left-b", "b", FORWARD), ("north-left-c", "c", FORWARD))),
    "south_left": cyclic_word((("south-left-c", "c", REVERSE), ("south-left-b", "b", REVERSE), ("south-left-a", "a", REVERSE))),
    "north_right": cyclic_word((("north-right-d", "d", FORWARD), ("north-right-e", "e", FORWARD), ("north-right-f", "f", FORWARD))),
    "south_right": cyclic_word((("south-right-f", "f", REVERSE), ("south-right-e", "e", REVERSE), ("south-right-d", "d", REVERSE))),
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
    "north": cyclic_word((("north-a", "a", FORWARD), ("north-b", "b", FORWARD), ("north-c", "c", FORWARD))),
    "south": cyclic_word((("south-a", "a", FORWARD), ("south-b", "b", FORWARD), ("south-c", "c", FORWARD))),
}
assert not vertex_links_are_cycles(
    sphere_vertices,
    sphere_edges,
    sphere_endpoints,
    same_orientation,
)

print("RESULT: PASS — accepted the sphere and rejected a disconnected vertex link and inconsistent orientations")
