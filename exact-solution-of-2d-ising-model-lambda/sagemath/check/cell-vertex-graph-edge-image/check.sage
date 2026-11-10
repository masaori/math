# 対象ラベル: claim_cell_vertex_graph_edge_image

from itertools import combinations

def endpoints(edge):
    direction, row, column = edge
    if direction == 0:
        return frozenset(((row, column), (row, column + 1)))
    return frozenset(((row, column), (row + 1, column)))

def encoded_edges(cell):
    row, column = cell
    return ((0, row, column), (0, row + 1, column),
            (1, row, column), (1, row, column + 1))

def corners(cell):
    row, column = cell
    return frozenset(((row, column), (row, column + 1),
                      (row + 1, column), (row + 1, column + 1)))

cells = tuple((ZZ(row), ZZ(column)) for row in range(-1, 2)
              for column in range(-1, 2))
checked = 0
for count in range(len(cells) + 1):
    for chosen in combinations(cells, count):
        vertices = frozenset().union(*(corners(cell) for cell in chosen))
        encoded = frozenset(edge for cell in chosen for edge in encoded_edges(cell))
        edge_image = frozenset(endpoints(edge) for edge in encoded)
        graph_edges = frozenset(
            frozenset(pair) for pair in combinations(vertices, 2)
            if frozenset(pair) in edge_image)
        assert all(len(edge) == 2 and edge <= vertices for edge in edge_image)
        assert graph_edges == edge_image
        assert len(graph_edges) == len(encoded)
        checked += 1
print(f"PASS: {checked} finite cell sets have graph edges equal to the encoded edge image")
