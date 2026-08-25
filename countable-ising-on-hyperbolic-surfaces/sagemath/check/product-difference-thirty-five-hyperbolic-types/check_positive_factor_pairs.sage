target = NN(35)
expected_pairs = Set([(1, 35), (5, 7), (7, 5), (35, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 35 has exactly the positive factor pairs", sorted(actual_pairs))
