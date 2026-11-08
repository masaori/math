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


grid = [(ZZ(r), ZZ(c)) for r in range(-1, 2) for c in range(-1, 2)]
count = 0
for size in range(len(grid) + 1):
    for picked in combinations(grid, size):
        edges = boundary(picked)
        height_one = {(r, c) for r in range(-4, 5) for c in range(-4, 5)
                      if height(edges, r, c) == 1}
        assert height_one == set(picked)
        for vertical, r, c in edges:
            if vertical:
                assert ((r, c) in height_one) != ((r, c - 1) in height_one)
            else:
                assert ((r, c) in height_one) != ((r - 1, c) in height_one)
        assert boundary(height_one) == edges
        count += 1
print(f"PASS: {count} finite even edge sets; both edge directions and full boundary agree")
