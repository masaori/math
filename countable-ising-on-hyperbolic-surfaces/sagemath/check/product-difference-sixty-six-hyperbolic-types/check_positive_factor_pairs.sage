target = NN(66)
expected_pairs = Set([(1, 66), (2, 33), (3, 22), (6, 11), (11, 6), (22, 3), (33, 2), (66, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 66 has exactly the positive factor pairs", sorted(actual_pairs))
