# 対象ラベル: claim_cell_graph_edge_incidence_preserved

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

def four_sides(cell):
    row, column = cell
    lower_left = (row, column)
    lower_right = (row, column + 1)
    upper_left = (row + 1, column)
    upper_right = (row + 1, column + 1)
    return (frozenset((lower_left, lower_right)),
            frozenset((upper_left, upper_right)),
            frozenset((lower_left, upper_left)),
            frozenset((lower_right, upper_right)))

cells = tuple((ZZ(row), ZZ(column)) for row in range(-1, 2)
              for column in range(-1, 2))
checked = 0
for count in range(len(cells) + 1):
    for chosen in combinations(cells, count):
        source = frozenset(edge for cell in chosen for edge in encoded_edges(cell))
        graph_edges = frozenset(edge for cell in chosen for edge in four_sides(cell))
        vertices = frozenset(vertex for edge in graph_edges for vertex in edge)
        assert frozenset(endpoints(edge) for edge in source) == graph_edges
        for edge in source:
            for vertex in vertices:
                graph_edge = next(side for side in graph_edges if side == endpoints(edge))
                assert (vertex in graph_edge) == (vertex in endpoints(edge))
                checked += 1

print(f"PASS: incidence preserved for {checked} edge-vertex pairs")
