degree_pairs = [(3, 101), (5, 35), (11, 13), (13, 11), (35, 5), (101, 3)]

for p, q in degree_pairs:
    p = NN(p)
    q = NN(q)
    assert 2 * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
