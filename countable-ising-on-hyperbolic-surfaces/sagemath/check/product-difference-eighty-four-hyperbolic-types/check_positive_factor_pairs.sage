target = NN(84)
expected_pairs = Set([
    (1, 84), (2, 42), (3, 28), (4, 21), (6, 14), (7, 12),
    (12, 7), (14, 6), (21, 4), (28, 3), (42, 2), (84, 1),
])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 84 are complete")
