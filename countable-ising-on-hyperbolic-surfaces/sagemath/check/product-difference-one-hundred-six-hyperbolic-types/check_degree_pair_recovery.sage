factor_pairs = [(NN(1), NN(106)), (NN(2), NN(53)), (NN(53), NN(2)), (NN(106), NN(1))]
actual = {(a + NN(2), b + NN(2)) for a, b in factor_pairs}
expected = {(NN(3), NN(108)), (NN(4), NN(55)), (NN(55), NN(4)), (NN(108), NN(3))}

assert actual == expected
print("PASS: adding two recovers exactly the classified degree pairs")
