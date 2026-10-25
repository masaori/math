from itertools import combinations


def pairings(items):
    if not items:
        yield {}
        return
    first = items[0]
    for mate in items[1:]:
        remaining = [item for item in items[1:] if item != mate]
        for rest in pairings(remaining):
            yield {first: mate, mate: first, **rest}


for edge_count in (1, 2, 3):
    half_edges = [(edge, endpoint) for edge in range(edge_count) for endpoint in (0, 1)]
    source = (lambda h: 0) if edge_count == 1 else (lambda h: (h[0] + h[1]) % 2)
    for selected_count in range(edge_count + 1):
        for selected_edges_tuple in combinations(range(edge_count), selected_count):
            selected_edges = set(selected_edges_tuple)
            selected_half_edges = [h for h in half_edges if h[0] in selected_edges]
            for local_mate in pairings(selected_half_edges):
                if any(source(local_mate[h]) != source(h) for h in selected_half_edges):
                    continue
                mate = {
                    h: local_mate[h] if h[0] in selected_edges else (h[0], 1 - h[1])
                    for h in half_edges
                }
                assert all(mate[mate[h]] == h and mate[h] != h for h in half_edges)
                pairs = {(min(h, mate[h]), max(h, mate[h])) for h in half_edges}
                for first, second in pairs:
                    if first[0] in selected_edges:
                        assert second == local_mate[first]
                        assert second[0] in selected_edges
                        assert source(second) == source(first)
                    else:
                        assert second == (first[0], 1 - first[1])
                        assert second[0] not in selected_edges

print("pair support branches verified")
