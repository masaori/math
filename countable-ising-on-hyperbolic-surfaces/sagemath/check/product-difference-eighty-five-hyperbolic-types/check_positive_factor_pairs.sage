target = NN(85)
expected_pairs = Set([
    (1, 85), (5, 17), (17, 5), (85, 1),
])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 85 are complete")
