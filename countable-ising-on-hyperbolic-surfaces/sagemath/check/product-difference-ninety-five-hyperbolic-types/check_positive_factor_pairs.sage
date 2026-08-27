target = NN(95)
expected_pairs = Set([
    (1, 95), (5, 19), (19, 5), (95, 1),
])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 95 are complete")
