target = NN(114)
actual = Set((a, target // a) for a in divisors(target))
expected = Set([(1, 114), (2, 57), (3, 38), (6, 19), (19, 6), (38, 3), (57, 2), (114, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 114 are complete")
