degree_pairs = [
    (NN(3), NN(122)), (NN(4), NN(62)), (NN(5), NN(42)), (NN(6), NN(32)),
    (NN(7), NN(26)), (NN(8), NN(22)), (NN(10), NN(17)), (NN(12), NN(14)),
    (NN(14), NN(12)), (NN(17), NN(10)), (NN(22), NN(8)), (NN(26), NN(7)),
    (NN(32), NN(6)), (NN(42), NN(5)), (NN(62), NN(4)), (NN(122), NN(3)),
]

for p, q in degree_pairs:
    assert NN(2) * (p + q) < p * q

print("PASS: every classified degree pair satisfies the hyperbolic inequality")
