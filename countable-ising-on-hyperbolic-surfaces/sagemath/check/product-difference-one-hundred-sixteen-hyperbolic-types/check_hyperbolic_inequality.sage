degree_pairs = [
    (NN(3), NN(118)),
    (NN(4), NN(60)),
    (NN(6), NN(31)),
    (NN(31), NN(6)),
    (NN(60), NN(4)),
    (NN(118), NN(3)),
]

for p, q in degree_pairs:
    assert NN(2) * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
