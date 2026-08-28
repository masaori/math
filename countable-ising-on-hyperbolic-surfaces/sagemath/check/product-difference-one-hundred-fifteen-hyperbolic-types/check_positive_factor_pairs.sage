target = NN(115)
actual = Set((a, target // a) for a in divisors(target))
expected = Set([(1, 115), (5, 23), (23, 5), (115, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 115 are complete")
