target = NN(38)
expected_pairs = Set([
    (1, 38),
    (2, 19),
    (19, 2),
    (38, 1),
])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 38 has exactly the positive factor pairs", sorted(actual_pairs))
