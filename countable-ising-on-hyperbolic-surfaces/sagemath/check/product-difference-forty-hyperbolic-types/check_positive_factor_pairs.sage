target = NN(40)
expected_pairs = Set([
    (1, 40),
    (2, 20),
    (4, 10),
    (5, 8),
    (8, 5),
    (10, 4),
    (20, 2),
    (40, 1),
])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 40 has exactly the positive factor pairs", sorted(actual_pairs))
