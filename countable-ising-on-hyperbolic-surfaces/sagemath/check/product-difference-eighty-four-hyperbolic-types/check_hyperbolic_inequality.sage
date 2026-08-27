degree_pairs = [
    (3, 86), (4, 44), (5, 30), (6, 23), (8, 16), (9, 14),
    (14, 9), (16, 8), (23, 6), (30, 5), (44, 4), (86, 3),
]

for p, q in degree_pairs:
    p = NN(p)
    q = NN(q)
    assert 2 * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
