target = NN(60)
expected_pairs = Set([
    (1, 60), (2, 30), (3, 20), (4, 15), (5, 12), (6, 10),
    (10, 6), (12, 5), (15, 4), (20, 3), (30, 2), (60, 1),
])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 60 has exactly the positive factor pairs", sorted(actual_pairs))
