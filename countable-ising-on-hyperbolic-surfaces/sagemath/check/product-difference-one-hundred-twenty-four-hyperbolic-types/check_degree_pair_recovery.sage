factor_pairs = [
    (NN(1), NN(124)),
    (NN(2), NN(62)),
    (NN(4), NN(31)),
    (NN(31), NN(4)),
    (NN(62), NN(2)),
    (NN(124), NN(1)),
]
expected = [
    (NN(3), NN(126)),
    (NN(4), NN(64)),
    (NN(6), NN(33)),
    (NN(33), NN(6)),
    (NN(64), NN(4)),
    (NN(126), NN(3)),
]

actual = [(a + NN(2), b + NN(2)) for a, b in factor_pairs]
assert actual == expected
print("PASS: adding two recovers exactly the classified degree pairs")
