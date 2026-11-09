from itertools import combinations


def parity(selected, vertex):
    return sum(vertex in edge for edge in selected) % 2


checked = 0
for n in range(2, 5):
    vertices = set(range(n))
    edges = tuple(combinations(range(n), 2))
    edge_set = set(edges)
    for f_bits in range(1 << len(edges)):
        tree_edges = {edges[i] for i in range(len(edges)) if f_bits & (1 << i)}
        for u_bits in range(1 << n):
            unprocessed = {v for v in vertices if u_bits & (1 << v)}
            for e in tree_edges:
                if not set(e) <= unprocessed:
                    continue
                for a_bits in range(1 << len(edges)):
                    selected = {edges[i] for i in range(len(edges)) if a_bits & (1 << i)}
                    if any(set(f) <= unprocessed for f in selected & tree_edges):
                        continue
                    if any(parity(selected, w) for w in vertices - unprocessed):
                        continue
                    for v in e:
                        candidates = (selected, selected.symmetric_difference({e}))
                        valid = [candidate for candidate in candidates if parity(candidate, v) == 0]
                        assert len(valid) == 1
                        after = valid[0]
                        remaining = unprocessed - {v}
                        assert after <= edge_set
                        assert all(parity(after, w) == 0 for w in vertices - remaining)
                        assert all(not set(f) <= remaining for f in after & tree_edges)
                        assert after & (edge_set - tree_edges) == selected & (edge_set - tree_edges)
                        checked += 1

assert checked > 0
print(f"PASS: {checked} one-vertex invariant transitions")
