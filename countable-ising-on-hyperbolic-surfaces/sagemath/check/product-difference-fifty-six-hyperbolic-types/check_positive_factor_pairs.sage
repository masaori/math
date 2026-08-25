target = NN(56)
expected_pairs = Set([(1, 56), (2, 28), (4, 14), (7, 8), (8, 7), (14, 4), (28, 2), (56, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 56 has exactly the positive factor pairs", sorted(actual_pairs))
