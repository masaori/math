target = NN(67)
expected_pairs = Set([(1, 67), (67, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 67 has exactly the positive factor pairs", sorted(actual_pairs))
