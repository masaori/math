target = NN(101)
expected_pairs = Set([(1, 101), (101, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 101 are complete")
