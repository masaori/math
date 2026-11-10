# 対象ラベル: claim_cell_edge_endpoints_belong_to_cell_vertices

from itertools import combinations

def corners(cell):
    r, c = cell
    return frozenset(((r, c), (r, c + 1), (r + 1, c), (r + 1, c + 1)))

def edges(cell):
    r, c = cell
    return (
        frozenset(((r, c), (r, c + 1))),
        frozenset(((r + 1, c), (r + 1, c + 1))),
        frozenset(((r, c), (r + 1, c))),
        frozenset(((r, c + 1), (r + 1, c + 1))),
    )

cells = tuple((ZZ(r), ZZ(c)) for r in range(-1, 2) for c in range(-1, 2))
checked = 0
for size in range(len(cells) + 1):
    for chosen in combinations(cells, size):
        vertices = frozenset().union(*(corners(cell) for cell in chosen))
        cell_edges = frozenset().union(*(edges(cell) for cell in chosen))
        assert all(edge <= vertices for edge in cell_edges)
        checked += 1
print(f"PASS: {checked} finite cell sets have all edge endpoints in their vertices")
