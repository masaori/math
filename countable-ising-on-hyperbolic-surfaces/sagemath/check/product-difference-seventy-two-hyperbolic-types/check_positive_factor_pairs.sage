target = NN(72)
expected_pairs = Set([
    (1, 72), (2, 36), (3, 24), (4, 18), (6, 12), (8, 9),
    (9, 8), (12, 6), (18, 4), (24, 3), (36, 2), (72, 1),
])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 72 has exactly the positive factor pairs", sorted(actual_pairs))
