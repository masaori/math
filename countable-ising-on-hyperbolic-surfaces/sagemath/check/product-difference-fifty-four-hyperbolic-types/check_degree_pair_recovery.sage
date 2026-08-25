factor_pairs = [(1, 54), (2, 27), (3, 18), (6, 9), (9, 6), (18, 3), (27, 2), (54, 1)]
expected_degree_pairs = [(3, 56), (4, 29), (5, 20), (8, 11), (11, 8), (20, 5), (29, 4), (56, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
