target = NN(122)
actual = Set((a, target // a) for a in divisors(target))
expected = Set([(1, 122), (2, 61), (61, 2), (122, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 122 are complete")
