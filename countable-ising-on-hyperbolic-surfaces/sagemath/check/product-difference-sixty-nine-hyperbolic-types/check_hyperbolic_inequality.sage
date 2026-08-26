degree_pairs = [(NN(3), NN(71)), (NN(5), NN(25)),
                (NN(25), NN(5)), (NN(71), NN(3))]

for p, q in degree_pairs:
    assert NN(3) <= p
    assert NN(3) <= q
    assert NN(2) * (p + q) < p * q

print("PASS: every recovered degree pair satisfies the natural-number hyperbolic inequality")
