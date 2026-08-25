degree_pairs = [(NN(3), NN(54)), (NN(4), NN(28)), (NN(6), NN(15)), (NN(15), NN(6)), (NN(28), NN(4)), (NN(54), NN(3))]

for p, q in degree_pairs:
    assert NN(3) <= p
    assert NN(3) <= q
    assert NN(2) * (p + q) < p * q

print("PASS: every recovered degree pair satisfies the natural-number hyperbolic inequality")
