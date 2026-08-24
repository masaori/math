degree_pairs = [(3, 29), (5, 11), (11, 5), (29, 3)]

for p, q in degree_pairs:
    assert p >= 3
    assert q >= 3
    assert QQ(1) / p + QQ(1) / q < QQ(1) / 2

print("PASS: every recovered degree pair satisfies the hyperbolic inequality")
