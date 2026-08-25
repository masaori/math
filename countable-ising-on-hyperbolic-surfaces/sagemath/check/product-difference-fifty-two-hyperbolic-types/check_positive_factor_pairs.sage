target = NN(52)
expected_pairs = Set([(1, 52), (2, 26), (4, 13), (13, 4), (26, 2), (52, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 52 has exactly the positive factor pairs", sorted(actual_pairs))
