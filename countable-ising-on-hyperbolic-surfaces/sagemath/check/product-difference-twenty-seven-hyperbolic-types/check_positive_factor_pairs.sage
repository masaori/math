expected_pairs = Set([(1, 27), (3, 9), (9, 3), (27, 1)])
actual_pairs = Set([(a, 27 // a) for a in divisors(27)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 27 are exactly", sorted(actual_pairs))
