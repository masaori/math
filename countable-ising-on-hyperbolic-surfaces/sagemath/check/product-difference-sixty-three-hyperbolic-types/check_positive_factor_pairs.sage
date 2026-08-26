target = NN(63)
expected_pairs = Set([(1, 63), (3, 21), (7, 9), (9, 7), (21, 3), (63, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: 63 has exactly the positive factor pairs", sorted(actual_pairs))
