degree_pairs = [(3, 106), (4, 54), (6, 28), (10, 15), (15, 10), (28, 6), (54, 4), (106, 3)]

for p, q in degree_pairs:
    p = NN(p)
    q = NN(q)
    assert 2 * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
