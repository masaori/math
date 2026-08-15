# SageMath: 向き付けられた閉曲面セル分割を判定する有限述語の正例・負例
# 対象ラベル: def_oriented_closed_surface_cellulation
# 対象: structured-latex/content/finite-cellulation.ts の「向き付けられた閉曲面セル分割を判定する有限述語」
# 帰属: 辺端・向き・角での役割・位置の各有限ラベル集合、NN、真偽値だけを用いる。

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


def connected_one_skeleton(vertices, edges, endpoints):
    initial_vertex = next(iter(vertices))
    reached = {initial_vertex}
    frontier = [initial_vertex]
    while frontier:
        current = frontier.pop()
        for edge in edges:
            source_vertex = endpoints[edge][SOURCE]
            target_vertex = endpoints[edge][TARGET]
            if source_vertex == current and target_vertex not in reached:
                reached.add(target_vertex)
                frontier.append(target_vertex)
            if target_vertex == current and source_vertex not in reached:
                reached.add(source_vertex)
                frontier.append(source_vertex)
    return reached == set(vertices)


def oriented_closed_surface_cellulation(vertices, edges, endpoints, boundary_words):
    return (
        opposite_edge_twice(edges, boundary_words)
        and vertex_links_are_cycles(vertices, edges, endpoints, boundary_words)
        and connected_one_skeleton(vertices, edges, endpoints)
    )


# 三角形の二面を反対向きに貼った球面は、三条件を全て満たす。
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
assert oriented_closed_surface_cellulation(
    sphere_vertices,
    sphere_edges,
    sphere_endpoints,
    sphere_boundary_words,
)

# 同方向の二面は、辺の逆向き二回出現条件を満たさない。
same_orientation = {
    "north": cyclic_word((("north-a", "a", FORWARD), ("north-b", "b", FORWARD), ("north-c", "c", FORWARD))),
    "south": cyclic_word((("south-a", "a", FORWARD), ("south-b", "b", FORWARD), ("south-c", "c", FORWARD))),
}
assert not oriented_closed_surface_cellulation(
    sphere_vertices,
    sphere_edges,
    sphere_endpoints,
    same_orientation,
)

# 二つの球面を頂点 A だけで貼った入力は、A のリンクが二つの巡回列へ分かれる。
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
assert not oriented_closed_surface_cellulation(
    pinched_vertices,
    pinched_edges,
    pinched_endpoints,
    pinched_boundary_words,
)

# 互いに素な二つの球面は局所条件を満たすが、一次骨格が連結でない。
disconnected_vertices = ("A", "B", "C", "D", "E", "F")
disconnected_edges = ("a", "b", "c", "d", "e", "f")
disconnected_endpoints = {
    "a": {SOURCE: "A", TARGET: "B"},
    "b": {SOURCE: "B", TARGET: "C"},
    "c": {SOURCE: "C", TARGET: "A"},
    "d": {SOURCE: "D", TARGET: "E"},
    "e": {SOURCE: "E", TARGET: "F"},
    "f": {SOURCE: "F", TARGET: "D"},
}
disconnected_boundary_words = {
    "north_left": cyclic_word((("north-left-a", "a", FORWARD), ("north-left-b", "b", FORWARD), ("north-left-c", "c", FORWARD))),
    "south_left": cyclic_word((("south-left-c", "c", REVERSE), ("south-left-b", "b", REVERSE), ("south-left-a", "a", REVERSE))),
    "north_right": cyclic_word((("north-right-d", "d", FORWARD), ("north-right-e", "e", FORWARD), ("north-right-f", "f", FORWARD))),
    "south_right": cyclic_word((("south-right-f", "f", REVERSE), ("south-right-e", "e", REVERSE), ("south-right-d", "d", REVERSE))),
}
assert opposite_edge_twice(disconnected_edges, disconnected_boundary_words)
assert vertex_links_are_cycles(
    disconnected_vertices,
    disconnected_edges,
    disconnected_endpoints,
    disconnected_boundary_words,
)
assert not connected_one_skeleton(
    disconnected_vertices,
    disconnected_edges,
    disconnected_endpoints,
)
assert not oriented_closed_surface_cellulation(
    disconnected_vertices,
    disconnected_edges,
    disconnected_endpoints,
    disconnected_boundary_words,
)

print("RESULT: PASS — accepted the sphere and rejected inconsistent orientation, disconnected vertex link, and disconnected skeleton")
