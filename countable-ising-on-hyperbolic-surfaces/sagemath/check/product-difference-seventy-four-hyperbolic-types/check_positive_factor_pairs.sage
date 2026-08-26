target = NN(74)
expected_pairs = Set([(1, 74), (2, 37), (37, 2), (74, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 74 has exactly the positive factor pairs", sorted(actual_pairs))
