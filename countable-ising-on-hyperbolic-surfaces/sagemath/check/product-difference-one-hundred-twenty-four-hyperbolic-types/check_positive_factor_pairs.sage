target = NN(124)
actual = Set((a, target // a) for a in divisors(target))
expected = Set([(1, 124), (2, 62), (4, 31), (31, 4), (62, 2), (124, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 124 are complete")
