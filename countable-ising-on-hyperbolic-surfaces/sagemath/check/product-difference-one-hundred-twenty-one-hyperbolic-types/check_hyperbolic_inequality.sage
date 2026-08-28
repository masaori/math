degree_pairs = [
    (NN(3), NN(123)),
    (NN(13), NN(13)),
    (NN(123), NN(3)),
]

for p, q in degree_pairs:
    assert NN(2) * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
