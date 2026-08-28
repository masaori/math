factor_pairs = [
    (NN(1), NN(110)),
    (NN(2), NN(55)),
    (NN(5), NN(22)),
    (NN(10), NN(11)),
    (NN(11), NN(10)),
    (NN(22), NN(5)),
    (NN(55), NN(2)),
    (NN(110), NN(1)),
]
actual = {(a + NN(2), b + NN(2)) for a, b in factor_pairs}
expected = {
    (NN(3), NN(112)),
    (NN(4), NN(57)),
    (NN(7), NN(24)),
    (NN(12), NN(13)),
    (NN(13), NN(12)),
    (NN(24), NN(7)),
    (NN(57), NN(4)),
    (NN(112), NN(3)),
}

assert actual == expected
print("PASS: adding two recovers exactly the classified degree pairs")
