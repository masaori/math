degree_pairs = [(NN(3), NN(108)), (NN(4), NN(55)), (NN(55), NN(4)), (NN(108), NN(3))]

for p, q in degree_pairs:
    assert NN(2) * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
