factor_pairs = [
    (1, 80), (2, 40), (4, 20), (5, 16), (8, 10),
    (10, 8), (16, 5), (20, 4), (40, 2), (80, 1),
]
expected_degree_pairs = [
    (3, 82), (4, 42), (6, 22), (7, 18), (10, 12),
    (12, 10), (18, 7), (22, 6), (42, 4), (82, 3),
]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
