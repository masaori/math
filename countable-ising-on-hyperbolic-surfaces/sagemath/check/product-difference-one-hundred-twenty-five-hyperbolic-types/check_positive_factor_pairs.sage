target = NN(125)
actual = Set((a, target // a) for a in divisors(target))
expected = Set([(1, 125), (5, 25), (25, 5), (125, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 125 are complete")
