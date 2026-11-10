# 対象ラベル: claim_cell_graph_incident_edge_parity_preserved
# 帰属: セル座標・頂点座標は ZZ、接続辺数は NN。
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

cells = tuple((ZZ(row), ZZ(column)) for row in range(2) for column in range(2))
checked = 0
for cell_count in range(len(cells) + 1):
    for chosen_cells in combinations(cells, cell_count):
        edges = sorted(set(edge for cell in chosen_cells for edge in encoded_edges(cell)))
        vertices = set(vertex for edge in edges for vertex in endpoints(edge))
        assert len({endpoints(edge) for edge in edges}) == len(edges)
        for edge_count in range(len(edges) + 1):
            for chosen_edges in combinations(edges, edge_count):
                graph_edges = {endpoints(edge) for edge in chosen_edges}
                for vertex in vertices:
                    source_count = ZZ(sum(vertex in endpoints(edge) for edge in chosen_edges))
                    target_count = ZZ(sum(vertex in graph_edge for graph_edge in graph_edges))
                    assert source_count == target_count
                    assert source_count % 2 == target_count % 2
                    checked += 1
print(f'PASS: {checked} vertex and selected-edge-set pairs')
