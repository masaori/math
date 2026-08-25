factor_pairs = [(1, 48), (2, 24), (3, 16), (4, 12), (6, 8), (8, 6), (12, 4), (16, 3), (24, 2), (48, 1)]
expected_degree_pairs = [(3, 50), (4, 26), (5, 18), (6, 14), (8, 10), (10, 8), (14, 6), (18, 5), (26, 4), (50, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
