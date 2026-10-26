# 対象ラベル: claim_tagged_difference_orbit_separation
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
            tagged = {(pair, "short" if pair in short else "long") for pair in matching}
            difference = tagged.symmetric_difference({(pair, "long") for pair in reference})
            active = {v for v in vertices if any(v in pair for pair, _ in difference)}
            step = lambda v: mate(reference, mate(matching, v))
            for start in active:
                orbit = set()
                value = start
                while value not in orbit:
                    orbit.add(value)
                    value = step(value)
                assert value == start
                other = set()
                value = mate(matching, start)
                while value not in other:
                    other.add(value)
                    value = step(value)
                assert value == mate(matching, start)
                assert orbit.isdisjoint(other)

print("RESULT: PASS; alternating two-step orbits are disjoint")
