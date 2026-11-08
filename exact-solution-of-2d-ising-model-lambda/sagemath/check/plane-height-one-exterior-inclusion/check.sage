from itertools import combinations


def cell_edges(cell):
    r, c = cell
    return {(False, r, c), (False, r + 1, c),
            (True, r, c), (True, r, c + 1)}


def neighbors(cell):
    r, c = cell
    return {(r - 1, c), (r + 1, c), (r, c - 1), (r, c + 1)}


def exterior_connected(cells):
    box = {(r, c) for r in range(-2, 4) for c in range(-2, 4)}
    exterior = box - cells
    seen = {(-2, -2)}
    frontier = [(-2, -2)]
    while frontier:
        p = frontier.pop()
        for q in neighbors(p) & exterior - seen:
            seen.add(q)
            frontier.append(q)
    return seen == exterior


def even_edges(edges):
    vertices = {(r, c) for r in range(-1, 4) for c in range(-1, 4)}
    return all((sum((False, r, c0) in edges for c0 in (c, c - 1)) +
                sum((True, r0, c) in edges for r0 in (r, r - 1))) % 2 == 0
               for r, c in vertices)


base = {(r, c) for r in range(2) for c in range(2)}
cases = 0
for size in range(5):
    for chosen in combinations(sorted(base), size):
        cells = set(chosen)
        if not exterior_connected(cells):
            continue
        support = sorted(set().union(*(cell_edges(p) for p in cells))) if cells else []
        for mask in range(1 << len(support)):
            edges = {edge for j, edge in enumerate(support) if mask & (1 << j)}
            if not even_edges(edges):
                continue
            height_one = {(r, c) for r in range(-2, 4) for c in range(-2, 4)
                          if sum((True, r, j) in edges for j in range(c + 1, 4)) % 2}
            boundary = {edge for edge in set().union(*(cell_edges(p) for p in height_one))
                        if ((edge[1], edge[2]) in height_one) !=
                           (((edge[1], edge[2] - 1) if edge[0] else
                             (edge[1] - 1, edge[2])) in height_one)} if height_one else set()
            assert boundary == edges, (cells, edges, boundary)
            exterior = {(r, c) for r in range(-2, 4) for c in range(-2, 4)} - cells
            for p in exterior:
                for q in neighbors(p) & exterior:
                    assert (p in height_one) == (q in height_one)
            assert height_one <= cells, (cells, edges, height_one)
            cases += 1

assert cases > 0
print(f"PASS: {cases} even-edge cases")
