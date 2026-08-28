factor_pairs = [
    (NN(1), NN(117)),
    (NN(3), NN(39)),
    (NN(9), NN(13)),
    (NN(13), NN(9)),
    (NN(39), NN(3)),
    (NN(117), NN(1)),
]
expected = [
    (NN(3), NN(119)),
    (NN(5), NN(41)),
    (NN(11), NN(15)),
    (NN(15), NN(11)),
    (NN(41), NN(5)),
    (NN(119), NN(3)),
]

actual = [(a + NN(2), b + NN(2)) for a, b in factor_pairs]
assert actual == expected
print("PASS: adding two recovers exactly the classified degree pairs")
