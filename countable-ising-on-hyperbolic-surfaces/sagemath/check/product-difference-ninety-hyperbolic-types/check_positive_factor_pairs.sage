target = NN(90)
expected_pairs = Set([
    (1, 90), (2, 45), (3, 30), (5, 18), (6, 15), (9, 10),
    (10, 9), (15, 6), (18, 5), (30, 3), (45, 2), (90, 1),
])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 90 are complete")
