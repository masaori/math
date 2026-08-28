factor_pairs = [
    (NN(1), NN(121)),
    (NN(11), NN(11)),
    (NN(121), NN(1)),
]
expected = [
    (NN(3), NN(123)),
    (NN(13), NN(13)),
    (NN(123), NN(3)),
]

actual = [(a + NN(2), b + NN(2)) for a, b in factor_pairs]
assert actual == expected
print("PASS: adding two recovers exactly the classified degree pairs")
