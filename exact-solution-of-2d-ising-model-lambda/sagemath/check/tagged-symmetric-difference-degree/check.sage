# 対象ラベル: claim_tagged_symmetric_difference_degree
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
                incident = {edge for edge in difference if vertex in edge[0]}
                assert len(incident) in (0, 2)
                if incident:
                    assert {label for _, label in incident} == {"long", "short"}

# 辺長一では同じ端点対の短標識と長標識が二本として残る。
parallel = frozenset((0, 1))
assert {(parallel, "short")}.symmetric_difference({(parallel, "long")}) == {
    (parallel, "short"), (parallel, "long")}

print("RESULT: PASS; tagged local degree and parallel pair at L=1")
