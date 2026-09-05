# SageMath: 生成剰余類セルデータの有限検査
# 対象ラベル: theorem_generated_quotient_cellulation_is_hyperbolic_regular
# 帰属: 有限置換群、有限集合、NN、真偽値だけを用いる

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

ambient = SymmetricGroup(8)
face_rotation = ambient("(1,6,2)(3,8,4)")
vertex_rotation = ambient("(1,8,4,2,5,6,7)")
edge_half_turn = ambient("(1,4)(2,5)(3,8)(6,7)")
quotient_group = PermutationGroup(
    [face_rotation, vertex_rotation, edge_half_turn],
    canonicalize=False,
)


# Gévay--Jones の PSL(2,7) Hurwitz 三生成元
# x=[[1,1],[0,1]], y=[[0,1],[-1,0]], z=[[0,-1],[1,-1]]
# の P^1(F_7) 作用を、下の全単射で八点作用へ移す。
projective_points = tuple(range(7)) + ("infinity",)
projective_relabeling = {
    "infinity": 3,
    0: 8,
    1: 4,
    2: 2,
    3: 5,
    4: 6,
    5: 7,
    6: 1,
}


def projective_x(point):
    if point == "infinity":
        return "infinity"
    return (point + 1) % 7


def projective_y(point):
    if point == "infinity":
        return 0
    if point == 0:
        return "infinity"
    return (-inverse_mod(point, 7)) % 7


def projective_z(point):
    if point == "infinity":
        return 0
    denominator = (point - 1) % 7
    if denominator == 0:
        return "infinity"
    return (-inverse_mod(denominator, 7)) % 7


for point in projective_points:
    label = projective_relabeling[point]
    assert projective_relabeling[projective_x(point)] == vertex_rotation(label)
    assert projective_relabeling[projective_y(point)] == edge_half_turn(label)
    assert projective_relabeling[projective_z(point)] == face_rotation(label)

assert quotient_group.order() == 168
assert face_rotation.order() == 3
assert vertex_rotation.order() == 7
assert edge_half_turn.order() == 2
for point in range(1, 9):
    assert face_rotation(vertex_rotation(edge_half_turn(point))) == point

face_stabilizer = quotient_group.subgroup([face_rotation])
vertex_stabilizer = quotient_group.subgroup([vertex_rotation])
edge_stabilizer = quotient_group.subgroup([edge_half_turn])
# 本文の合成 (gk)(a)=g(k(a)) は Sage の積と逆順。
def compose(left, right):
    return right * left


def left_coset(group_element, subgroup):
    return frozenset(compose(group_element, member) for member in subgroup)


def all_left_cosets(subgroup):
    return sorted({left_coset(g, subgroup) for g in quotient_group},
                  key=lambda coset: min(permutation_key(g) for g in coset))


def permutation_key(permutation):
    return tuple(permutation(index) for index in range(1, 9))


def representative_selector(edge_coset):
    return min(edge_coset, key=permutation_key)


def edge_endpoints(edge_coset):
    selected = representative_selector(edge_coset)
    return {
        SOURCE: left_coset(selected, vertex_stabilizer),
        TARGET: left_coset(compose(selected, edge_half_turn), vertex_stabilizer),
    }


def boundary_entry(group_element):
    edge_coset = left_coset(group_element, edge_stabilizer)
    selected = representative_selector(edge_coset)
    if selected == group_element:
        return edge_coset, FORWARD
    assert selected == compose(group_element, edge_half_turn)
    return edge_coset, REVERSE


def cyclic_boundary_word(face_coset):
    first = min(face_coset, key=permutation_key)
    positions = tuple(compose(first, face_rotation**power) for power in range(3))
    assert set(positions) == set(face_coset)
    successor = {
        positions[index]: positions[(index + 1) % len(positions)]
        for index in range(len(positions))
    }
    edge_at = {}
    orientation_at = {}
    for position in positions:
        edge_at[position], orientation_at[position] = boundary_entry(position)
    return {
        "positions": positions,
        "successor": successor,
        "edge_at": edge_at,
        "orientation_at": orientation_at,
    }


face_cosets = all_left_cosets(face_stabilizer)
vertex_cosets = all_left_cosets(vertex_stabilizer)
edge_cosets = all_left_cosets(edge_stabilizer)
for g in quotient_group:
    for h in (face_rotation, vertex_rotation, edge_half_turn):
        assert all(compose(g, h)(i) == g(h(i)) for i in range(1, 9))

vertices = tuple(vertex_cosets)
edges = tuple(edge_cosets)
faces = tuple(face_cosets)
endpoints = {edge: edge_endpoints(edge) for edge in edges}
boundary_words = {face: cyclic_boundary_word(face) for face in faces}

