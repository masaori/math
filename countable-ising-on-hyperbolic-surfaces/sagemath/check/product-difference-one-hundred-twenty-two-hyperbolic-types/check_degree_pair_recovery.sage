factor_pairs = [
    (NN(1), NN(122)),
    (NN(2), NN(61)),
    (NN(61), NN(2)),
    (NN(122), NN(1)),
]
expected = [
    (NN(3), NN(124)),
    (NN(4), NN(63)),
    (NN(63), NN(4)),
    (NN(124), NN(3)),
]

actual = [(a + NN(2), b + NN(2)) for a, b in factor_pairs]
assert actual == expected
print("PASS: adding two recovers exactly the classified degree pairs")
