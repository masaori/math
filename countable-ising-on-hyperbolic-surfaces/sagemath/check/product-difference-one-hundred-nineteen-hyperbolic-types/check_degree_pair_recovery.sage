factor_pairs = [
    (NN(1), NN(119)),
    (NN(7), NN(17)),
    (NN(17), NN(7)),
    (NN(119), NN(1)),
]
expected = [
    (NN(3), NN(121)),
    (NN(9), NN(19)),
    (NN(19), NN(9)),
    (NN(121), NN(3)),
]

actual = [(a + NN(2), b + NN(2)) for a, b in factor_pairs]
assert actual == expected
print("PASS: adding two recovers exactly the classified degree pairs")
