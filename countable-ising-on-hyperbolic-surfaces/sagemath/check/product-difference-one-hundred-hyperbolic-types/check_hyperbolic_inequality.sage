degree_pairs = [(3, 102), (4, 52), (6, 27), (7, 22), (12, 12), (22, 7), (27, 6), (52, 4), (102, 3)]

for p, q in degree_pairs:
    p = NN(p)
    q = NN(q)
    assert 2 * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
