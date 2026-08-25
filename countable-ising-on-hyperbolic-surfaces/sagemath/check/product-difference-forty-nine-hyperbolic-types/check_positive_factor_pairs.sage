target = NN(49)
expected_pairs = Set([(1, 49), (7, 7), (49, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 49 has exactly the positive factor pairs", sorted(actual_pairs))
