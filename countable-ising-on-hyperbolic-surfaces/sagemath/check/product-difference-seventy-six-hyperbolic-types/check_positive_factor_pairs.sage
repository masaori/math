target = NN(76)
expected_pairs = Set([(1, 76), (2, 38), (4, 19), (19, 4), (38, 2), (76, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 76 has exactly the positive factor pairs", sorted(actual_pairs))
