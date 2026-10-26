# 対象ラベル: claim_tagged_difference_two_step_orbit
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
    reference_tagged = {(pair, "long") for pair in reference}
    for matching in matchings(vertices):
        pairs = tuple(matching)
        for choice in range(1 << len(pairs)):
            short = {pair for bit, pair in enumerate(pairs) if choice & (1 << bit)}
            if any(pair not in reference for pair in matching - short):
                continue
            tagged = {(pair, "short" if pair in short else "long")
                      for pair in matching}
            difference = tagged.symmetric_difference(reference_tagged)
            active = {v for v in vertices
                      if any(v in pair for pair, _ in difference)}
            two_step = {v: mate(reference, mate(matching, v)) for v in active}
            assert set(two_step.values()) == active
            assert len(set(two_step.values())) == len(active)
            for start in active:
                value = start
                for period in range(1, len(active) + 1):
                    value = two_step[value]
                    if value == start:
                        break
                else:
                    raise AssertionError("no positive return")

parallel = frozenset((0, 1))
assert {(parallel, "short")}.symmetric_difference({(parallel, "long")}) == {
    (parallel, "short"), (parallel, "long")}
assert mate({parallel}, mate({parallel}, 0)) == 0

print("RESULT: PASS; two-step map is a permutation with positive returns")
