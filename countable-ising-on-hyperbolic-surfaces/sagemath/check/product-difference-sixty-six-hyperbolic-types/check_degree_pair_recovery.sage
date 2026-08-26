factor_pairs = [(1, 66), (2, 33), (3, 22), (6, 11), (11, 6), (22, 3), (33, 2), (66, 1)]
expected_degree_pairs = [(3, 68), (4, 35), (5, 24), (8, 13), (13, 8), (24, 5), (35, 4), (68, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
