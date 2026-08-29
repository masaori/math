degree_pairs = [
    (NN(3), NN(128)), (NN(4), NN(65)), (NN(5), NN(44)),
    (NN(8), NN(23)), (NN(9), NN(20)), (NN(11), NN(16)),
    (NN(16), NN(11)), (NN(20), NN(9)), (NN(23), NN(8)),
    (NN(44), NN(5)), (NN(65), NN(4)), (NN(128), NN(3)),
]

for p, q in degree_pairs:
    assert NN(2) * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
