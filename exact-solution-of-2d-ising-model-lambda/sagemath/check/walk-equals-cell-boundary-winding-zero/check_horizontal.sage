"""Horizontal steps of claim_walk_equals_cell_boundary_winding_zero."""

from itertools import product


def cell_boundary(L, i, j):
    return [
        (0, i, j, 1),
        (1, i, (j + 1) % L, 1),
        (0, (i + 1) % L, j, -1),
        (1, i, j, -1),
    ]


def edge_coefficient(edges, edge):
    return sum((ZZ(sign) for direction, i, j, sign in edges
                if (direction, i, j) == edge), ZZ(0))


for L in (1, 2, 3):
    all_edges = list(product((0, 1), range(L), range(L)))
    for i, j in product(range(L), repeat=2):
        walk = cell_boundary(L, i, j)
        boundary = cell_boundary(L, i, j)
        assert all(edge_coefficient(walk, edge) == edge_coefficient(boundary, edge)
                   for edge in all_edges)
        direct = sum((ZZ(sign) * ZZ(direction == 0 and col == L - 1)
                      for direction, row, col, sign in walk), ZZ(0))
        grouped_walk = sum((edge_coefficient(walk, edge) * ZZ(edge[0] == 0 and edge[2] == L - 1)
                            for edge in all_edges), ZZ(0))
        grouped_boundary = sum((edge_coefficient(boundary, edge) * ZZ(edge[0] == 0 and edge[2] == L - 1)
                                for edge in all_edges), ZZ(0))
        boundary_evaluation = sum((ZZ(sign) * ZZ(direction == 0 and col == L - 1)
                                   for direction, row, col, sign in boundary), ZZ(0))
        assert direct == grouped_walk
        assert grouped_walk == grouped_boundary
        assert grouped_boundary == boundary_evaluation
        assert boundary_evaluation == ZZ(0)
