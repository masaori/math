target = NN(132)
actual = Set((a, target // a) for a in divisors(target))
expected = Set([
    (1, 132), (2, 66), (3, 44), (4, 33), (6, 22), (11, 12),
    (12, 11), (22, 6), (33, 4), (44, 3), (66, 2), (132, 1),
])

assert actual == expected
print("PASS: the positive factor pairs of 132 are complete")
