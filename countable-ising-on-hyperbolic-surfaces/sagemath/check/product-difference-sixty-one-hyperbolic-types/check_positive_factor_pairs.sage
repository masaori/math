target = NN(61)
expected_pairs = Set([(1, 61), (61, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 61 has exactly the positive factor pairs", sorted(actual_pairs))
