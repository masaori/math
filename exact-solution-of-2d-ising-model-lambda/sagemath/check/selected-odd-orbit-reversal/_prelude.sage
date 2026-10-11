from pathlib import Path
from itertools import permutations
load(str(Path(__file__).with_name("construction.sage")))

def sor_graph_supports(sigma):
    neighbors = [set() for _ in sigma]
    for i, j in enumerate(sigma):
        neighbors[i].add(j)
        neighbors[j].add(i)
    supports = {}
    for start in range(len(sigma)):
        reached, pending = set(), [start]
        while pending:
            point = pending.pop()
            if point not in reached:
                reached.add(point)
                pending.extend(neighbors[point] - reached)
        supports[start] = frozenset(reached)
    return supports

if "sor_rows" not in globals():
    sor_permutations = [tuple(p) for n in range(7) for p in permutations(range(n))]
    sor_supports = {sigma: sor_graph_supports(sigma) for sigma in sor_permutations}
    sor_points = {sigma: frozenset(i for i, support in supports.items() if len(support) % 2 == 1)
                  for sigma, supports in sor_supports.items()}
    sor_rows = []
    sor_empty_points = 0
    for sigma in sor_permutations:
        size = len(sigma)
        orders = list(dict.fromkeys((tuple(range(size)), tuple(reversed(range(size))))))
        for order in orders:
            rank = tuple(order.index(i) for i in range(size))
            points = sor_points[sigma]
            if not points:
                sor_empty_points += 1
                continue
            minimum = min(points, key=lambda i: rank[i])
            subset = sor_supports[sigma][minimum]
            tau = oso_reverse(sigma, subset)
            next_points = sor_points[tau]
            next_minimum = min(next_points, key=lambda i: rank[i]) if next_points else None
            next_subset = sor_supports[tau][next_minimum] if next_minimum is not None else None
            sor_rows.append(dict(sigma=sigma, inverse=oso_inverse(sigma), tau=tau,
                tau_inverse=oso_inverse(tau), rank=rank, minimum=minimum,
                subset=subset, points=points, next_points=next_points,
                next_subset=next_subset, in_domain=all(sigma[i] != i for i in range(size))))
    assert len(sor_permutations) == 874

def sor_point_cases(inside=None):
    for row in sor_rows:
        for i in range(len(row["sigma"])):
            if inside is None or (i in row["subset"]) == inside:
                yield row, i

def sor_domain_cases():
    for row in sor_rows:
        if row["in_domain"]:
            yield row
