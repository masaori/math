target = NN(77)
expected_pairs = Set([(1, 77), (7, 11), (11, 7), (77, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 77 has exactly the positive factor pairs", sorted(actual_pairs))
