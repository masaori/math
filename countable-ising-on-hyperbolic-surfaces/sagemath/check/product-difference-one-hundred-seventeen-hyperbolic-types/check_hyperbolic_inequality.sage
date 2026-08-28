degree_pairs = [
    (NN(3), NN(119)),
    (NN(5), NN(41)),
    (NN(11), NN(15)),
    (NN(15), NN(11)),
    (NN(41), NN(5)),
    (NN(119), NN(3)),
]

for p, q in degree_pairs:
    assert NN(2) * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
