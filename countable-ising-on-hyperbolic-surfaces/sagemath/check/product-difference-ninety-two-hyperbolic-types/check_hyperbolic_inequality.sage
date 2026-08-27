degree_pairs = [
    (3, 94), (4, 48), (6, 25), (25, 6), (48, 4), (94, 3),
]

for p, q in degree_pairs:
    p = NN(p)
    q = NN(q)
    assert 2 * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
