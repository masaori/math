degree_pairs = [(NN(3), NN(80)), (NN(4), NN(41)), (NN(5), NN(28)), (NN(8), NN(15)), (NN(15), NN(8)), (NN(28), NN(5)), (NN(41), NN(4)), (NN(80), NN(3))]

for p, q in degree_pairs:
    assert NN(3) <= p
    assert NN(3) <= q
    assert NN(2) * (p + q) < p * q

print("PASS: every recovered degree pair satisfies the natural-number hyperbolic inequality")
