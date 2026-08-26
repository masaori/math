target = NN(62)
expected_pairs = Set([(1, 62), (2, 31), (31, 2), (62, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 62 has exactly the positive factor pairs", sorted(actual_pairs))
