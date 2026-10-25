# 対象ラベル: claim_reference_long_matching
from itertools import product

for length in (1, 2, 3):
    edges = list(product((0, 1), range(length), range(length)))
    oriented = set(product(edges, (0, 1)))

    def reversal(h):
        edge, endpoint = h
        return (edge, 1 - endpoint)

    for h in oriented:
        assert reversal(h) != h
        assert reversal(reversal(h)) == h

    pairs = {frozenset((h, reversal(h))) for h in oriented}
    assert all(len(pair) == 2 for pair in pairs)
    assert all(sum(h in pair for pair in pairs) == 1 for h in oriented)
    assert len(pairs) == len(edges)

print("RESULT: PASS; reference reversal matching at L=1,2,3")
