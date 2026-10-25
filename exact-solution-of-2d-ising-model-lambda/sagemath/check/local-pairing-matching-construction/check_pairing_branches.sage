# 対象ラベル: claim_local_pairing_matching_construction
# 帰属: 有限集合と自然数だけ。実数・浮動小数点は使わない。
from itertools import combinations


def pairings(items):
    if not items:
        yield {}
        return
    first = items[0]
    for other in items[1:]:
        rest = [item for item in items[1:] if item != other]
        for pairing in pairings(rest):
            yield {first: other, other: first, **pairing}


checked = 0
for L in (1, 2, 3):
    edges = tuple(range(2 * L * L))
    oriented = tuple((e, d) for e in edges for d in (0, 1))
    # The branch proof is independent of lattice incidence.  Check every P
    # containing at most two edges and every pairing of its endpoints.
    for size in range(min(2, len(edges)) + 1):
        for chosen in combinations(edges, size):
            selected = set(chosen)
            active = tuple(h for h in oriented if h[0] in selected)
            for local in pairings(active):
                def tau(h):
                    return local[h] if h[0] in selected else (h[0], 1 - h[1])

                assert all(tau(h) != h for h in oriented)
                assert all(tau(tau(h)) == h for h in oriented)
                matching = {frozenset((h, tau(h))) for h in oriented}
                assert all(len(pair) == 2 for pair in matching)
                assert all(sum(h in pair for pair in matching) == 1 for h in oriented)
                assert all(next(iter(pair - {h})) == tau(h)
                           for h in oriented for pair in matching if h in pair)
                checked += 1

print("RESULT: PASS; %d exact local-pairing cases" % checked)
