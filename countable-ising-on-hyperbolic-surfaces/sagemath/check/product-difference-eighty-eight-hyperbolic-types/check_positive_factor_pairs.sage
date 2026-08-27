target = NN(88)
expected_pairs = Set([
    (1, 88), (2, 44), (4, 22), (8, 11),
    (11, 8), (22, 4), (44, 2), (88, 1),
])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 88 are complete")
