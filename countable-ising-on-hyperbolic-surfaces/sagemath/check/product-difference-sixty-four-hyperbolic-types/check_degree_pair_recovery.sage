factor_pairs = [(1, 64), (2, 32), (4, 16), (8, 8), (16, 4), (32, 2), (64, 1)]
expected_degree_pairs = [(3, 66), (4, 34), (6, 18), (10, 10), (18, 6), (34, 4), (66, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
