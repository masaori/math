target = NN(121)
actual = Set((a, target // a) for a in divisors(target))
expected = Set([(1, 121), (11, 11), (121, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 121 are complete")
