target = NN(130)
actual = Set((a, target // a) for a in divisors(target))
expected = Set([(1, 130), (2, 65), (5, 26), (10, 13), (13, 10), (26, 5), (65, 2), (130, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 130 are complete")
