degree_pairs = [
    (NN(3), NN(110)), (NN(4), NN(56)), (NN(5), NN(38)),
    (NN(6), NN(29)), (NN(8), NN(20)), (NN(11), NN(14)),
    (NN(14), NN(11)), (NN(20), NN(8)), (NN(29), NN(6)),
    (NN(38), NN(5)), (NN(56), NN(4)), (NN(110), NN(3)),
]

for p, q in degree_pairs:
    assert NN(2) * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
