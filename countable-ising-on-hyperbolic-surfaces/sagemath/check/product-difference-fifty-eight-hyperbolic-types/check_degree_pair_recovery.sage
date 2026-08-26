factor_pairs = [(1, 58), (2, 29), (29, 2), (58, 1)]
expected_degree_pairs = [(3, 60), (4, 31), (31, 4), (60, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
