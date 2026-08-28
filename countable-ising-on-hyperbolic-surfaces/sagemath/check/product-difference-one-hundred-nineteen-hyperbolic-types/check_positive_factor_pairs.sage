target = NN(119)
actual = Set((a, target // a) for a in divisors(target))
expected = Set([(1, 119), (7, 17), (17, 7), (119, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 119 are complete")
