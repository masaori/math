# 対象ラベル: claim_projected_edge_cycle_closure
# 長い相手を反転とする標識付き交互閉路の偶数番目の射影を照合する。
def matchings(vertices):
    if not vertices:
        yield frozenset()
        return
    first = vertices[0]
    for partner in vertices[1:]:
        rest = tuple(v for v in vertices if v != first and v != partner)
        for tail in matchings(rest):
            yield tail | {frozenset((first, partner))}


def mate(matching, vertex):
    pair = next(pair for pair in matching if vertex in pair)
    return next(iter(pair - {vertex}))


for size in (2, 4, 6):
    vertices = tuple(range(size))
    reference = frozenset(frozenset((i, i + 1)) for i in range(0, size, 2))
    reversal = lambda i: i + 1 if i % 2 == 0 else i - 1
    for matching in matchings(vertices):
        pairs = tuple(matching)
        for choice in range(1 << len(pairs)):
            short = {pair for bit, pair in enumerate(pairs) if choice & (1 << bit)}
            if any(pair not in reference for pair in matching - short):
                continue
            tagged = {(pair, 'short' if pair in short else 'long') for pair in matching}
            difference = tagged.symmetric_difference({(pair, 'long') for pair in reference})
            active = {v for v in vertices if any(v in pair for pair, _ in difference)}
            unseen = set(active)
            while unseen:
                start = min(unseen)
                cycle = [start]
                color = 'short'
                while True:
                    next_vertex = mate(matching if color == 'short' else reference, cycle[-1])
                    if next_vertex == start:
                        break
                    assert next_vertex not in cycle
                    cycle.append(next_vertex)
                    color = 'long' if color == 'short' else 'short'
                assert len(cycle) % 2 == 0
                half = len(cycle) // 2
                projected = [cycle[2 * r] for r in range(half)] + [cycle[0]]
                for r in range(half):
                    odd = cycle[2 * r + 1]
                    assert projected[r + 1] == reversal(odd)
                    assert frozenset((odd, projected[r + 1])) in reference
                assert projected[half] == projected[0]
                unseen.difference_update(cycle)

print('RESULT: PASS; projected edge sequence closes for all tagged matchings on 2,4,6 vertices')
