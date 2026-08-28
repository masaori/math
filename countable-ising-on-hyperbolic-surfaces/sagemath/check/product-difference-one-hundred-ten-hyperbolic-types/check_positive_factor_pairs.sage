target = NN(110)
actual = Set([(a, target // a) for a in divisors(target)])
expected = Set([(1, 110), (2, 55), (5, 22), (10, 11), (11, 10), (22, 5), (55, 2), (110, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 110 are complete")
