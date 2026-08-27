target = NN(98)
expected_pairs = Set([(1, 98), (2, 49), (7, 14), (14, 7), (49, 2), (98, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 98 are complete")
