target = NN(34)
expected_pairs = Set([(1, 34), (2, 17), (17, 2), (34, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 34 has exactly the positive factor pairs", sorted(actual_pairs))
