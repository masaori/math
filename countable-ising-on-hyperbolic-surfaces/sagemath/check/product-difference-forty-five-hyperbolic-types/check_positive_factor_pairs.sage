target = NN(45)
expected_pairs = Set([(1, 45), (3, 15), (5, 9), (9, 5), (15, 3), (45, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 45 has exactly the positive factor pairs", sorted(actual_pairs))
