degree_pairs = [(NN(3), NN(50)), (NN(4), NN(26)), (NN(5), NN(18)), (NN(6), NN(14)), (NN(8), NN(10)), (NN(10), NN(8)), (NN(14), NN(6)), (NN(18), NN(5)), (NN(26), NN(4)), (NN(50), NN(3))]

for p, q in degree_pairs:
    assert NN(3) <= p
    assert NN(3) <= q
    assert NN(2) * (p + q) < p * q

print("PASS: every recovered degree pair satisfies the natural-number hyperbolic inequality")
