target = NN(86)
expected_pairs = Set([
    (1, 86), (2, 43), (43, 2), (86, 1),
])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 86 are complete")
