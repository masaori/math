"""An actual six-edge walk versus two cells with one internal edge cancelled."""

L = 3
S = [(0, 0), (0, 1)]
boundary = [edge for i, j in S for edge in cell_boundary(L, i, j)]
walk = [
    (0, 0, 0, 1),
    (0, 0, 1, 1),
    (1, 0, 2, 1),
    (0, 1, 1, -1),
    (0, 1, 0, -1),
    (1, 0, 0, -1),
]
all_edges = list(product((0, 1), range(L), range(L)))
assert len(boundary) == 8 and len(walk) == 6
assert all(edge_coefficient(walk, edge) == edge_coefficient(boundary, edge)
           for edge in all_edges)
for direction in (0, 1):
    direct = sum((ZZ(sign) * ZZ(axis == direction and
                             (col if direction == 0 else row) == L - 1)
                  for axis, row, col, sign in walk), ZZ(0))
    grouped = sum((edge_coefficient(walk, edge) * ZZ(edge[0] == direction and
                                                     edge[2 if direction == 0 else 1] == L - 1)
                   for edge in all_edges), ZZ(0))
    cell_sum = sum((ZZ(sign) * ZZ(axis == direction and
                               (col if direction == 0 else row) == L - 1)
                    for axis, row, col, sign in boundary), ZZ(0))
    assert direct == grouped == cell_sum == 0
