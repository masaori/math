target = NN(82)
expected_pairs = Set([(1, 82), (2, 41), (41, 2), (82, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 82 are complete")
