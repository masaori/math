degree_pairs = [(NN(3), NN(47)), (NN(5), NN(17)), (NN(7), NN(11)), (NN(11), NN(7)), (NN(17), NN(5)), (NN(47), NN(3))]

for p, q in degree_pairs:
    assert NN(3) <= p
    assert NN(3) <= q
    assert NN(2) * (p + q) < p * q

print("PASS: every recovered degree pair satisfies the natural-number hyperbolic inequality")
