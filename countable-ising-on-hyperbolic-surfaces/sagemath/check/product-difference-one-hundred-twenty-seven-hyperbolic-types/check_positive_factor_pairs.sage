target = NN(127)
actual = Set((a, target // a) for a in divisors(target))
expected = Set([(1, 127), (127, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 127 are complete")
