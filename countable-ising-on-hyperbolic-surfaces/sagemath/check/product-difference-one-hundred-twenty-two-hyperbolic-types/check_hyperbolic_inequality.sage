degree_pairs = [
    (NN(3), NN(124)),
    (NN(4), NN(63)),
    (NN(63), NN(4)),
    (NN(124), NN(3)),
]

for p, q in degree_pairs:
    assert NN(2) * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
