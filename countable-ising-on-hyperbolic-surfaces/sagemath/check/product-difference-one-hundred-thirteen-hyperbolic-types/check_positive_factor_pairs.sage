target = NN(113)
actual = Set([(a, target // a) for a in divisors(target)])
expected = Set([(1, 113), (113, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 113 are complete")
