factor_pairs = [
    (NN(1), NN(130)), (NN(2), NN(65)), (NN(5), NN(26)), (NN(10), NN(13)),
    (NN(13), NN(10)), (NN(26), NN(5)), (NN(65), NN(2)), (NN(130), NN(1)),
]
actual = {(a + NN(2), b + NN(2)) for a, b in factor_pairs}
expected = {
    (NN(3), NN(132)), (NN(4), NN(67)), (NN(7), NN(28)), (NN(12), NN(15)),
    (NN(15), NN(12)), (NN(28), NN(7)), (NN(67), NN(4)), (NN(132), NN(3)),
}

assert actual == expected
print("PASS: adding two recovers exactly the classified degree pairs")
