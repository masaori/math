target = NN(118)
actual = Set((a, target // a) for a in divisors(target))
expected = Set([(1, 118), (2, 59), (59, 2), (118, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 118 are complete")
