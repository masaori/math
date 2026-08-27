target = NN(91)
expected_pairs = Set([
    (1, 91), (7, 13), (13, 7), (91, 1),
])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert actual_pairs == expected_pairs
print("PASS: the positive factor pairs of 91 are complete")
