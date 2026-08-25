factor_pairs = [(1, 42), (2, 21), (3, 14), (6, 7), (7, 6), (14, 3), (21, 2), (42, 1)]
expected_degree_pairs = [(3, 44), (4, 23), (5, 16), (8, 9), (9, 8), (16, 5), (23, 4), (44, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
