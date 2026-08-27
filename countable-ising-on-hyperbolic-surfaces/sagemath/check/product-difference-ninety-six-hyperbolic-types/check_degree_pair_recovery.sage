factor_pairs = [
    (1, 96), (2, 48), (3, 32), (4, 24), (6, 16), (8, 12),
    (12, 8), (16, 6), (24, 4), (32, 3), (48, 2), (96, 1),
]
expected_degree_pairs = [
    (3, 98), (4, 50), (5, 34), (6, 26), (8, 18), (10, 14),
    (14, 10), (18, 8), (26, 6), (34, 5), (50, 4), (98, 3),
]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding two recovers exactly the classified degree pairs")
