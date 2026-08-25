target = NN(50)
expected_pairs = Set([(1, 50), (2, 25), (5, 10), (10, 5), (25, 2), (50, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 50 has exactly the positive factor pairs", sorted(actual_pairs))
