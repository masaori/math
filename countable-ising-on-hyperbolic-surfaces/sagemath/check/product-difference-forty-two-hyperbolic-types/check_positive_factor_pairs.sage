target = NN(42)
expected_pairs = Set([(1, 42), (2, 21), (3, 14), (6, 7), (7, 6), (14, 3), (21, 2), (42, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 42 has exactly the positive factor pairs", sorted(actual_pairs))
