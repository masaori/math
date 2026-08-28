degree_pairs = [
    (NN(3), NN(126)),
    (NN(4), NN(64)),
    (NN(6), NN(33)),
    (NN(33), NN(6)),
    (NN(64), NN(4)),
    (NN(126), NN(3)),
]

for p, q in degree_pairs:
    assert NN(2) * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
