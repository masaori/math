target = NN(59)
expected_pairs = Set([(1, 59), (59, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 59 has exactly the positive factor pairs", sorted(actual_pairs))
