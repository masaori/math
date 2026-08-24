factor_pairs = [
    (1, 30),
    (2, 15),
    (3, 10),
    (5, 6),
    (6, 5),
    (10, 3),
    (15, 2),
    (30, 1),
]
expected_degree_pairs = [
    (3, 32),
    (4, 17),
    (5, 12),
    (7, 8),
    (8, 7),
    (12, 5),
    (17, 4),
    (32, 3),
]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
