target = NN(94)
expected_pairs = Set([
    (1, 94), (2, 47), (47, 2), (94, 1),
])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 94 are complete")
