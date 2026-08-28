target = NN(120)
actual = Set((a, target // a) for a in divisors(target))
expected = Set([
    (1, 120), (2, 60), (3, 40), (4, 30),
    (5, 24), (6, 20), (8, 15), (10, 12),
    (12, 10), (15, 8), (20, 6), (24, 5),
    (30, 4), (40, 3), (60, 2), (120, 1),
])

assert actual == expected
print("PASS: the positive factor pairs of 120 are complete")
