target = NN(57)
expected_pairs = Set([(1, 57), (3, 19), (19, 3), (57, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 57 has exactly the positive factor pairs", sorted(actual_pairs))
