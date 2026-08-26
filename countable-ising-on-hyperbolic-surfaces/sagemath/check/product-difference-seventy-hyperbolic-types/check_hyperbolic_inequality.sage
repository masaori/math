degree_pairs = [(NN(3), NN(72)), (NN(4), NN(37)),
                (NN(7), NN(16)), (NN(9), NN(12)),
                (NN(12), NN(9)), (NN(16), NN(7)),
                (NN(37), NN(4)), (NN(72), NN(3))]

for p, q in degree_pairs:
    assert NN(3) <= p
    assert NN(3) <= q
    assert NN(2) * (p + q) < p * q

print("PASS: every recovered degree pair satisfies the natural-number hyperbolic inequality")
