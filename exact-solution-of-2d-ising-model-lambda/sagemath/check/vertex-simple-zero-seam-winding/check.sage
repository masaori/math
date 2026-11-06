# 対象ラベル: claim_vertex_simple_zero_seam_winding
# 境界鎖の符号倍から二つの切断線の整数巻き付きが零になる有限例。
def cell_boundary(L, i, j):
    return [((0, i, j), 0), ((1, i, (j + 1) % L), 0),
            ((0, (i + 1) % L, j), 1), ((1, i, j), 1)]

def coefficient(edges, base):
    return sum((ZZ(1 - 2 * direction) for edge, direction in edges if edge == base), ZZ(0))

def winding(edges, L, axis):
    return sum((ZZ(1 - 2 * direction) for (kind, i, j), direction in edges
                if kind == axis and (j if axis == 0 else i) == L - 1), ZZ(0))

for L in range(3, 7):
    for cells, walk in [
        ([(0, 0)], cell_boundary(L, 0, 0)),
        ([(0, 0), (0, 1)],
         [((0, 0, 0), 0), ((0, 0, 1), 0), ((1, 0, 2), 0),
          ((0, 1, 1), 1), ((0, 1, 0), 1), ((1, 0, 0), 1)]),
    ]:
        boundary = sum((cell_boundary(L, i, j) for i, j in cells), [])
        bases = [(axis, i, j) for axis in (0, 1) for i in range(L) for j in range(L)]
        for oriented, sign in [(walk, ZZ(1)),
                               ([(base, 1 - direction) for base, direction in reversed(walk)], ZZ(-1))]:
            assert all(coefficient(boundary, base) == sign * coefficient(oriented, base)
                       for base in bases)
            for axis in (0, 1):
                assert winding(boundary, L, axis) == sign * winding(oriented, L, axis)
                assert winding(boundary, L, axis) == 0
                assert winding(oriented, L, axis) == 0
print('RESULT: PASS; signed boundary and both integer winding sums')
