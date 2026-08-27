target = NN(93)
expected_pairs = Set([
    (1, 93), (3, 31), (31, 3), (93, 1),
])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 93 are complete")
