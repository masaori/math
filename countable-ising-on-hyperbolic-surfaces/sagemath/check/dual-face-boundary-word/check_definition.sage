# SageMath: 主頂点リンクの巡回列から双対面の境界語を構成する
# 対象ラベル: def_dual_face_boundary_word
# 対象: finite-fourier-duality.ts のブロック finite_fourier_definition_dual_face_boundary_word
# 帰属: 有限集合。浮動小数点、実数、複素数を使用しない

SOURCE = "source"
TARGET = "target"
FORWARD = "forward"
REVERSE = "reverse"
INITIAL_END = {FORWARD: SOURCE, REVERSE: TARGET}
TERMINAL_END = {FORWARD: TARGET, REVERSE: SOURCE}
REVERSED_ORIENTATION = {FORWARD: REVERSE, REVERSE: FORWARD}


def cyclic_word(entries):
    positions = tuple(position for position, _edge, _orientation in entries)
    successor = {
        positions[index]: positions[(index + 1) % len(positions)]
        for index in range(len(positions))
    }
    return {
        "positions": positions,
        "successor": successor,
        "edge_at": {position: edge for position, edge, _orientation in entries},
        "orientation_at": {
            position: orientation for position, _edge, orientation in entries
        },
    }


def corner_ends(word, position):
    next_position = word["successor"][position]
    arriving_orientation = word["orientation_at"][position]
    departing_orientation = word["orientation_at"][next_position]
    return {
        "arriving": (
            word["edge_at"][position],
            TERMINAL_END[arriving_orientation],
        ),
        "departing": (
            word["edge_at"][next_position],
            INITIAL_END[departing_orientation],
        ),
    }


def d0(face):
    return ("dual_vertex", face)


def d1(edge):
    return ("dual_edge", edge)


def dual_endpoint(boundary_words, dual_edge, endpoint_label):
    primal_edge = dual_edge[1]
    selected_orientation = FORWARD if endpoint_label == SOURCE else REVERSE
    occurrences = tuple(
        face
        for face, word in boundary_words.items()
        for position in word["positions"]
        if word["edge_at"][position] == primal_edge
        and word["orientation_at"][position] == selected_orientation
    )
    assert len(occurrences) == 1
    return d0(occurrences[0])


def dual_faces(vertices, endpoints, boundary_words):
    corners_by_vertex = {vertex: [] for vertex in vertices}
    ends_by_corner = {}
    for face, word in boundary_words.items():
        for position in word["positions"]:
            corner = (face, position)
            ends = corner_ends(word, position)
            arriving_edge, arriving_label = ends["arriving"]
            departing_edge, departing_label = ends["departing"]
            vertex = endpoints[arriving_edge][arriving_label]
            assert endpoints[departing_edge][departing_label] == vertex
            corners_by_vertex[vertex].append(corner)
            ends_by_corner[corner] = ends

    result = {}
    for vertex, corners in corners_by_vertex.items():
        successor = {}
        boundary_edge = {}
        boundary_orientation = {}
        for corner in corners:
            face, position = corner
            word = boundary_words[face]
            departing_end = ends_by_corner[corner]["departing"]
            next_corners = tuple(
                candidate
                for candidate in corners
                if ends_by_corner[candidate]["arriving"] == departing_end
            )
            assert len(next_corners) == 1
            successor[corner] = next_corners[0]
            next_position = word["successor"][position]
            boundary_edge[corner] = d1(word["edge_at"][next_position])
            boundary_orientation[corner] = word["orientation_at"][next_position]

        assert set(successor) == set(corners)
        assert set(successor.values()) == set(corners)
        for initial in corners:
            reached = {initial}
            current = successor[initial]
            while current not in reached:
                reached.add(current)
                current = successor[current]
            assert reached == set(corners)

        for corner in corners:
            next_corner = successor[corner]
            current_orientation = boundary_orientation[corner]
            next_orientation = boundary_orientation[next_corner]
            current_terminal = TERMINAL_END[current_orientation]
            next_initial = INITIAL_END[next_orientation]
            assert dual_endpoint(
                boundary_words, boundary_edge[corner], current_terminal
            ) == dual_endpoint(
                boundary_words, boundary_edge[next_corner], next_initial
            )

        result[vertex] = {
            "positions": tuple(corners),
            "successor": successor,
            "edge_at": boundary_edge,
            "orientation_at": boundary_orientation,
        }
    return result


# 反対向きの二面三角形では、各主頂点から二辺の双対面境界が得られる。
triangle_vertices = ("A", "B", "C")
triangle_endpoints = {
    "a": {SOURCE: "A", TARGET: "B"},
    "b": {SOURCE: "B", TARGET: "C"},
    "c": {SOURCE: "C", TARGET: "A"},
}
triangle_words = {
    "north": cyclic_word(
        (("north-a", "a", FORWARD), ("north-b", "b", FORWARD), ("north-c", "c", FORWARD))
    ),
    "south": cyclic_word(
        (("south-c", "c", REVERSE), ("south-b", "b", REVERSE), ("south-a", "a", REVERSE))
    ),
}
triangle_dual_faces = dual_faces(triangle_vertices, triangle_endpoints, triangle_words)
for vertex, word in triangle_dual_faces.items():
    assert len(word["positions"]) == 2
    incident_primal_edges = {
        edge
        for edge, endpoint_map in triangle_endpoints.items()
        if vertex in endpoint_map.values()
    }
    assert {dual_edge[1] for dual_edge in word["edge_at"].values()} == incident_primal_edges


# 一頂点トーラスでは、一つの主面に接する二つのループ辺が双対面境界へ各二回現れる。
torus_vertices = ("v",)
torus_endpoints = {
    "a": {SOURCE: "v", TARGET: "v"},
    "b": {SOURCE: "v", TARGET: "v"},
}
torus_words = {
    "face": cyclic_word(
        (
            ("a-forward", "a", FORWARD),
            ("b-forward", "b", FORWARD),
            ("a-reverse", "a", REVERSE),
            ("b-reverse", "b", REVERSE),
        )
    )
}
torus_dual_face = dual_faces(torus_vertices, torus_endpoints, torus_words)["v"]
assert len(torus_dual_face["positions"]) == 4
assert tuple(torus_dual_face["edge_at"].values()).count(d1("a")) == 2
assert tuple(torus_dual_face["edge_at"].values()).count(d1("b")) == 2
for dual_edge in torus_dual_face["edge_at"].values():
    assert dual_endpoint(torus_words, dual_edge, SOURCE) == d0("face")
    assert dual_endpoint(torus_words, dual_edge, TARGET) == d0("face")

print(
    "RESULT: PASS — primal vertex links induce cyclic dual-face boundary words "
    "for both the two-face sphere and the one-face torus"
)
