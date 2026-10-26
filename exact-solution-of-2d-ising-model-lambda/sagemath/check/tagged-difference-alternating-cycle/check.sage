# 対象ラベル: claim_tagged_difference_alternating_cycle
# 有限集合の標識付き対称差から、短長交互の単純な閉路を構成する。
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
            active = {v for v in vertices if any(v in pair for pair, _ in difference)}
            seen = set()
            for start in sorted(active):
                if start in seen:
                    continue
                cycle = [start]
                color = 'short'
                while True:
                    nxt = mate(matching if color == 'short' else reference, cycle[-1])
                    if nxt == start:
                        break
                    assert nxt not in cycle
                    cycle.append(nxt)
                    color = 'long' if color == 'short' else 'short'
                assert len(cycle) >= 2 and len(cycle) % 2 == 0
                assert color == 'long'
                assert set(cycle) <= active
                for index, vertex in enumerate(cycle):
                    next_vertex = cycle[(index + 1) % len(cycle)]
                    pair = frozenset((vertex, next_vertex))
                    label = 'short' if index % 2 == 0 else 'long'
                    assert (pair, label) in difference
                seen.update(cycle)
            assert seen == active

print('RESULT: PASS; alternating cycles are simple, closed, and label preserving')
