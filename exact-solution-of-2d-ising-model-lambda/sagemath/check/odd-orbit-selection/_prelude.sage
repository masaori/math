from pathlib import Path
from itertools import permutations
load(str(Path(__file__).with_name("construction.sage")))

def oso_graph_supports(sigma):
    # 順逆の反復列とは別に、無向辺の隣接リストから到達集合を作る。
    neighbors = [set() for _ in sigma]
    for i, j in enumerate(sigma):
        neighbors[i].add(j)
        neighbors[j].add(i)
    supports = {}
    for i in range(len(sigma)):
        seen, pending = set(), [i]
        while pending:
            j = pending.pop()
            if j not in seen:
                seen.add(j)
                pending.extend(neighbors[j] - seen)
        supports[i] = frozenset(seen)
    return supports

if "oso_rows" not in globals():
    oso_permutations = [tuple(sigma) for size in range(7) for sigma in permutations(range(size))]
    oso_supports = {sigma: oso_graph_supports(sigma) for sigma in oso_permutations}
    oso_points = {sigma: frozenset(j for j, support in supports.items() if len(support) % 2 == 1)
                  for sigma, supports in oso_supports.items()}
    oso_rows = []
    oso_invariant_pairs = 0
    for sigma in oso_permutations:
        size = len(sigma)
        orders = list(dict.fromkeys((tuple(range(size)), tuple(reversed(range(size))))))
        for mask in range(2 ** size):
            subset = frozenset(j for j in range(size) if (mask >> j) & 1)
            if not all((sigma[j] in subset) == (j in subset) for j in range(size)):
                continue
            oso_invariant_pairs += 1
            rho = oso_reverse(sigma, subset)
            for order in orders:
                rank = tuple(order.index(j) for j in range(size))
                old_points, new_points = oso_points[sigma], oso_points[rho]
                old_min = min(old_points, key=lambda j: rank[j]) if old_points else None
                new_min = min(new_points, key=lambda j: rank[j]) if new_points else None
                oso_rows.append((sigma, rho, subset, rank, old_points, new_points, old_min, new_min))
    assert len(oso_permutations) == 874
    assert oso_invariant_pairs == 5913
    assert len(oso_rows) == 11823

def oso_point_cases():
    for row in oso_rows:
        for j in range(len(row[0])):
            yield row, j

def oso_nonempty_cases():
    for row in oso_rows:
        if row[4]:
            assert row[5]
            yield row
