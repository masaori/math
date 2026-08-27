target = NN(102)
expected_pairs = Set([(1, 102), (2, 51), (3, 34), (6, 17), (17, 6), (34, 3), (51, 2), (102, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 102 are complete")
