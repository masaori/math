degree_pairs = [
    (NN(3), NN(38)),
    (NN(4), NN(20)),
    (NN(5), NN(14)),
    (NN(6), NN(11)),
    (NN(8), NN(8)),
    (NN(11), NN(6)),
    (NN(14), NN(5)),
    (NN(20), NN(4)),
    (NN(38), NN(3)),
]

for p, q in degree_pairs:
    assert NN(3) <= p
    assert NN(3) <= q
    assert NN(2) * (p + q) < p * q

print("PASS: every recovered degree pair satisfies the natural-number hyperbolic inequality")
