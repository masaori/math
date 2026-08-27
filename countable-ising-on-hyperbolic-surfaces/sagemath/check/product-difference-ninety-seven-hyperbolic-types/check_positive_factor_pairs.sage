target = NN(97)
expected_pairs = Set([(1, 97), (97, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 97 are complete")
