factor_pairs = [(1, 32), (2, 16), (4, 8), (8, 4), (16, 2), (32, 1)]
expected_degree_pairs = [(3, 34), (4, 18), (6, 10), (10, 6), (18, 4), (34, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
