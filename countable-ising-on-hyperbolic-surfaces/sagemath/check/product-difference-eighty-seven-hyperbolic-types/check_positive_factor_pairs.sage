target = NN(87)
expected_pairs = Set([
    (1, 87), (3, 29), (29, 3), (87, 1),
])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 87 are complete")
