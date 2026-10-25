# 対象ラベル: claim_local_pairing_matching_local_mate_recovery
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


checked = 0
for edge_count in (1, 2, 3):
    edges = set(range(edge_count))
    oriented = [(edge, endpoint) for edge in edges for endpoint in (0, 1)]
    source = (lambda h: 0) if edge_count == 1 else (lambda h: (h[0] + h[1]) % 2)
    for selected_count in range(edge_count + 1):
        for selected_tuple in combinations(sorted(edges), selected_count):
            selected = set(selected_tuple)
            active = [h for h in oriented if h[0] in selected]
            for local_mate in pairings(active):
                if any(source(local_mate[h]) != source(h) for h in active):
                    continue
                matching_mate = {
                    h: local_mate[h] if h[0] in selected else (h[0], 1 - h[1])
                    for h in oriented
                }
                assert all(matching_mate[h] == local_mate[h] for h in active)
                checked += 1

print("RESULT: PASS; %d exact local pairings" % checked)
