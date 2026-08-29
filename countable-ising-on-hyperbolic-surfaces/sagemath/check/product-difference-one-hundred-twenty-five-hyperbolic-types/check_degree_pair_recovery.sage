factor_pairs = [
    (NN(1), NN(125)),
    (NN(5), NN(25)),
    (NN(25), NN(5)),
    (NN(125), NN(1)),
]
expected = [
    (NN(3), NN(127)),
    (NN(7), NN(27)),
    (NN(27), NN(7)),
    (NN(127), NN(3)),
]

actual = [(a + NN(2), b + NN(2)) for a, b in factor_pairs]
assert actual == expected
print("PASS: adding two recovers exactly the classified degree pairs")
