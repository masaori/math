target = NN(70)
expected_pairs = Set([(1, 70), (2, 35), (5, 14), (7, 10),
                      (10, 7), (14, 5), (35, 2), (70, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 70 has exactly the positive factor pairs", sorted(actual_pairs))
