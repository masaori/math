target = NN(65)
expected_pairs = Set([(1, 65), (5, 13), (13, 5), (65, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 65 has exactly the positive factor pairs", sorted(actual_pairs))
