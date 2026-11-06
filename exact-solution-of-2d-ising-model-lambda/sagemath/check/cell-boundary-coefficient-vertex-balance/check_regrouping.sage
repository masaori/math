# 対象ラベル: claim_cell_boundary_coefficient_vertex_balance
from itertools import combinations, product
for L in range(1, 5):
    vertices = list(product(range(L), repeat=2))
    edges = [(axis, i, j) for axis in (0, 1) for i, j in vertices]
    def endpoints(e):
        axis, i, j = e
        return (i, j), ((i, (j + 1) % L) if axis == 0 else ((i + 1) % L, j))
    def boundary(cell):
        i, j = cell
        return [((0, i, j), 0), ((1, i, (j + 1) % L), 0),
                ((0, (i + 1) % L, j), 1), ((1, i, j), 1)]
    subsets = ([group for size in range(len(vertices) + 1)
                for group in combinations(vertices, size)] if L <= 2
               else [(), tuple(vertices), tuple(vertices[::2])])
    for subset in subsets:
        occurrences = [occ for cell in subset for occ in boundary(cell)]
        for v in vertices:
            left = sum((1 - 2 * ZZ(reverse)) *
                       (ZZ(endpoints(e)[0] == v) - ZZ(endpoints(e)[1] == v))
                       for e, reverse in occurrences)
            right = sum(sum(1 - 2 * ZZ(reverse) for base, reverse in occurrences if base == e) *
                        (ZZ(endpoints(e)[0] == v) - ZZ(endpoints(e)[1] == v)) for e in edges)
            assert left == right
            assert left == 0
print('PASS: coefficient regrouping and vertex balance, L=1..4')
