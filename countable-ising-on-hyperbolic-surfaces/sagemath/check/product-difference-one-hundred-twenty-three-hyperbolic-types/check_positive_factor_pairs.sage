target = NN(123)
actual = Set((a, target // a) for a in divisors(target))
expected = Set([(1, 123), (3, 41), (41, 3), (123, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 123 are complete")
