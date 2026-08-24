degree_pairs = [
    (NN(3), NN(32)),
    (NN(4), NN(17)),
    (NN(5), NN(12)),
    (NN(7), NN(8)),
    (NN(8), NN(7)),
    (NN(12), NN(5)),
    (NN(17), NN(4)),
    (NN(32), NN(3)),
]

for p, q in degree_pairs:
    assert NN(3) <= p
    assert NN(3) <= q
    assert NN(2) * (p + q) < p * q

print("PASS: every recovered degree pair satisfies the natural-number hyperbolic inequality")
