factor_pairs = [
    (NN(1), NN(126)), (NN(2), NN(63)), (NN(3), NN(42)),
    (NN(6), NN(21)), (NN(7), NN(18)), (NN(9), NN(14)),
    (NN(14), NN(9)), (NN(18), NN(7)), (NN(21), NN(6)),
    (NN(42), NN(3)), (NN(63), NN(2)), (NN(126), NN(1)),
]
expected = [
    (NN(3), NN(128)), (NN(4), NN(65)), (NN(5), NN(44)),
    (NN(8), NN(23)), (NN(9), NN(20)), (NN(11), NN(16)),
    (NN(16), NN(11)), (NN(20), NN(9)), (NN(23), NN(8)),
    (NN(44), NN(5)), (NN(65), NN(4)), (NN(128), NN(3)),
]

actual = [(a + NN(2), b + NN(2)) for a, b in factor_pairs]
assert actual == expected
print("PASS: adding two recovers exactly the classified degree pairs")
