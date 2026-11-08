from itertools import combinations


def boundary(cells):
    edges = set()
    for r, c in cells:
        for edge in ((False, r, c), (False, r + 1, c),
                     (True, r, c), (True, r, c + 1)):
            if edge in edges:
                edges.remove(edge)
            else:
                edges.add(edge)
    return edges


def height(edges, r, c):
    return ZZ(sum(1 for vertical, row, col in edges
                  if vertical and row == r and c < col)) % 2


cells = [(ZZ(r), ZZ(c)) for r in range(-1, 2) for c in range(-1, 2)]
count = 0
for size in range(len(cells) + 1):
    for picked in combinations(cells, size):
        edges = boundary(picked)
        rows = {e[1] for e in edges}
        if edges:
            a = min(e[2] for e in edges)
            b = max(e[2] for e in edges)
            cols = set(range(a, b + 1))
        else:
            cols = set()
        product = {(r, c) for r in rows for c in cols}
        support = {(r, c) for r in range(-4, 5) for c in range(-4, 5)
                   if height(edges, r, c) == 1}
        assert support == {(r, c) for r, c in product
                           if height(edges, r, c) == 1}
        assert all(r in rows and c in cols for r, c in support)
        count += 1
print(f"PASS: {count} finite edge sets; height-one cells lie in a finite product")
