from itertools import combinations


checked = 0
for size in range(2, 6):
    vertices = tuple(range(size))
    possible_edges = tuple(combinations(vertices, 2))
    for edge_bits in range(1 << len(possible_edges)):
        edges = [edge for index, edge in enumerate(possible_edges)
                 if (edge_bits >> index) & 1]
        graph = Graph()
        graph.add_vertices(vertices)
        graph.add_edges(edges)
        if not graph.is_connected():
            continue
        for subset_bits in range(1, (1 << size) - 1):
            chosen = {v for v in vertices if (subset_bits >> v) & 1}
            assert any((u in chosen) != (v in chosen) for u, v in edges)
            checked += 1

print("PASS: %s connected-graph cuts" % checked)
