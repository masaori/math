degree_pairs = [
    (NN(3), NN(121)),
    (NN(9), NN(19)),
    (NN(19), NN(9)),
    (NN(121), NN(3)),
]

for p, q in degree_pairs:
    assert NN(2) * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
