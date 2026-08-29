degree_pairs = [
    (NN(3), NN(130)), (NN(4), NN(66)), (NN(6), NN(34)), (NN(10), NN(18)),
    (NN(18), NN(10)), (NN(34), NN(6)), (NN(66), NN(4)), (NN(130), NN(3)),
]

for p, q in degree_pairs:
    assert NN(2) * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
