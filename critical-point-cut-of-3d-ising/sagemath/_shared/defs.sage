from itertools import product


def coordinate_unit_vector(index):
    entries = [ZZ(0), ZZ(0), ZZ(0)]
    entries[index] = ZZ(1)
    return vector(QQ, entries)


def oriented_edge_data(endpoint_u, endpoint_v):
    difference = endpoint_v - endpoint_u
    nonzero = [index for index in range(3) if difference[index] != 0]
    assert len(nonzero) == 1
    index = nonzero[0]
    assert abs(difference[index]) == 1
    if difference[index] == 1:
        return endpoint_u, index
    return endpoint_v, index


def dual_face_vertices(endpoint_u, endpoint_v):
    start, direction = oriented_edge_data(endpoint_u, endpoint_v)
    transverse = [index for index in range(3) if index != direction]
    center = start + QQ(1) / QQ(2) * coordinate_unit_vector(direction)
    vertices = []
    for sign_j, sign_k in product([-1, 1], repeat=2):
        point = (
            center
            + QQ(sign_j) / QQ(2) * coordinate_unit_vector(transverse[0])
            + QQ(sign_k) / QQ(2) * coordinate_unit_vector(transverse[1])
        )
        vertices.append(tuple(point))
    return set(vertices)
