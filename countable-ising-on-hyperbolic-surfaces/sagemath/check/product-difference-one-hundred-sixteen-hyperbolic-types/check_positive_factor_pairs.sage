target = NN(116)
actual = Set((a, target // a) for a in divisors(target))
expected = Set([(1, 116), (2, 58), (4, 29), (29, 4), (58, 2), (116, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 116 are complete")
