target = NN(36)
expected_pairs = Set([
    (1, 36),
    (2, 18),
    (3, 12),
    (4, 9),
    (6, 6),
    (9, 4),
    (12, 3),
    (18, 2),
    (36, 1),
])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 36 has exactly the positive factor pairs", sorted(actual_pairs))
