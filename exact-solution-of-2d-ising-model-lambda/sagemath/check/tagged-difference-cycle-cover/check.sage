# 対象ラベル: claim_tagged_difference_cycle_cover
# 標識を保った対称差の活動点と対を、交互閉路で一度ずつ覆う。
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
    reference = frozenset(frozenset((k, k + 1)) for k in range(0, size, 2))
    for matching in matchings(vertices):
        pairs = tuple(matching)
        for choice in range(1 << len(pairs)):
            short = {pair for bit, pair in enumerate(pairs) if choice & (1 << bit)}
            if any(pair not in reference for pair in matching - short):
                continue
            tagged = {(pair, 'short' if pair in short else 'long') for pair in matching}
            difference = tagged.symmetric_difference({(pair, 'long') for pair in reference})
            active = {v for pair, _ in difference for v in pair}
            cycles = []
            unseen = set(active)
            while unseen:
                start = min(unseen)
                cycle = [start]
                step = 0
                while True:
                    current = cycle[-1]
                    nxt = mate(matching if step % 2 == 0 else reference, current)
                    if nxt == start:
                        break
                    assert nxt not in cycle
                    cycle.append(nxt)
                    step += 1
                assert len(cycle) % 2 == 0
                edges = {(frozenset((cycle[k], cycle[(k + 1) % len(cycle)])),
                          'short' if k % 2 == 0 else 'long')
                         for k in range(len(cycle))}
                assert edges <= difference
                cycles.append((set(cycle), edges))
                unseen.difference_update(cycle)
            assert set().union(*(points for points, _ in cycles)) == active
            assert sum(len(points) for points, _ in cycles) == len(active)
            assert set().union(*(edges for _, edges in cycles)) == difference
            assert sum(len(edges) for _, edges in cycles) == len(difference)

print('RESULT: PASS; tagged pairs and active vertices have unique alternating cycles')
