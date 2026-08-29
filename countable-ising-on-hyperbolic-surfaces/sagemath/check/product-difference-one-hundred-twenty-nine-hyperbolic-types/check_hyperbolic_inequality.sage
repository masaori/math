degree_pairs = [
    (NN(3), NN(131)), (NN(5), NN(45)), (NN(45), NN(5)), (NN(131), NN(3)),
]

for p, q in degree_pairs:
    assert NN(2) * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
