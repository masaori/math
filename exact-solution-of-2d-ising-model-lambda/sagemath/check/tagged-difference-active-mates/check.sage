# 対象ラベル: claim_tagged_difference_active_mates
def matchings(vertices):
    if not vertices:
        yield frozenset()
        return
    first = vertices[0]
    for partner in vertices[1:]:
        rest = tuple(v for v in vertices if v != first and v != partner)
        for tail in matchings(rest):
            yield tail | {frozenset((first, partner))}


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
            for v in active:
                dmate = next(iter(next(pair for pair in matching if v in pair) - {v}))
                rmate = next(iter(next(pair for pair in reference if v in pair) - {v}))
                assert dmate in active
                assert rmate in active

parallel = frozenset((0, 1))
assert {v for pair, _ in ({(parallel, "short")}.symmetric_difference({(parallel, "long")}))
        for v in pair} == {0, 1}

print("RESULT: PASS; both matching mates preserve active vertices, including parallel labels")
