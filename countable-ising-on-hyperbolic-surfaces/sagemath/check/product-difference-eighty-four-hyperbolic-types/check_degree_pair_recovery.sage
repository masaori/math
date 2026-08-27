factor_pairs = [
    (1, 84), (2, 42), (3, 28), (4, 21), (6, 14), (7, 12),
    (12, 7), (14, 6), (21, 4), (28, 3), (42, 2), (84, 1),
]
expected_degree_pairs = [
    (3, 86), (4, 44), (5, 30), (6, 23), (8, 16), (9, 14),
    (14, 9), (16, 8), (23, 6), (30, 5), (44, 4), (86, 3),
]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding two recovers exactly the classified degree pairs")
