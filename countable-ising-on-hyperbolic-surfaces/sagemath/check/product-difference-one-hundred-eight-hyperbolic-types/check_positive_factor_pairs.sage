target = NN(108)
actual = Set([(a, target // a) for a in divisors(target)])
expected = Set([
    (1, 108), (2, 54), (3, 36), (4, 27), (6, 18), (9, 12),
    (12, 9), (18, 6), (27, 4), (36, 3), (54, 2), (108, 1),
])

assert actual == expected
print("PASS: the positive factor pairs of 108 are complete")
