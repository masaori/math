# 対象ラベル: claim_local_pairing_matching_label_support
# 選択辺による標識の分割と、各枝の相手・始点を厳密な有限列挙で照合する。
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
    half_edges = [(edge, endpoint) for edge in range(edge_count) for endpoint in (0, 1)]
    source = (lambda h: 0) if edge_count == 1 else (lambda h: (h[0] + h[1]) % 2)
    for selected_count in range(edge_count + 1):
        for selected_tuple in combinations(range(edge_count), selected_count):
            selected = set(selected_tuple)
            active = [h for h in half_edges if h[0] in selected]
            for local_mate in pairings(active):
                if any(source(local_mate[h]) != source(h) for h in active):
                    continue
                mate = {
                    h: local_mate[h] if h[0] in selected else (h[0], 1 - h[1])
                    for h in half_edges
                }
                pairs = {(min(h, mate[h]), max(h, mate[h])) for h in half_edges}
                short = {pair for pair in pairs if pair[0][0] in selected}
                long = pairs - short
                assert short.isdisjoint(long) and short | long == pairs
                for first, second in short:
                    assert second == local_mate[first]
                    assert second[0] in selected
                    assert source(second) == source(first)
                    assert second != first
                for first, second in long:
                    assert second == (first[0], 1 - first[1])
                    assert second[0] not in selected
                checked += 1

print("RESULT: PASS; %d exact local pairings" % checked)
