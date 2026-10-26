# 対象ラベル: claim_tagged_complement_active_vertices
# 基準マッチング・長短の標識・対称差を有限集合として厳密に照合する。
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


tested = 0
for size in (2, 4, 6):
    vertices = tuple(range(size))
    reference = frozenset(frozenset((i, i + 1)) for i in range(0, size, 2))
    supports = set(range(size // 2))
    for matching in matchings(vertices):
        pairs = tuple(matching)
        for count in range(len(pairs) + 1):
            for choice in combinations(pairs, count):
                short = frozenset(choice)
                long = matching - short
                if any(pair not in reference for pair in long):
                    continue
                complement = supports - {next(iter(pair)) // 2 for pair in long}
                tagged = {(pair, pair in short) for pair in matching}
                tagged_reference = {(pair, False) for pair in reference}
                difference = tagged.symmetric_difference(tagged_reference)
                active = {vertex for pair, _ in difference for vertex in pair}
                assert active == {vertex for vertex in vertices if vertex // 2 in complement}
                tested += 1

assert tested > 0
print(f"RESULT: PASS; {tested} labelled matchings")
