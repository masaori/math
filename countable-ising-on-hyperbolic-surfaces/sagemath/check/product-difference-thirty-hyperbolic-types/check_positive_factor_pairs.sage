expected_pairs = Set([
    (1, 30),
    (2, 15),
    (3, 10),
    (5, 6),
    (6, 5),
    (10, 3),
    (15, 2),
    (30, 1),
])
actual_pairs = Set([(a, 30 // a) for a in divisors(30)])

assert actual_pairs == expected_pairs
print("PASS: positive factor pairs of 30 are exactly", sorted(actual_pairs))
