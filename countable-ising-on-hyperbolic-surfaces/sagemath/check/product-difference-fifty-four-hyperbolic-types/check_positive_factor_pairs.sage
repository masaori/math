target = NN(54)
expected_pairs = Set([(1, 54), (2, 27), (3, 18), (6, 9), (9, 6), (18, 3), (27, 2), (54, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 54 has exactly the positive factor pairs", sorted(actual_pairs))
