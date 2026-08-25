target = NN(46)
expected_pairs = Set([(1, 46), (2, 23), (23, 2), (46, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 46 has exactly the positive factor pairs", sorted(actual_pairs))
