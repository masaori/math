target = NN(78)
expected_pairs = Set([(1, 78), (2, 39), (3, 26), (6, 13), (13, 6), (26, 3), (39, 2), (78, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 78 has exactly the positive factor pairs", sorted(actual_pairs))
