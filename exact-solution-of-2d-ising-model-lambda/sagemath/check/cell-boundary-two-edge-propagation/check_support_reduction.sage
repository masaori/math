# 対象ラベル: claim_cell_boundary_two_edge_propagation
from itertools import combinations, product

def cases():
    for L in range(2, 4):
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
                    for group in combinations(vertices, size)] if L == 2
                   else [(), tuple(vertices), tuple(vertices[::2]),
                         tuple(vertices[:3])])
        for subset in subsets:
            occurrences = [occ for cell in subset for occ in boundary(cell)]
            coefficient = {e: sum(ZZ(1 - 2 * reverse) for base, reverse in occurrences
                                  if base == e) for e in edges}
            for v in vertices:
                incidence = {e: ZZ(endpoints(e)[0] == v) - ZZ(endpoints(e)[1] == v)
                             for e in edges}
                for a in product(edges, (0, 1)):
                    source_a, target_a = endpoints(a[0])[::(1 if a[1] == 0 else -1)]
                    if target_a != v or source_a == v:
                        continue
                    for b in product(edges, (0, 1)):
                        source_b, target_b = endpoints(b[0])[::(1 if b[1] == 0 else -1)]
                        if a[0] == b[0] or source_b != v or target_b == v:
                            continue
                        if any(coefficient[e] * incidence[e] != 0
                               for e in edges if e not in (a[0], b[0])):
                            continue
                        yield edges, coefficient, incidence, a, b

count = 0
for edges, coefficient, incidence, a, b in cases():
    total = sum(coefficient[e] * incidence[e] for e in edges)
    pair = coefficient[a[0]] * incidence[a[0]] + coefficient[b[0]] * incidence[b[0]]
    assert total == pair
    assert total == 0
    count += 1
assert count > 0
print('RESULT: PASS; support reduction', count)
