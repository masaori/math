factor_pairs = [
    (NN(1), NN(120)), (NN(2), NN(60)), (NN(3), NN(40)), (NN(4), NN(30)),
    (NN(5), NN(24)), (NN(6), NN(20)), (NN(8), NN(15)), (NN(10), NN(12)),
    (NN(12), NN(10)), (NN(15), NN(8)), (NN(20), NN(6)), (NN(24), NN(5)),
    (NN(30), NN(4)), (NN(40), NN(3)), (NN(60), NN(2)), (NN(120), NN(1)),
]
expected = [
    (NN(3), NN(122)), (NN(4), NN(62)), (NN(5), NN(42)), (NN(6), NN(32)),
    (NN(7), NN(26)), (NN(8), NN(22)), (NN(10), NN(17)), (NN(12), NN(14)),
    (NN(14), NN(12)), (NN(17), NN(10)), (NN(22), NN(8)), (NN(26), NN(7)),
    (NN(32), NN(6)), (NN(42), NN(5)), (NN(62), NN(4)), (NN(122), NN(3)),
]

actual = [(a + NN(2), b + NN(2)) for a, b in factor_pairs]
assert actual == expected
print("PASS: adding two recovers exactly the classified degree pairs")
