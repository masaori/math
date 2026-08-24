target = NN(33)
expected_pairs = Set([(1, 33), (3, 11), (11, 3), (33, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 33 has exactly the positive factor pairs", sorted(actual_pairs))
