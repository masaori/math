degree_pairs = [(3, 100), (4, 51), (9, 16), (16, 9), (51, 4), (100, 3)]

for p, q in degree_pairs:
    p = NN(p)
    q = NN(q)
    assert 2 * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
