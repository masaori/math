degree_pairs = [(3, 104), (4, 53), (5, 36), (8, 19), (19, 8), (36, 5), (53, 4), (104, 3)]

for p, q in degree_pairs:
    p = NN(p)
    q = NN(q)
    assert 2 * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
