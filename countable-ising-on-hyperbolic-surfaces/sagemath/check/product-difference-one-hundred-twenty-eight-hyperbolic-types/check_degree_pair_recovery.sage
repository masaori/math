factor_pairs = [
    (NN(1), NN(128)), (NN(2), NN(64)), (NN(4), NN(32)), (NN(8), NN(16)),
    (NN(16), NN(8)), (NN(32), NN(4)), (NN(64), NN(2)), (NN(128), NN(1)),
]
actual = {(a + NN(2), b + NN(2)) for a, b in factor_pairs}
expected = {
    (NN(3), NN(130)), (NN(4), NN(66)), (NN(6), NN(34)), (NN(10), NN(18)),
    (NN(18), NN(10)), (NN(34), NN(6)), (NN(66), NN(4)), (NN(130), NN(3)),
}

assert actual == expected
print("PASS: adding two recovers exactly the classified degree pairs")
