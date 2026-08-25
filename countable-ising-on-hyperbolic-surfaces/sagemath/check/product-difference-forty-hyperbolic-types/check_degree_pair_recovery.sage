factor_pairs = [(1, 40), (2, 20), (4, 10), (5, 8), (8, 5), (10, 4), (20, 2), (40, 1)]
expected_degree_pairs = [(3, 42), (4, 22), (6, 12), (7, 10), (10, 7), (12, 6), (22, 4), (42, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
