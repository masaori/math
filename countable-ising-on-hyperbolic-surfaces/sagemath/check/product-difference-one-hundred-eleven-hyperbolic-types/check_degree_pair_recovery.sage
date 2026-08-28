factor_pairs = [
    (NN(1), NN(111)),
    (NN(3), NN(37)),
    (NN(37), NN(3)),
    (NN(111), NN(1)),
]
actual = {(a + NN(2), b + NN(2)) for a, b in factor_pairs}
expected = {
    (NN(3), NN(113)),
    (NN(5), NN(39)),
    (NN(39), NN(5)),
    (NN(113), NN(3)),
}

assert actual == expected
print("PASS: adding two recovers exactly the classified degree pairs")
