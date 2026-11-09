from collections import deque
from itertools import combinations


def corners(cell):
    r, c = cell
    return {(r, c), (r, c + 1), (r + 1, c), (r + 1, c + 1)}


def edges(cell):
    r, c = cell
    return {
        frozenset(((r, c), (r, c + 1))),
        frozenset(((r + 1, c), (r + 1, c + 1))),
        frozenset(((r, c), (r + 1, c))),
        frozenset(((r, c + 1), (r + 1, c + 1))),
    }


def reached(start, vertices, adjacent):
    seen, queue = {start}, deque([start])
    while queue:
        current = queue.popleft()
        for neighbor in adjacent(current):
            if neighbor in vertices and neighbor not in seen:
                seen.add(neighbor)
                queue.append(neighbor)
    return seen


cells = [(ZZ(r), ZZ(c)) for r in range(3) for c in range(3)]
checked = 0
for size in range(1, len(cells) + 1):
    for chosen in combinations(cells, size):
        chosen = set(chosen)
        first = next(iter(chosen))
        cell_reached = reached(
            first, chosen,
            lambda p: (q for q in chosen if abs(p[0] - q[0]) + abs(p[1] - q[1]) == 1),
        )
        if cell_reached != chosen:
            continue
        vertices = set().union(*(corners(p) for p in chosen))
        all_edges = set().union(*(edges(p) for p in chosen))
        vertex_reached = reached(
            next(iter(vertices)), vertices,
            lambda u: (v for edge in all_edges if u in edge for v in edge),
        )
        assert vertex_reached == vertices, chosen
        checked += 1

assert checked == 218, checked
print(f"PASS: {checked} edge-connected nonempty subsets of a 3x3 cell square")
