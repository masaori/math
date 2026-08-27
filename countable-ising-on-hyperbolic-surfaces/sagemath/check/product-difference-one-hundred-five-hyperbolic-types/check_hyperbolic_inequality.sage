degree_pairs = [(3, 107), (5, 37), (7, 23), (9, 17), (17, 9), (23, 7), (37, 5), (107, 3)]

for p, q in degree_pairs:
    p = NN(p)
    q = NN(q)
    assert 2 * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
