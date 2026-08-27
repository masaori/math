target = NN(96)
expected_pairs = Set([
    (1, 96), (2, 48), (3, 32), (4, 24), (6, 16), (8, 12),
    (12, 8), (16, 6), (24, 4), (32, 3), (48, 2), (96, 1),
])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 96 are complete")
