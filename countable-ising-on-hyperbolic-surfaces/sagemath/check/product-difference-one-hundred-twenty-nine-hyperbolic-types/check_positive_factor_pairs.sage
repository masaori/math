target = NN(129)
actual = Set((a, target // a) for a in divisors(target))
expected = Set([(1, 129), (3, 43), (43, 3), (129, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 129 are complete")
