degree_pairs = [
    (NN(3), NN(134)), (NN(4), NN(68)), (NN(5), NN(46)), (NN(6), NN(35)),
    (NN(8), NN(24)), (NN(13), NN(14)), (NN(14), NN(13)), (NN(24), NN(8)),
    (NN(35), NN(6)), (NN(46), NN(5)), (NN(68), NN(4)), (NN(134), NN(3)),
]

for p, q in degree_pairs:
    assert NN(2) * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
