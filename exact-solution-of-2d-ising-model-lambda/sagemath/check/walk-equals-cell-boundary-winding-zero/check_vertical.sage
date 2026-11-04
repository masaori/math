"""Vertical steps of claim_walk_equals_cell_boundary_winding_zero."""

from itertools import product

for L in (1, 2, 3):
    all_edges = list(product((0, 1), range(L), range(L)))
    for i, j in product(range(L), repeat=2):
        walk = cell_boundary(L, i, j)
        boundary = cell_boundary(L, i, j)
        direct = sum((ZZ(sign) * ZZ(direction == 1 and row == L - 1)
                      for direction, row, col, sign in walk), ZZ(0))
        grouped_walk = sum((edge_coefficient(walk, edge) * ZZ(edge[0] == 1 and edge[1] == L - 1)
                            for edge in all_edges), ZZ(0))
        grouped_boundary = sum((edge_coefficient(boundary, edge) * ZZ(edge[0] == 1 and edge[1] == L - 1)
                                for edge in all_edges), ZZ(0))
        boundary_evaluation = sum((ZZ(sign) * ZZ(direction == 1 and row == L - 1)
                                   for direction, row, col, sign in boundary), ZZ(0))
        assert direct == grouped_walk
        assert grouped_walk == grouped_boundary
        assert grouped_boundary == boundary_evaluation
        assert boundary_evaluation == ZZ(0)
