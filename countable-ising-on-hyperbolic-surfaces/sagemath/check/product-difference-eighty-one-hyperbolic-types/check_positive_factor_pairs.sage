target = NN(81)
expected_pairs = Set([
    (1, 81), (3, 27), (9, 9), (27, 3), (81, 1),
])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 81 has exactly the positive factor pairs", sorted(actual_pairs))
