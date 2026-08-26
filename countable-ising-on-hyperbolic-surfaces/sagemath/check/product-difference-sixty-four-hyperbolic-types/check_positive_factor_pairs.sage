target = NN(64)
expected_pairs = Set([(1, 64), (2, 32), (4, 16), (8, 8), (16, 4), (32, 2), (64, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 64 has exactly the positive factor pairs", sorted(actual_pairs))
