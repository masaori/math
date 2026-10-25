# 対象ラベル: claim_tagged_symmetric_difference_active_vertices
from itertools import combinations


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
            for vertex in vertices:
                active = any(vertex in pair for pair, _ in difference)
                belongs_to_short = any(vertex in pair for pair in short)
                assert active == belongs_to_short

# 辺長一では同じ二元集合の二つの標識を別々に残す。
parallel = frozenset((0, 1))
assert {(parallel, "short")}.symmetric_difference({(parallel, "long")}) == {
    (parallel, "short"), (parallel, "long")}

print("RESULT: PASS; active vertices agree with short-pair endpoints")
