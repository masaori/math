degree_pairs = [
    (NN(3), NN(132)), (NN(4), NN(67)), (NN(7), NN(28)), (NN(12), NN(15)),
    (NN(15), NN(12)), (NN(28), NN(7)), (NN(67), NN(4)), (NN(132), NN(3)),
]

for p, q in degree_pairs:
    assert NN(2) * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
