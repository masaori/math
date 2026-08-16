from itertools import combinations

vertices = ("left", "right")
edges = ("upper", "lower", "middle")
faces = ("lens",)

first_boundary = matrix(
    GF(2),
    [
        [1, 1, 1],
        [1, 1, 1],
    ],
)

second_boundary = matrix(
    GF(2),
    [
        [1],
        [1],
        [0],
    ],
)

edge_coefficient_space = VectorSpace(GF(2), len(edges))
face_coefficient_space = VectorSpace(GF(2), len(faces))
zero_vertex_coefficients = vector(GF(2), [0 for _vertex in vertices])

assert first_boundary * second_boundary == zero_matrix(GF(2), len(vertices), len(faces))


def subsets(values):
    values = tuple(values)
    for size in range(len(values) + 1):
        for chosen in combinations(values, size):
            yield frozenset(chosen)


def edge_subset_coefficient_map(chosen):
    return tuple(
        GF(2).one() if edge in chosen else GF(2).zero()
        for edge in edges
    )


def is_even_edge_subset(chosen):
    coefficients = vector(GF(2), edge_subset_coefficient_map(chosen))
    return first_boundary * coefficients == zero_vertex_coefficients


first_cycle_space = {
    tuple(edge_coefficients)
    for edge_coefficients in edge_coefficient_space
    if first_boundary * edge_coefficients == zero_vertex_coefficients
}

face_boundary_space = {
    tuple(second_boundary * face_coefficients)
    for face_coefficients in face_coefficient_space
}


def add_coefficients(left, right):
    return tuple(GF(2)(a + b) for a, b in zip(left, right))


def quotient_map(cycle):
    return frozenset(
        add_coefficients(cycle, boundary)
        for boundary in face_boundary_space
    )
