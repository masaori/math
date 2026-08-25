target = NN(51)
expected_pairs = Set([(1, 51), (3, 17), (17, 3), (51, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 51 has exactly the positive factor pairs", sorted(actual_pairs))