# 本文の各位置の進行端点まで照合し、逆向きの別モデルの成功を防ぐ。
for word in boundary_words.values():
    for position in word["positions"]:
        edge = word["edge_at"][position]
        orientation = word["orientation_at"][position]
        assert endpoints[edge][INITIAL_END[orientation]] == left_coset(position, vertex_stabilizer)
        assert endpoints[edge][TERMINAL_END[orientation]] == left_coset(compose(position, edge_half_turn), vertex_stabilizer)

assert len(vertices) == 24
assert len(edges) == 84
assert len(faces) == 56


def opposite_edge_twice():
    for edge in edges:
        orientations = [
            word["orientation_at"][position]
            for word in boundary_words.values()
            for position in word["positions"]
            if word["edge_at"][position] == edge
        ]
        if len(orientations) != 2:
            return False
        if orientations[1] != REVERSED_ORIENTATION[orientations[0]]:
            return False
    return True


def corner_edge_end(word, position, corner_side):
    if corner_side == ARRIVING:
        edge = word["edge_at"][position]
        orientation = word["orientation_at"][position]
        return edge, TERMINAL_END[orientation]
    successor_position = word["successor"][position]
    edge = word["edge_at"][successor_position]
    orientation = word["orientation_at"][successor_position]
    return edge, INITIAL_END[orientation]


def vertex_links_are_cycles():
    corners_by_vertex = {vertex: [] for vertex in vertices}
    corner_ends = {}
    for face, word in boundary_words.items():
        for position in word["positions"]:
            arriving_end = corner_edge_end(word, position, ARRIVING)
            departing_end = corner_edge_end(word, position, DEPARTING)
            arriving_vertex = endpoints[arriving_end[0]][arriving_end[1]]
            departing_vertex = endpoints[departing_end[0]][departing_end[1]]
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
        if len(corners) != 7:
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

        reached = {corners[0]}
        frontier = [corners[0]]
        while frontier:
            current = frontier.pop()
            current_ends = set(corner_ends[current].values())
            for candidate in corners:
                if candidate in reached:
                    continue
                if current_ends.intersection(corner_ends[candidate].values()):
                    reached.add(candidate)
                    frontier.append(candidate)
        if len(reached) != len(corners):
            return False
    return True


def connected_one_skeleton():
    reached = {vertices[0]}
    frontier = [vertices[0]]
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


opposite = opposite_edge_twice()
cyclic_links = vertex_links_are_cycles()
connected = connected_one_skeleton()
oriented_closed = opposite and cyclic_links and connected
assert opposite
assert cyclic_links
assert connected
assert oriented_closed

face_degree_image = Set([NN(len(word["positions"])) for word in boundary_words.values()])
corner_counts = {vertex: 0 for vertex in vertices}
for word in boundary_words.values():
    for position in word["positions"]:
        edge = word["edge_at"][position]
        orientation = word["orientation_at"][position]
        corner_vertex = endpoints[edge][TERMINAL_END[orientation]]
        corner_counts[corner_vertex] += 1
vertex_degree_image = Set([NN(count) for count in corner_counts.values()])
assert face_degree_image == Set([NN(3)])
assert vertex_degree_image == Set([NN(7)])

regular_types = Set([])
if face_degree_image.cardinality() == 1 and vertex_degree_image.cardinality() == 1:
    regular_types = Set([(face_degree_image.an_element(), vertex_degree_image.an_element())])
assert regular_types == Set([(NN(3), NN(7))])

hyperbolic_regular_types = Set([
    (p, q)
    for p, q in regular_types
    if 2 * (p + q) < p * q
])
assert (NN(3), NN(7)) in hyperbolic_regular_types

# 旧検算の一次骨格から逆元写像で頂点・辺の全単射を作り、
# 向きを忘れた端点対を保存することを照合する（Ising 係数の回帰）。
old_vertices = {frozenset(g * h for h in vertex_stabilizer) for g in quotient_group}
old_edges = {frozenset(g * h for h in edge_stabilizer) for g in quotient_group}

def invert_coset(C):
    return frozenset(g**(-1) for g in C)

assert {invert_coset(C) for C in old_vertices} == set(vertices)
assert {invert_coset(C) for C in old_edges} == set(edges)
for C in old_edges:
    selected = min(C, key=permutation_key)
    old_pair = [frozenset(selected * h for h in vertex_stabilizer),
                frozenset(selected * edge_half_turn * h for h in vertex_stabilizer)]
    assert {invert_coset(V) for V in old_pair} == set(endpoints[invert_coset(C)].values())

print(
    "RESULT: PASS — the sourced degree-eight Hurwitz triple generates 24 vertices, "
    "84 edges, and 56 triangular faces; all vertex links are seven-cycles, the "
    "one-skeleton is connected, and (3,7) belongs to the hyperbolic regular-type set"
)
