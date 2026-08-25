target = NN(48)
expected_pairs = Set([(1, 48), (2, 24), (3, 16), (4, 12), (6, 8), (8, 6), (12, 4), (16, 3), (24, 2), (48, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 48 has exactly the positive factor pairs", sorted(actual_pairs))
