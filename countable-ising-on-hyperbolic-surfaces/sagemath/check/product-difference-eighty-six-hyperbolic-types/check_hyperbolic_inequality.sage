degree_pairs = [
    (3, 88), (4, 45), (45, 4), (88, 3),
]

for p, q in degree_pairs:
    p = NN(p)
    q = NN(q)
    assert 2 * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
