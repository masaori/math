degree_pairs = [(NN(3), NN(76)), (NN(4), NN(39)), (NN(39), NN(4)), (NN(76), NN(3))]

for p, q in degree_pairs:
    assert NN(3) <= p
    assert NN(3) <= q
    assert NN(2) * (p + q) < p * q

print("PASS: every recovered degree pair satisfies the natural-number hyperbolic inequality")
