target = NN(83)
expected_pairs = Set([(1, 83), (83, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 83 are complete")
