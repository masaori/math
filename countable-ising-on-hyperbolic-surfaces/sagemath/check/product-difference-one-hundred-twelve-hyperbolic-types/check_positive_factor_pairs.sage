target = NN(112)
actual = Set([(a, target // a) for a in divisors(target)])
expected = Set([(1, 112), (2, 56), (4, 28), (7, 16), (8, 14), (14, 8), (16, 7), (28, 4), (56, 2), (112, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 112 are complete")
