target = NN(106)
actual = Set([(a, target // a) for a in divisors(target)])
expected = Set([(1, 106), (2, 53), (53, 2), (106, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 106 are complete")
