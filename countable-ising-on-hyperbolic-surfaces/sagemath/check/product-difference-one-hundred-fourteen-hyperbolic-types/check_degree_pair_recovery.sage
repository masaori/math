factor_pairs = [
    (NN(1), NN(114)),
    (NN(2), NN(57)),
    (NN(3), NN(38)),
    (NN(6), NN(19)),
    (NN(19), NN(6)),
    (NN(38), NN(3)),
    (NN(57), NN(2)),
    (NN(114), NN(1)),
]
expected = [
    (NN(3), NN(116)),
    (NN(4), NN(59)),
    (NN(5), NN(40)),
    (NN(8), NN(21)),
    (NN(21), NN(8)),
    (NN(40), NN(5)),
    (NN(59), NN(4)),
    (NN(116), NN(3)),
]

actual = [(a + NN(2), b + NN(2)) for a, b in factor_pairs]
assert actual == expected
print("PASS: adding two recovers exactly the classified degree pairs")
