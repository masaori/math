degree_pairs = [
    (NN(3), NN(114)),
    (NN(4), NN(58)),
    (NN(6), NN(30)),
    (NN(9), NN(18)),
    (NN(10), NN(16)),
    (NN(16), NN(10)),
    (NN(18), NN(9)),
    (NN(30), NN(6)),
    (NN(58), NN(4)),
    (NN(114), NN(3)),
]

for p, q in degree_pairs:
    assert NN(2) * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
