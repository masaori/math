target = NN(80)
expected_pairs = Set([
    (1, 80), (2, 40), (4, 20), (5, 16), (8, 10),
    (10, 8), (16, 5), (20, 4), (40, 2), (80, 1),
])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 80 has exactly the positive factor pairs", sorted(actual_pairs))
