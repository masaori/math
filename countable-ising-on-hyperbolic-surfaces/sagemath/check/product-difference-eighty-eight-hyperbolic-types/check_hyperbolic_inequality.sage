degree_pairs = [
    (3, 90), (4, 46), (6, 24), (10, 13),
    (13, 10), (24, 6), (46, 4), (90, 3),
]

for p, q in degree_pairs:
    p = NN(p)
    q = NN(q)
    assert 2 * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
