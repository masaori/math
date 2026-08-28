factor_pairs = [
    (NN(1), NN(116)),
    (NN(2), NN(58)),
    (NN(4), NN(29)),
    (NN(29), NN(4)),
    (NN(58), NN(2)),
    (NN(116), NN(1)),
]
expected = [
    (NN(3), NN(118)),
    (NN(4), NN(60)),
    (NN(6), NN(31)),
    (NN(31), NN(6)),
    (NN(60), NN(4)),
    (NN(118), NN(3)),
]

actual = [(a + NN(2), b + NN(2)) for a, b in factor_pairs]
assert actual == expected
print("PASS: adding two recovers exactly the classified degree pairs")
