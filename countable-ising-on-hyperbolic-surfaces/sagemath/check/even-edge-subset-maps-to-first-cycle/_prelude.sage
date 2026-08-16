from itertools import combinations

vertices = ("north", "east", "south", "west")
edges = ("north_east", "east_south", "south_west", "west_north", "north_south")
edge_ends = ("source", "target")
endpoint = {
    ("north_east", "source"): "north",
    ("north_east", "target"): "east",
    ("east_south", "source"): "east",
    ("east_south", "target"): "south",
    ("south_west", "source"): "south",
    ("south_west", "target"): "west",
    ("west_north", "source"): "west",
    ("west_north", "target"): "north",
    ("north_south", "source"): "north",
    ("north_south", "target"): "south",
}

first_boundary = matrix(
    GF(2),
    [
        [
            sum(
                (GF(2).one() for edge_end in edge_ends if endpoint[(edge, edge_end)] == vertex),
                GF(2).zero(),
            )
            for edge in edges
        ]
        for vertex in vertices
    ],
)


def subsets(values):
    values = tuple(values)
    for size in range(len(values) + 1):
        for chosen in combinations(values, size):
            yield frozenset(chosen)


def edge_subset_coefficient_map(chosen):
    return vector(
        GF(2),
        [GF(2).one() if edge in chosen else GF(2).zero() for edge in edges],
    )


def endpoint_incidence_sum(chosen, vertex):
    return sum(
        (
            GF(2).one()
            for edge in chosen
            for edge_end in edge_ends
            if endpoint[(edge, edge_end)] == vertex
        ),
        GF(2).zero(),
    )


def boundary_parity(chosen, vertex):
    incident_count = sum(
        1
        for edge in chosen
        for edge_end in edge_ends
        if endpoint[(edge, edge_end)] == vertex
    )
    return GF(2)(incident_count % 2)


def is_even_edge_subset(chosen):
    return all(boundary_parity(chosen, vertex) == GF(2).zero() for vertex in vertices)
