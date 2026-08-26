target = NN(58)
expected_pairs = Set([(1, 58), (2, 29), (29, 2), (58, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 58 has exactly the positive factor pairs", sorted(actual_pairs))
