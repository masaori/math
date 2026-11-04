"""Exact finite checks of the dual-cell reachability argument."""

from itertools import combinations


def dual_neighbors(L, blocked):
    cells = [(i, j) for i in range(L) for j in range(L)]
    neighbors = {cell: set() for cell in cells}
    for i, j in cells:
        horizontal = ("h", i, j)
        left = ((i - 1) % L, j)
        if horizontal not in blocked:
            neighbors[(i, j)].add(left)
            neighbors[left].add((i, j))
        vertical = ("v", i, j)
        above = (i, (j - 1) % L)
        if vertical not in blocked:
            neighbors[(i, j)].add(above)
            neighbors[above].add((i, j))
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
for L, max_blocked in [(1, 2), (2, 8), (3, 4)]:
    edges = [(direction, i, j)
             for direction in ("h", "v")
             for i in range(L) for j in range(L)]
    for count in range(max_blocked + 1):
        for selected in combinations(edges, count):
            cells, neighbors = dual_neighbors(L, set(selected))
            for root in cells:
                component = reachable(neighbors, root)
                assert root in component
                assert all(q in component for p in component for q in neighbors[p])
                assert (component != set(cells)) == any(
                    q not in component for q in cells)
                tested += 1

print("RESULT: PASS; exact component checks =", tested)
