factor_pairs = [
    (1, 60), (2, 30), (3, 20), (4, 15), (5, 12), (6, 10),
    (10, 6), (12, 5), (15, 4), (20, 3), (30, 2), (60, 1),
]
expected_degree_pairs = [
    (3, 62), (4, 32), (5, 22), (6, 17), (7, 14), (8, 12),
    (12, 8), (14, 7), (17, 6), (22, 5), (32, 4), (62, 3),
]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
