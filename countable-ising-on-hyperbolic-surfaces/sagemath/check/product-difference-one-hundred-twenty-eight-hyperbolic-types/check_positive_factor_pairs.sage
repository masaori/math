target = NN(128)
actual = Set((a, target // a) for a in divisors(target))
expected = Set([(1, 128), (2, 64), (4, 32), (8, 16),
                (16, 8), (32, 4), (64, 2), (128, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 128 are complete")
