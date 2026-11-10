# 対象ラベル: claim_cell_graph_edge_bijection

from itertools import combinations

def encoded_edges(cell):
    row, column = cell
    return ((0, row, column), (0, row + 1, column),
            (1, row, column), (1, row, column + 1))

def endpoints(edge):
    direction, row, column = edge
    if direction == 0:
        return frozenset(((row, column), (row, column + 1)))
    return frozenset(((row, column), (row + 1, column)))

cells = tuple((ZZ(row), ZZ(column)) for row in range(-1, 2)
              for column in range(-1, 2))
checked = 0
for count in range(len(cells) + 1):
    for chosen in combinations(cells, count):
        source = frozenset(edge for cell in chosen for edge in encoded_edges(cell))
        graph_edges = frozenset(endpoints(edge) for edge in source)
        assert len(graph_edges) == len(source)
        assert all(sum(1 for edge in source if endpoints(edge) == graph_edge) == 1
                   for graph_edge in graph_edges)
        checked += 1

print(f"PASS: unique graph-edge preimages for all {checked} finite cell sets")
