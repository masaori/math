# 対象ラベル: claim_cell_boundary_vertex_balance
from itertools import combinations, product

for length in range(1, 5):
    cells = list(product(range(length), repeat=2))

    def sides(cell):
        i, j = cell
        a = (i, j)
        b = (i, (j + 1) % length)
        c = ((i + 1) % length, (j + 1) % length)
        d = ((i + 1) % length, j)
        return [(a, b), (b, c), (c, d), (d, a)]

    for cell in cells:
        for vertex in cells:
            incoming = sum(ZZ(target == vertex) for _, target in sides(cell))
            outgoing = sum(ZZ(source == vertex) for source, _ in sides(cell))
            assert outgoing == incoming
            assert outgoing - incoming == 0

    if length <= 2:
        subsets = [group for size in range(len(cells) + 1)
                   for group in combinations(cells, size)]
    else:
        subsets = [(), tuple(cells), tuple(cells[::2])]
    for subset in subsets:
        for vertex in cells:
            difference = sum(ZZ(source == vertex) - ZZ(target == vertex)
                             for cell in subset for source, target in sides(cell))
            assert difference == 0

print("PASS: cyclic four-side incidence and finite cell-set balance, L=1..4")
