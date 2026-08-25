target = NN(39)
expected_pairs = Set([
    (1, 39),
    (3, 13),
    (13, 3),
    (39, 1),
])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 39 has exactly the positive factor pairs", sorted(actual_pairs))
