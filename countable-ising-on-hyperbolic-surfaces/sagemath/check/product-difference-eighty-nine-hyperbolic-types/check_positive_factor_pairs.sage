target = NN(89)
expected_pairs = Set([(1, 89), (89, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 89 are complete")
