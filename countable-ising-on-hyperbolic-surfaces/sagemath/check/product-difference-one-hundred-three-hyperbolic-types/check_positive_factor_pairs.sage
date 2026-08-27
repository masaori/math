target = NN(103)
expected_pairs = Set([(1, 103), (103, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 103 are complete")
