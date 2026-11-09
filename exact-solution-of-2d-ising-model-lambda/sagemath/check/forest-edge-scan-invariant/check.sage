from itertools import combinations


def scan_prefixes(vertices, allowed_edges, pairs):
    chosen = set()
    yield set(chosen)
    for u, v in pairs:
        graph = Graph([vertices, list(chosen)])
        if (u, v) in allowed_edges and graph.shortest_path(u, v) == []:
            chosen.add((u, v))
        yield set(chosen)


checked = 0
for n in range(1, 5):
    vertices = list(range(n))
    edges = list(combinations(vertices, 2))
    for mask in range(1 << len(edges)):
        allowed = {edge for i, edge in enumerate(edges) if mask & (1 << i)}
        # Every subset of graph edges and every prefix of a list with repeated and absent pairs.
        pairs = edges + list(reversed(edges)) + [(0, 0)]
        for chosen in scan_prefixes(vertices, allowed, pairs):
            assert chosen <= allowed
            assert Graph([vertices, list(chosen)]).is_forest()
            checked += 1

print(f"PASS: {checked} prefixes")
