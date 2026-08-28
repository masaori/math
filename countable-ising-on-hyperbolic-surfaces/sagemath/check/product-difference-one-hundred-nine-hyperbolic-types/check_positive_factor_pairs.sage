target = NN(109)
actual = Set([(a, target // a) for a in divisors(target)])
expected = Set([(1, 109), (109, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 109 are complete")
