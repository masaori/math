# 対象ラベル: claim_cell_boundary_coefficient_vertex_balance
from itertools import product
for L in range(1, 5):
    vertices = list(product(range(L), repeat=2))
    edges = [(axis, i, j) for axis in (0, 1) for i, j in vertices]
    def endpoints(e):
        axis, i, j = e
        return (i, j), ((i, (j + 1) % L) if axis == 0 else ((i + 1) % L, j))
    for e in edges:
        source, target = endpoints(e)
        for reverse in (0, 1):
            for v in vertices:
                oriented = (target, source) if reverse else (source, target)
                left = ZZ(oriented[0] == v) - ZZ(oriented[1] == v)
                right = (1 - 2 * ZZ(reverse)) * (ZZ(source == v) - ZZ(target == v))
                assert left == right
print('PASS: orientation incidence identity, L=1..4')
