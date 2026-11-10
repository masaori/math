# 対象ラベル: claim_cell_graph_even_edge_bijection
# 帰属: セル・辺・頂点の座標は ZZ、接続辺数は NN。
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
        graph_edges = {endpoints(edge) for edge in edges}
        vertices = set(vertex for edge in edges for vertex in endpoints(edge))
        assert len(graph_edges) == len(edges)
        even_encoded = set()
        even_graph = set()
        for edge_count in range(len(edges) + 1):
            for selected in combinations(edges, edge_count):
                selected_graph = frozenset(endpoints(edge) for edge in selected)
                encoded_even = all(
                    ZZ(sum(vertex in endpoints(edge) for edge in selected)) % 2 == 0
                    for vertex in vertices)
                graph_even = all(
                    ZZ(sum(vertex in graph_edge for graph_edge in selected_graph)) % 2 == 0
                    for vertex in vertices)
                assert encoded_even == graph_even
                if encoded_even:
                    even_encoded.add(frozenset(selected))
                if graph_even:
                    even_graph.add(selected_graph)
                checked += 1
        assert {frozenset(endpoints(edge) for edge in selected)
                for selected in even_encoded} == even_graph
        assert len(even_encoded) == len(even_graph)
print(f'PASS: {checked} selected-edge subsets; all even subsets correspond bijectively')
