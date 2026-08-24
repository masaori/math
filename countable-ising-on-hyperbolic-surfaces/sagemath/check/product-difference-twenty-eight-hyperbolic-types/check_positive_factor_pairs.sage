expected_pairs = Set([(1, 28), (2, 14), (4, 7), (7, 4), (14, 2), (28, 1)])
actual_pairs = Set([(a, 28 // a) for a in divisors(28)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 28 are exactly", sorted(actual_pairs))
