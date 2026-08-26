target = NN(69)
expected_pairs = Set([(1, 69), (3, 23), (23, 3), (69, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 69 has exactly the positive factor pairs", sorted(actual_pairs))
