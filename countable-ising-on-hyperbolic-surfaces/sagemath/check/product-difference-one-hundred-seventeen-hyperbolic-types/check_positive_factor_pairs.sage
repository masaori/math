target = NN(117)
actual = Set((a, target // a) for a in divisors(target))
expected = Set([(1, 117), (3, 39), (9, 13), (13, 9), (39, 3), (117, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 117 are complete")
