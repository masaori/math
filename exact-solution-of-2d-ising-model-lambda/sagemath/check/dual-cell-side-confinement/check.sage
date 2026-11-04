"""Exact finite checks for confinement in a dual-step-closed side."""
from itertools import combinations


def dual_neighbors(L, blocked):
    cells = [(i, j) for i in range(L) for j in range(L)]
    neighbors = {p: set() for p in cells}
    for i, j in cells:
        for edge, q in ((('h', i, j), ((i - 1) % L, j)),
                        (('v', i, j), (i, (j - 1) % L))):
            if edge not in blocked:
                neighbors[(i, j)].add(q)
                neighbors[q].add((i, j))
    return cells, neighbors


def reachable(neighbors, root):
    visited = {root}
    frontier = [root]
    while frontier:
        p = frontier.pop()
        for q in neighbors[p]:
            if q not in visited:
                visited.add(q)
                frontier.append(q)
    return visited


tested = ZZ(0)
for L, max_blocked in ((1, 2), (2, 8), (3, 2)):
    edges = [(d, i, j) for d in ('h', 'v') for i in range(L) for j in range(L)]
    for n in range(max_blocked + 1):
        for selected in combinations(edges, n):
            cells, neighbors = dual_neighbors(L, set(selected))
            for mask in range(1, 1 << len(cells)):
                side = {cells[t] for t in range(len(cells)) if mask & (1 << t)}
                if not all(q in side for p in side for q in neighbors[p]):
                    continue
                for root in side:
                    component = reachable(neighbors, root)
                    assert component <= side
                    if side != set(cells):
                        assert component != set(cells)
                    tested += 1
print('RESULT: PASS; closed-side checks =', tested)
