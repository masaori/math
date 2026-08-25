target = NN(55)
expected_pairs = Set([(1, 55), (5, 11), (11, 5), (55, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 55 has exactly the positive factor pairs", sorted(actual_pairs))
