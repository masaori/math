factor_pairs = [(NN(1), NN(131)), (NN(131), NN(1))]
actual = {(a + NN(2), b + NN(2)) for a, b in factor_pairs}
expected = {(NN(3), NN(133)), (NN(133), NN(3))}

assert actual == expected
print("PASS: adding two recovers exactly the classified degree pairs")
