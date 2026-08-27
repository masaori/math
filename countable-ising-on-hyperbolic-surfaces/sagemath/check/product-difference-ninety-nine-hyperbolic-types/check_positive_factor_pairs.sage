target = NN(99)
expected_pairs = Set([(1, 99), (3, 33), (9, 11), (11, 9), (33, 3), (99, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 99 are complete")
