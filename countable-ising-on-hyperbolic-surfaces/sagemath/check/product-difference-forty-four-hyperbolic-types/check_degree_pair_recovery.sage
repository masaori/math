factor_pairs = [(1, 44), (2, 22), (4, 11), (11, 4), (22, 2), (44, 1)]
expected_degree_pairs = [(3, 46), (4, 24), (6, 13), (13, 6), (24, 4), (46, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
