target = NN(75)
expected_pairs = Set([(1, 75), (3, 25), (5, 15), (15, 5), (25, 3), (75, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 75 has exactly the positive factor pairs", sorted(actual_pairs))
