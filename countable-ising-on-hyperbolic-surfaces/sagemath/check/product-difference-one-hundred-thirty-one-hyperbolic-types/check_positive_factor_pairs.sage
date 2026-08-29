target = NN(131)
actual = Set((a, target // a) for a in divisors(target))
expected = Set([(1, 131), (131, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 131 are complete")
