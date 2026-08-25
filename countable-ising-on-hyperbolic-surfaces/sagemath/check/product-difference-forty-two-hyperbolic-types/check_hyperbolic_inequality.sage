degree_pairs = [(NN(3), NN(44)), (NN(4), NN(23)), (NN(5), NN(16)), (NN(8), NN(9)), (NN(9), NN(8)), (NN(16), NN(5)), (NN(23), NN(4)), (NN(44), NN(3))]

for p, q in degree_pairs:
    assert NN(3) <= p
    assert NN(3) <= q
    assert NN(2) * (p + q) < p * q

print("PASS: every recovered degree pair satisfies the natural-number hyperbolic inequality")
