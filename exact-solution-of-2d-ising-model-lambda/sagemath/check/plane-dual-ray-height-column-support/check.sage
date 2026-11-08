from itertools import combinations

# GridEdge = (is_vertical, row, column).
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
    return sum(1 for vertical, row, col in edges
               if vertical and row == r and c < col) % 2

cells = [(r, c) for r in range(-1, 2) for c in range(-1, 2)]
count = 0
for size in range(len(cells) + 1):
    for picked in combinations(cells, size):
        edges = boundary(picked)
        if edges:
            a = min(edge[2] for edge in edges)
            b = max(edge[2] for edge in edges)
            for r in range(-3, 5):
                for c in range(-4, 6):
                    h = height(edges, r, c)
                    if c < a or b <= c:
                        assert h == 0
                    if h == 1:
                        assert a <= c < b
        else:
            for r in range(-3, 5):
                for c in range(-4, 6):
                    assert height(edges, r, c) == 0
        count += 1
print(f"PASS: {count} finite cell sets; exact parity and column bounds")
