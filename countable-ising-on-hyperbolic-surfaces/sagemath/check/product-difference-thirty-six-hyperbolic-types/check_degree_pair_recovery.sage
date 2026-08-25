factor_pairs = [
    (1, 36),
    (2, 18),
    (3, 12),
    (4, 9),
    (6, 6),
    (9, 4),
    (12, 3),
    (18, 2),
    (36, 1),
]
expected_degree_pairs = [
    (3, 38),
    (4, 20),
    (5, 14),
    (6, 11),
    (8, 8),
    (11, 6),
    (14, 5),
    (20, 4),
    (38, 3),
]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
