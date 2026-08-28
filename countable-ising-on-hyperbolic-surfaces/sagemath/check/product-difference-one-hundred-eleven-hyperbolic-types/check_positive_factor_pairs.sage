target = NN(111)
actual = Set([(a, target // a) for a in divisors(target)])
expected = Set([(1, 111), (3, 37), (37, 3), (111, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 111 are complete")
