degree_pairs = [
    (NN(3), NN(82)), (NN(4), NN(42)), (NN(6), NN(22)),
    (NN(7), NN(18)), (NN(10), NN(12)), (NN(12), NN(10)),
    (NN(18), NN(7)), (NN(22), NN(6)), (NN(42), NN(4)),
    (NN(82), NN(3)),
]

for p, q in degree_pairs:
    assert NN(3) <= p
    assert NN(3) <= q
    assert NN(2) * (p + q) < p * q

print("PASS: every recovered degree pair satisfies the natural-number hyperbolic inequality")
