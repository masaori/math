degree_pairs = [
    (NN(3), NN(120)),
    (NN(4), NN(61)),
    (NN(61), NN(4)),
    (NN(120), NN(3)),
]

for p, q in degree_pairs:
    assert NN(2) * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
