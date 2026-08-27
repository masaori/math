target = NN(92)
expected_pairs = Set([
    (1, 92), (2, 46), (4, 23), (23, 4), (46, 2), (92, 1),
])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 92 are complete")
