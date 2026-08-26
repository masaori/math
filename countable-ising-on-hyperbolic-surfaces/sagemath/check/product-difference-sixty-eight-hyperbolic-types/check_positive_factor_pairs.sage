target = NN(68)
expected_pairs = Set([(1, 68), (2, 34), (4, 17), (17, 4), (34, 2), (68, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 68 has exactly the positive factor pairs", sorted(actual_pairs))
