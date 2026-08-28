degree_pairs = [
    (NN(3), NN(112)),
    (NN(4), NN(57)),
    (NN(7), NN(24)),
    (NN(12), NN(13)),
    (NN(13), NN(12)),
    (NN(24), NN(7)),
    (NN(57), NN(4)),
    (NN(112), NN(3)),
]

for p, q in degree_pairs:
    assert NN(2) * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
