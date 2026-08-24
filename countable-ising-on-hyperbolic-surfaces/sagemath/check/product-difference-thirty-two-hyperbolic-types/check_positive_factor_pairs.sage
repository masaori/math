target = NN(32)
expected_pairs = Set([(1, 32), (2, 16), (4, 8), (8, 4), (16, 2), (32, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 32 has exactly the positive factor pairs", sorted(actual_pairs))
