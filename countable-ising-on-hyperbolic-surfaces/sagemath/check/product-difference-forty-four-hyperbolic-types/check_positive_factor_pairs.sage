target = NN(44)
expected_pairs = Set([(1, 44), (2, 22), (4, 11), (11, 4), (22, 2), (44, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 44 has exactly the positive factor pairs", sorted(actual_pairs))
