target = NN(105)
expected_pairs = Set([(1, 105), (3, 35), (5, 21), (7, 15), (15, 7), (21, 5), (35, 3), (105, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 105 are complete")
