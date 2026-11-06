# 対象ラベル: claim_height_one_boundary_signed_walk
# 有限トーラスの一セル・横二セルの境界を、両向きについて整数係数で検算する。
def cell_boundary(L, i, j):
    return [((0, i, j), 0), ((1, i, (j + 1) % L), 0),
            ((0, (i + 1) % L, j), 1), ((1, i, j), 1)]

def coefficient(edges, base):
    return sum((ZZ(1 - 2 * direction) for edge, direction in edges if edge == base), ZZ(0))

for L in range(3, 7):
    for cells, boundary in [
        ([(0, 0)], cell_boundary(L, 0, 0)),
        ([(0, 0), (0, 1)],
         [((0, 0, 0), 0), ((0, 0, 1), 0), ((1, 0, 2), 0),
          ((0, 1, 1), 1), ((0, 1, 0), 1), ((1, 0, 0), 1)]),
    ]:
        cell_edges = sum((cell_boundary(L, i, j) for i, j in cells), [])
        all_edges = [(axis, i, j) for axis in (0, 1) for i in range(L) for j in range(L)]
        for walk, sign in [(boundary, ZZ(1)),
                           ([(base, 1 - direction) for base, direction in reversed(boundary)], ZZ(-1))]:
            assert len({base for base, _ in walk}) == len(walk)
            assert all(coefficient(cell_edges, base) == sign * coefficient(walk, base)
                       for base in all_edges)
print("RESULT: PASS; signed boundary coefficients on one- and two-cell loops")
