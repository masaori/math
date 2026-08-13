load("sagemath/_shared/defs.sage")

origin = vector(QQ, [0, 0, 0])
edges = [
    (origin, coordinate_unit_vector(0)),
    (origin, coordinate_unit_vector(1)),
    (origin, coordinate_unit_vector(2)),
]

for endpoint_u, endpoint_v in edges:
    vertices_forward = dual_face_vertices(endpoint_u, endpoint_v)
    vertices_backward = dual_face_vertices(endpoint_v, endpoint_u)
    assert len(vertices_forward) == 4
    assert vertices_forward == vertices_backward
    assert all(all(coordinate in QQ for coordinate in vertex) for vertex in vertices_forward)

first_face = dual_face_vertices(origin, coordinate_unit_vector(0))
adjacent_face = dual_face_vertices(origin, coordinate_unit_vector(1))
parallel_disjoint_face = dual_face_vertices(
    2 * coordinate_unit_vector(1),
    coordinate_unit_vector(0) + 2 * coordinate_unit_vector(1),
)

assert len(first_face.intersection(adjacent_face)) == 2
assert len(first_face.intersection(parallel_disjoint_face)) == 0

print("dual face vertex-set checks passed over QQ")
