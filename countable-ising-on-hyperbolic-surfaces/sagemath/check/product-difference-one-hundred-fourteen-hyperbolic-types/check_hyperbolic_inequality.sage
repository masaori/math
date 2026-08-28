degree_pairs = [
    (NN(3), NN(116)),
    (NN(4), NN(59)),
    (NN(5), NN(40)),
    (NN(8), NN(21)),
    (NN(21), NN(8)),
    (NN(40), NN(5)),
    (NN(59), NN(4)),
    (NN(116), NN(3)),
]

for p, q in degree_pairs:
    assert NN(2) * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
