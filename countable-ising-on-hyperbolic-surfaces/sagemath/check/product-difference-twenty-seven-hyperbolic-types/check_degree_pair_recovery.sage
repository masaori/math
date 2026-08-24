factor_pairs = [(1, 27), (3, 9), (9, 3), (27, 1)]
expected_degree_pairs = [(3, 29), (5, 11), (11, 5), (29, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
