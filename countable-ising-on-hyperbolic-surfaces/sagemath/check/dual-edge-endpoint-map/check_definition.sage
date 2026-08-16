# SageMath: 向きごとの一意な主辺出現から双対辺の端点写像を構成する
# 対象ラベル: def_dual_edge_endpoint_map
# 対象: finite-fourier-duality.ts のブロック finite_fourier_definition_dual_edge_endpoint_map
# 帰属: 有限集合。浮動小数点、実数、複素数を使用しない

FORWARD = "forward"
REVERSE = "reverse"
SOURCE = "source"
TARGET = "target"


def d0(face):
    return ("dual_vertex", face)


def d1(edge):
    return ("dual_edge", edge)


def occurrences(boundary_occurrences, edge, orientation):
    return tuple(
        (face, position)
        for face, position, boundary_edge, boundary_orientation in boundary_occurrences
        if boundary_edge == edge and boundary_orientation == orientation
    )


def dual_endpoint(boundary_occurrences, dual_edge, endpoint_label):
    edge = dual_edge[1]
    orientation = FORWARD if endpoint_label == SOURCE else REVERSE
    selected_occurrences = occurrences(boundary_occurrences, edge, orientation)
    assert len(selected_occurrences) == 1
    face, _position = selected_occurrences[0]
    return d0(face)


# 二面三角形では、各双対辺が相異なる二つの双対頂点を結ぶ。
triangle_edges = ("e0", "e1", "e2")
triangle_occurrences = tuple(
    [("front", ("front_position", edge), edge, FORWARD) for edge in triangle_edges]
    + [("back", ("back_position", edge), edge, REVERSE) for edge in triangle_edges]
)

for edge in triangle_edges:
    forward_occurrences = occurrences(triangle_occurrences, edge, FORWARD)
    reverse_occurrences = occurrences(triangle_occurrences, edge, REVERSE)
    assert len(forward_occurrences) == 1
    assert len(reverse_occurrences) == 1
    assert dual_endpoint(triangle_occurrences, d1(edge), SOURCE) == d0("front")
    assert dual_endpoint(triangle_occurrences, d1(edge), TARGET) == d0("back")
    assert dual_endpoint(triangle_occurrences, d1(edge), SOURCE) != dual_endpoint(
        triangle_occurrences, d1(edge), TARGET
    )


# 同じ主面に逆向きの二出現がある場合、双対辺の二端点は一致する。
self_incident_occurrences = (
    ("single_face", "forward_position", "identified_edge", FORWARD),
    ("single_face", "reverse_position", "identified_edge", REVERSE),
)
self_incident_dual_edge = d1("identified_edge")

assert len(occurrences(self_incident_occurrences, "identified_edge", FORWARD)) == 1
assert len(occurrences(self_incident_occurrences, "identified_edge", REVERSE)) == 1
assert dual_endpoint(self_incident_occurrences, self_incident_dual_edge, SOURCE) == d0(
    "single_face"
)
assert dual_endpoint(self_incident_occurrences, self_incident_dual_edge, TARGET) == d0(
    "single_face"
)
assert dual_endpoint(self_incident_occurrences, self_incident_dual_edge, SOURCE) == dual_endpoint(
    self_incident_occurrences, self_incident_dual_edge, TARGET
)

print(
    "RESULT: PASS — each orientation selects one primal edge occurrence and "
    "the induced dual endpoints agree with both distinct-face and self-incidence cases"
)
