target = NN(104)
expected_pairs = Set([(1, 104), (2, 52), (4, 26), (8, 13), (13, 8), (26, 4), (52, 2), (104, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 104 are complete")
