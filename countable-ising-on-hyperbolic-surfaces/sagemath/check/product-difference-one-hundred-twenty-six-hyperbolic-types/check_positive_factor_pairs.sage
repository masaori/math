target = NN(126)
actual = Set((a, target // a) for a in divisors(target))
expected = Set([
    (1, 126), (2, 63), (3, 42), (6, 21), (7, 18), (9, 14),
    (14, 9), (18, 7), (21, 6), (42, 3), (63, 2), (126, 1),
])

assert actual == expected
print("PASS: the positive factor pairs of 126 are complete")
