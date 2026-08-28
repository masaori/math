factor_pairs = [
    (NN(1), NN(112)),
    (NN(2), NN(56)),
    (NN(4), NN(28)),
    (NN(7), NN(16)),
    (NN(8), NN(14)),
    (NN(14), NN(8)),
    (NN(16), NN(7)),
    (NN(28), NN(4)),
    (NN(56), NN(2)),
    (NN(112), NN(1)),
]
actual = {(a + NN(2), b + NN(2)) for a, b in factor_pairs}
expected = {
    (NN(3), NN(114)),
    (NN(4), NN(58)),
    (NN(6), NN(30)),
    (NN(9), NN(18)),
    (NN(10), NN(16)),
    (NN(16), NN(10)),
    (NN(18), NN(9)),
    (NN(30), NN(6)),
    (NN(58), NN(4)),
    (NN(114), NN(3)),
}

assert actual == expected
print("PASS: adding two recovers exactly the classified degree pairs")
