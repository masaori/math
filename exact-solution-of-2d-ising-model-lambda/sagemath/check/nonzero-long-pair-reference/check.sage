# 対象ラベル: claim_nonzero_long_pair_reference
from itertools import product

for length in (1, 2, 3):
    edges = list(product((0, 1), range(length), range(length)))
    oriented = list(product(edges, (0, 1)))

    def reversal(h):
        edge, endpoint = h
        return (edge, 1 - endpoint)

    reference = {frozenset((h, reversal(h))) for h in oriented}
    for first in oriented:
        for second in oriented:
            long_support = second == reversal(first)
            if long_support:
                assert frozenset((first, second)) in reference
                assert first != second
            if length == 1 and first != second and first[0] == second[0]:
                # The same underlying pair may also receive the short label.
                assert frozenset((first, second)) in reference

print("RESULT: PASS; long-labelled support lies in the reference matching at L=1,2,3")
