# 対象ラベル: claim_reference_matching_constant_term
from itertools import product

K = CyclotomicField(8)
z = K.gen()
assert z**4 == -1

for length in (1, 2, 3):
    edges = list(product((0, 1), range(length), range(length)))
    oriented = [(edge, d) for edge in edges for d in (0, 1)]
    reference_pairs = [((edge, 0), (edge, 1)) for edge in edges]
    assert [h for pair in reference_pairs for h in pair] == oriented
    word = [h for pair in reference_pairs for h in pair]
    reference_sign = (-1)**sum(
        oriented.index(word[i]) > oriented.index(word[j])
        for i in range(len(word)) for j in range(i+1, len(word))
    )
    assert reference_sign == 1

    for a, b in product((0, 1), repeat=2):
        term = K(reference_sign)
        for edge in edges:
            axis, row, column = edge
            seam = (column == length-1) if axis == 0 else (row == length-1)
            twist = (a if axis == 0 else b) * ZZ(seam)
            r0 = axis
            r1 = axis + 2
            v0 = z**(r0+2*twist)
            u1 = z**(-r1-2*twist)
            long_weight = z**2 * v0 * u1
            assert long_weight == 1
            term *= long_weight
        assert term == 1

print("RESULT: PASS; reference matching term at L=1,2,3 and four twists")
