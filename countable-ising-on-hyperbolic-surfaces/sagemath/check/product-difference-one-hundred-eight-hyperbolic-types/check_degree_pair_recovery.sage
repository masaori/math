factor_pairs = [
    (NN(1), NN(108)), (NN(2), NN(54)), (NN(3), NN(36)),
    (NN(4), NN(27)), (NN(6), NN(18)), (NN(9), NN(12)),
    (NN(12), NN(9)), (NN(18), NN(6)), (NN(27), NN(4)),
    (NN(36), NN(3)), (NN(54), NN(2)), (NN(108), NN(1)),
]
actual = {(a + NN(2), b + NN(2)) for a, b in factor_pairs}
expected = {
    (NN(3), NN(110)), (NN(4), NN(56)), (NN(5), NN(38)),
    (NN(6), NN(29)), (NN(8), NN(20)), (NN(11), NN(14)),
    (NN(14), NN(11)), (NN(20), NN(8)), (NN(29), NN(6)),
    (NN(38), NN(5)), (NN(56), NN(4)), (NN(110), NN(3)),
}

assert actual == expected
print("PASS: adding two recovers exactly the classified degree pairs")
