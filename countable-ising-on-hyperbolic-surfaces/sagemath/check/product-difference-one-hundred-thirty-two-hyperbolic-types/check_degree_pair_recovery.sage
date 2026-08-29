factor_pairs = [
    (NN(1), NN(132)), (NN(2), NN(66)), (NN(3), NN(44)), (NN(4), NN(33)),
    (NN(6), NN(22)), (NN(11), NN(12)), (NN(12), NN(11)), (NN(22), NN(6)),
    (NN(33), NN(4)), (NN(44), NN(3)), (NN(66), NN(2)), (NN(132), NN(1)),
]
actual = {(a + NN(2), b + NN(2)) for a, b in factor_pairs}
expected = {
    (NN(3), NN(134)), (NN(4), NN(68)), (NN(5), NN(46)), (NN(6), NN(35)),
    (NN(8), NN(24)), (NN(13), NN(14)), (NN(14), NN(13)), (NN(24), NN(8)),
    (NN(35), NN(6)), (NN(46), NN(5)), (NN(68), NN(4)), (NN(134), NN(3)),
}

assert actual == expected
print("PASS: adding two recovers exactly the classified degree pairs")
